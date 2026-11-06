[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$outputRoot = [IO.Path]::GetFullPath((Join-Path $projectRoot 'dist'))
$configPath = Join-Path $projectRoot '_config.yml'

# O arquivo de configuração é a fonte única das exclusões de publicação.
$excluded = @()
$inExclude = $false
foreach ($line in Get-Content -LiteralPath $configPath -Encoding UTF8) {
    if ($line -match '^exclude:\s*$') { $inExclude = $true; continue }
    if (-not $inExclude -or $line -match '^\s*(#.*)?$') { continue }
    if ($line -match '^\S') { $inExclude = $false; continue }
    if ($line -notmatch '^\s+-\s+([A-Za-z0-9._-]+)\s*$') {
        throw 'Use nomes simples da raiz na lista exclude de _config.yml.'
    }
    $excluded += $Matches[1]
}
foreach ($required in @('scripts', 'dist')) {
    if ($excluded -notcontains $required) { throw "Exclusao obrigatoria ausente: $required" }
}

# Limpeza limitada à pasta gerada, com verificação de caminho e de links.
$expectedOutput = $projectRoot.TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar + 'dist'
if ($outputRoot -ne $expectedOutput -or -not $outputRoot.StartsWith($projectRoot + [IO.Path]::DirectorySeparatorChar)) {
    throw 'Destino de build fora da pasta esperada.'
}
if (Test-Path -LiteralPath $outputRoot) {
    $outputItem = Get-Item -LiteralPath $outputRoot -Force
    if (-not $outputItem.PSIsContainer -or ($outputItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw 'O destino deve ser um diretorio normal, sem links.'
    }
    $resolvedOutput = [IO.Path]::GetFullPath((Resolve-Path -LiteralPath $outputRoot).ProviderPath)
    if ($resolvedOutput -ne $expectedOutput) { throw 'Destino resolvido fora da pasta esperada.' }
    $outputLinks = @(Get-ChildItem -LiteralPath $outputRoot -Recurse -Force |
        Where-Object { $_.Attributes -band [IO.FileAttributes]::ReparsePoint })
    if ($outputLinks.Count) { throw 'O build existente contem links; limpeza cancelada.' }
    Remove-Item -LiteralPath $resolvedOutput -Recurse -Force
}
New-Item -ItemType Directory -Path $outputRoot | Out-Null

foreach ($entry in Get-ChildItem -LiteralPath $projectRoot -Force) {
    if ($entry.Name -match '^[._#~]' -or $entry.Name.EndsWith('~') -or $excluded -contains $entry.Name) { continue }
    if ($entry.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Link nao permitido: $($entry.Name)" }
    if ($entry.PSIsContainer) {
        $sourceLinks = @(Get-ChildItem -LiteralPath $entry.FullName -Recurse -Force |
            Where-Object { $_.Attributes -band [IO.FileAttributes]::ReparsePoint })
        if ($sourceLinks.Count) { throw "Diretorio com links: $($entry.Name)" }
    }
    Copy-Item -LiteralPath $entry.FullName -Destination $outputRoot -Recurse
}
# O artefato já está pronto; não precisa de processamento adicional de Jekyll.
[IO.File]::WriteAllText((Join-Path $outputRoot '.nojekyll'), '')

# Testes do pacote real: rotas relativas, âncoras e ausência de links ao Lab.
$linkCount = 0
$pages = @(Get-ChildItem -LiteralPath $outputRoot -Recurse -Filter *.html -File)
foreach ($page in $pages) {
    $html = [IO.File]::ReadAllText($page.FullName)
    if ($html -match 'data-i18n="(?:common\.lab|projects\.labLink)"') { throw 'Laboratorio na navegacao publica.' }
    $relativePage = $page.FullName.Substring($outputRoot.Length + 1).Replace('\', '/')
    $pageUrl = [Uri]::new([Uri]'https://example.test/portfolio-profissional/', $relativePage)
    foreach ($match in [regex]::Matches($html, '(?:href|src)="([^"]+)"')) {
        $reference = $match.Groups[1].Value
        if ($reference -match '^(?:https?://|mailto:|tel:)') { continue }
        $url = [Uri]::new($pageUrl, $reference)
        if (-not $url.AbsolutePath.StartsWith('/portfolio-profissional/')) { throw "Rota fora do subdiretorio: $reference" }
        $relativeTarget = [Uri]::UnescapeDataString($url.AbsolutePath.Substring('/portfolio-profissional/'.Length))
        if ($relativeTarget.EndsWith('/')) { $relativeTarget += 'index.html' }
        $target = Join-Path $outputRoot $relativeTarget
        if (-not (Test-Path -LiteralPath $target -PathType Leaf)) { throw "Link quebrado: $relativeTarget" }
        if ($url.Fragment -and -not ([IO.File]::ReadAllText($target).Contains('id="' + $url.Fragment.Substring(1) + '"'))) {
            throw "Ancora ausente: $reference"
        }
        $linkCount++
    }
}
if ($excluded -contains 'lab' -and (Test-Path -LiteralPath (Join-Path $outputRoot 'lab'))) {
    throw 'Laboratorio encontrado no pacote publico.'
}
Write-Output "Build concluido: $outputRoot"
Write-Output "PASS: $($pages.Count) paginas, $linkCount caminhos/ancoras locais, exclusoes aplicadas."
