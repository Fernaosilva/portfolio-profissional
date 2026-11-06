# Portfólio profissional — Fernando Silva

Portfólio estático com identidade visual v1, sobre ERP TOTVS Protheus, análise de sistemas, implantação e desenvolvimento ADVPL/TLPP. Conteúdo baseado nas informações fornecidas. Inclui Automação da Classificação Fiscal, com indicadores estimados, e Automação de Cadastro de Usuários, com dois indicadores confirmados.

## Arquitetura

Arquitetura híbrida, entendida nesta etapa como páginas HTML estáticas independentes combinadas com dados JSON e comportamento JavaScript compartilhados. Não há SPA, servidor de aplicação, compilação, frameworks, bibliotecas externas ou gerenciadores de pacotes.

```text
portfolio-profissional/
├── .gitignore
├── README.md
├── index.html
├── assets/
│   ├── css/
│   │   └── main.css
│   └── js/
│       └── main.js
├── data/
│   └── i18n/
│       ├── pt-BR.json
│       └── en.json
├── contact/
│   └── index.html
├── projects/
│   ├── index.html
│   ├── automacao-classificacao-fiscal/
│   │   └── index.html
│   ├── automacao-cadastro-usuarios/
│   │   └── index.html
│   ├── sustentacao-estabilizacao-erp/
│   │   └── index.html
│   ├── inventario-governanca-fontes-protheus/
│   │   └── index.html
│   └── padronizacao-versionamento-fontes-protheus/
│       └── index.html
└── lab/
    └── index.html
```

- `index.html`: Hero, Sobre, três pilares profissionais, Competências e Projetos em destaque.
- `contact/`: página dedicada que concentra os canais profissionais e o currículo.
- `projects/`: listagem e páginas estáticas dos estudos de caso aprovados.
- `lab/`: implementação preservada, temporariamente excluída da navegação e da publicação.
- `assets/`: estilos e scripts comuns; futuros recursos visuais também poderão ficar aqui.
- `data/i18n/`: textos em português e inglês, separados do comportamento.

O HTML mantém conteúdo legível em português e links funcionais sem JavaScript. Cada página declara `header`, `nav`, `main` e `footer`, um título principal, link para pular a navegação e indicação da página atual. O CSS compartilhado implementa a identidade visual v1, responsiva, com paleta escura e acentos azul/ciano.

Cabeçalho e rodapé são explícitos em cada HTML para manter a navegação independente do JavaScript; mudanças nesses elementos devem ser replicadas nas páginas existentes.

## Internacionalização

O script carrega os dois JSONs e aplica textos via `data-i18n`, rótulos acessíveis via `data-i18n-aria` e título via `data-title-key`. Usa `textContent`, sem inserir HTML dos dados. As mesmas chaves devem existir nos dois idiomas.

O idioma inicial é português; `?lang=en` abre uma página em inglês e `?lang=pt-BR` em português. Valores desconhecidos usam português. O seletor atualiza textos, título, atributo `lang`, estado dos botões e links internos, preservando o idioma na próxima página. Não há armazenamento persistente nem detecção automática. A troca não altera a URL da página atual; recarregar usa o parâmetro original ou português.

Se os dados falharem, a página permanece em português e mostra uma mensagem de indisponibilidade. Descrições de metadados permanecem em português nesta fundação; SEO multilíngue e URLs específicas por idioma ficam para etapa futura.

## Navegação e contato

O contato está consolidado em `contact/index.html`. A antiga seção da Home foi removida. O menu de todas as páginas e o CTA do Hero usam a rota da nova página com caminhos relativos, mantendo `?lang=` pelo mecanismo atual. O nome Fernando Silva continua levando à Home.

A página reúne e-mail, LinkedIn, WhatsApp e um único download de currículo. E-mail usa `mailto:`; LinkedIn e WhatsApp abrem em nova aba com `rel="noopener noreferrer"` e aviso acessível. Os links dos canais não recebem parâmetros de idioma. Os ícones são SVGs inline decorativos, complementados por texto visível, sem biblioteca ou widget externo.

A foto reutiliza o PNG original da Home, com dimensões explícitas e proporção natural; fica visível acima de 1024 px e oculta em tablet/mobile. O CSS é restrito a `.contact-page`, com grade no desktop, fluxo vertical em telas menores e foco global preservado.

O download mantém integralmente o JavaScript existente. O botão e os atributos `data-cv-download`, `data-contact-channel="resume"` e `data-contact-channels` foram transferidos para a nova página. PT-BR seleciona `assets/documents/fernando-silva-cv-br.pdf`; EN seleciona `assets/documents/fernando-silva-cv-eu.pdf`. O nome original do arquivo é preservado e apenas o currículo fica oculto quando o PDF está indisponível.

Validação da migração: nove páginas, 119 caminhos/âncoras locais e 412 chaves correspondentes por idioma; não restam links para `#contato` e há um único botão de currículo, somente na página dedicada. Conferidos os destinos fornecidos de e-mail, LinkedIn e WhatsApp, rótulos acessíveis, fallback PT e rotas em subdiretório. O script original passou nos testes com DOM/rede simulados para entrada direta PT/EN, alternância, textos/títulos, navegação, canais sem alteração de URL, currículos BR/EU e falha de PDF/rede afetando apenas o currículo. Os cinco artigos foram preservados literalmente; nas páginas existentes, somente os links de contato e a remoção da seção da Home foram alterados. CSS anterior, JavaScript, foto e PDFs foram preservados. Em 375/768 px, as regras ocultam a foto e usam uma coluna; em 1366 px, mostram a foto e usam duas colunas. A revisão visual, o teclado real, a abertura dos serviços, o console e o download real ficaram pendentes porque o navegador falhou ao iniciar. Não há suíte de testes ou etapa de build configurada.

## Identidade visual v1

- Fundo azul-marinho (`#0b1220`), superfícies cinza-azuladas (`#101c2e`), texto claro (`#edf3fb`), secundário (`#a7b4c8`) e acentos ciano/azul (`#69d9ed` / `#84b5ff`).
- Composição editorial: títulos amplos, espaço entre seções, hierarquia de leitura e cards restritos aos pilares e à apresentação da área de projetos.
- Tipografia local: Inter se instalada, seguida de Segoe UI e fontes do sistema. Nenhuma fonte, imagem ou biblioteca é carregada externamente.
- Cabeçalho com monograma tipográfico, nome vinculado à Home, menu ativo sublinhado e seletor PT/EN com rótulos acessíveis completos.
- Grades se reorganizam em telas menores; navegação permanece visível sem menu dependente de JavaScript.
- Foco de teclado destacado e cores de texto com contraste elevado. Apenas transições curtas de cor, respeitando a preferência por movimento reduzido.
- Home, Projetos e Laboratório utilizam os mesmos tokens e componentes. A marca gráfica é tipográfica/CSS, sem fotografia ou logotipo corporativo.
- Projetos em destaque e a listagem Projetos apresentam o primeiro estudo de caso aprovado. O Laboratório mantém seu espaço para futuros experimentos.

## Build de produção e revisão local

A publicação usa somente os arquivos públicos; o Laboratório permanece intacto em `lab/`. A lista `exclude` de `_config.yml` é compartilhada pelo empacotamento local e pelo build Jekyll do GitHub Pages.

No PowerShell, sem instalar dependências:

~~~powershell
Set-Location C:\Workspace\Web_Developer\Projetos\portfolio-profissional
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\build-site.ps1
~~~

O comando libera a execução somente nesse processo, sem alterar a política permanente do Windows. Recria apenas `dist/`, aplica as exclusões, copia os arquivos estáticos sem transformação e testa os links/âncoras usando uma base em subdiretório. Cancela a limpeza se houver links simbólicos/junctions no destino. A saída é ignorada pelo Git. O script não executa Git nem publica o site.

Sirva **`dist/`** para revisar o pacote de produção. Com Python 3 já disponível, uma opção é:

~~~powershell
python -m http.server 8000 --bind 127.0.0.1 --directory dist
~~~

Acesse `http://127.0.0.1:8000/`. Também é possível usar outro servidor HTTP estático apontado para `dist/`.

### Laboratório temporariamente oculto

- Os menus públicos PT-BR/EN e o link adicional da listagem Projetos não apresentam Laboratório.
- O arquivo `lab/index.html`, seus componentes e traduções permanecem preservados para reativação.
- O build não gera `dist/lab/`; portanto, `/lab/` e `/lab/index.html` retornam 404 quando o servidor estático usa o pacote de produção. Não há redirecionamento.
- Servir diretamente a raiz dos **fontes** ainda permite acessar `lab/index.html` para edição local. Essa raiz bruta não é o artefato de publicação.
- Na publicação por branch com Jekyll, manter `_config.yml` ativo. Para publicação de artefato estático/sem Jekyll, utilizar exclusivamente o conteúdo de `dist/`, que já contém `.nojekyll`. A exclusão de arquivos pelo Jekyll está documentada em [GitHub Pages e Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll).
- Para reativar, remover `lab` da lista `exclude`, restaurar os links públicos e gerar novamente o build. A implementação do Laboratório não precisa ser recriada.

Validação pré-publicação: build PowerShell executado com oito páginas públicas e 100 caminhos/âncoras locais válidos. Vinte verificações HTTP reais contra um servidor temporário do pacote retornaram 200 para as páginas preservadas, CSS, JavaScript, traduções, foto e PDFs. `/lab/` e `/lab/index.html` retornaram 404 sem redirecionamento, tanto na raiz quanto em `/portfolio-profissional/`, inclusive com `?lang=en`. O servidor de teste foi encerrado. O Jekyll não foi executado localmente por ausência de Ruby/Jekyll; a exclusão para esse modo usa a configuração oficial documentada acima. Nenhum commit, push ou publicação foi realizado.

### Verificação manual

1. Abra Home, Projetos, os cinco estudos e Contato, inclusive diretamente pelas URLs.
2. Confirme ausência do Laboratório no menu e de links públicos para sua rota.
3. Alterne PT-BR/EN e navegue pelos cards, competências e projeto relacionado.
4. Confira contato e os currículos BR/EU; PDF indisponível deve ocultar apenas o download.
5. Teste teclado, foco, títulos, responsividade e ausência de rolagem horizontal.
6. Confira o console e a rede do navegador.
7. Solicite `/lab/` e `/lab/index.html` no servidor de **`dist/`** e confirme 404.

## Compatibilidade com GitHub Pages

Os links e recursos usam caminhos relativos (`./` e `../`), sem dependência da raiz `/` do domínio. Os JSONs são resolvidos a partir da URL de `assets/js/main.js`, funcionando também nas páginas internas e sob `https://<usuario>.github.io/<repositorio>/`.

Não há roteamento no cliente: todas as páginas correspondem a arquivos `index.html` reais. Novas páginas mais profundas devem ajustar seus caminhos relativos e usar os mesmos recursos compartilhados.

### Publicação futura (não executada)

Após aprovação, publicar o conteúdo de `dist/` como artefato estático do GitHub Pages, preservando seus diretórios relativos. Alternativamente, publicar a raiz dos fontes por branch usando o build Jekyll com `_config.yml`; esse fluxo também exclui o Laboratório. O empacotamento estático foi preparado e executado localmente, sem criar integração de deployment ou publicar.

A localização em `Projetos/` é apenas organização local. Confirmar a raiz selecionada e o modo de publicação ao configurar o repositório. O Jekyll não está instalado neste ambiente; o build local é o empacotamento PowerShell de arquivos estáticos, não uma execução do Jekyll.

## Validação da identidade visual v1

Conferência estática realizada: três páginas, 31 caminhos/âncoras existentes, seis seções na Home, quatro canais de contato ocultos e 71 chaves de tradução correspondentes e não vazias em cada idioma. Os textos de fallback em português correspondem ao JSON; IDs, menu ativo, marca vinculada à Home e destino Contato em subdiretório foram verificados. O JavaScript de internacionalização foi preservado.

O cálculo de contraste das combinações principais de texto/fundo resultou em 7,45:1 ou mais. Isso é uma conferência das cores, não uma auditoria completa de acessibilidade. As regras responsivas, de foco e de redução de movimento foram conferidas no CSS.

A ferramenta de navegador falhou ao iniciar neste ambiente. Renderização real, console, interação com o seletor e comportamento nos tamanhos de tela do roteiro manual ainda precisam ser verificados em navegador. Nenhum commit, push ou publicação foi executado.

## Primeiro estudo de caso — Automação da Classificação Fiscal

A Home e a listagem Projetos usam um card inteiramente clicável, com categoria, descrição, tecnologias e ação traduzidas. A página detalhada está em `projects/automacao-classificacao-fiscal/index.html`. Seu conteúdo em PT-BR e EN está no grupo `fiscal` dos JSONs existentes.

A página reutiliza o cabeçalho, rodapé, CSS e script compartilhados. O fluxograma usa listas semânticas e CSS, sem imagens ou bibliotecas. Os indicadores estão separados e identificados como estimativas/projeções, sem afirmação de resultados atingidos. A descrição da colaboração não apresenta nomes de integrantes, dados internos, código proprietário ou documentos originais.

Para validar com o servidor local iniciado na pasta pai:

- Abrir `http://127.0.0.1:8000/portfolio-profissional/` e clicar no card.
- Abrir diretamente `http://127.0.0.1:8000/portfolio-profissional/projects/automacao-classificacao-fiscal/index.html?lang=en` e recarregar.
- Alternar PT/EN na Home e no estudo; conferir textos, título da aba, retorno a Projetos e navegação até Contato.
- Conferir as duas saídas do fluxograma e o aviso de estimativas nos dois idiomas.
- Em 360 px, 768 px e desktop, verificar card, fluxograma, parágrafos e indicadores, sem rolagem horizontal.
- Retornar à Home e conferir os downloads BR/EU pelo idioma ativo.

O projeto não possui etapa de build, gerenciador de pacotes ou suíte de testes configurada; os arquivos estáticos são servidos diretamente.

Validação desta entrega: quatro páginas, 43 caminhos/âncoras existentes e 128 chaves correspondentes por idioma; conferidos o fallback em português, os rótulos ARIA, a resolução em subdiretório, as sete seções do estudo, os quatro indicadores e as duas saídas do fluxo. O script real foi executado com DOM e rede simulados para conferir entrada direta em PT/EN, alternância, textos, títulos, links, âncora Contato e downloads de currículo BR/EU. As demais seções da Home, o Laboratório e o script compartilhado permaneceram inalterados. A revisão visual em desktop/mobile e o console real continuam pendentes: a ferramenta de navegador falhou ao iniciar.

## Segundo estudo de caso — Automação de Cadastro de Usuários

O Card 2 está na página `projects/index.html` e abre `projects/automacao-cadastro-usuarios/index.html`. A Home e o Card 1 permanecem inalterados. O novo estudo reutiliza o cabeçalho, a navegação, a estrutura em colunas, os cards e o fluxograma HTML/CSS existentes. O conteúdo PT-BR/EN fica no grupo `userAutomation` dos JSONs compartilhados. Nenhuma dependência ou script adicional foi introduzido.

O estudo apresenta a decisão contextual entre automação de interface e API, a atuação profissional, os resultados e as limitações do CSV. Correção de duplicidades e reinício eram manuais. Validação preventiva, identificação de duplicados, controle de progresso e retomada segura são explicitamente identificados como oportunidades de evolução, não funcionalidades implementadas. Os únicos indicadores são aproximadamente 140 usuários cadastrados e seis unidades integradas, apresentados como resultados alcançados.

O link fornecido para o artigo do LinkedIn abre em nova aba com `rel="noopener noreferrer"`, sem widgets ou incorporação. O aviso de abertura em nova aba também é traduzido. Não são publicados CSVs, dados pessoais, credenciais, capturas internas ou código proprietário.

Roteiro de verificação, com o servidor local na pasta pai:

1. Abrir a listagem Projetos e acessar os dois cards por mouse e teclado.
2. Abrir diretamente `http://127.0.0.1:8000/portfolio-profissional/projects/automacao-cadastro-usuarios/index.html?lang=en` e recarregar.
3. Alternar PT/EN na listagem e no estudo; conferir textos, títulos, rótulos acessíveis e retorno à listagem.
4. Conferir em 375 px, 768 px e 1366 px os títulos, as colunas, as duas saídas do fluxo, os indicadores e a ausência de rolagem horizontal.
5. Conferir o link externo sem alteração de URL pelo seletor de idioma e retornar à Home para verificar os currículos BR/EU.

Não existe etapa de build nem suíte de testes configurada: o site permanece estático, sem gerenciador de pacotes.

Validação do Card 2: caminhos e âncoras locais das cinco páginas conferidos em subdiretório, 199 chaves correspondentes por idioma, textos de fallback, IDs e rótulos ARIA verificados. Os testes do script real com DOM/rede simulados passaram para entrada direta PT/EN, alternância de idiomas, os dois cards, textos e títulos, link externo, avisos de operação manual/oportunidades e downloads BR/EU. Home, Card 1, sua página, JavaScript e traduções anteriores permaneceram intactos. As regras responsivas existentes foram conferidas para 375/768/1366 px; a renderização visual, navegação real por teclado, console e medição de rolagem horizontal continuam pendentes porque a ferramenta de navegador falhou ao iniciar.

## Terceiro estudo de caso — Sustentação e Estabilização de ERP

O terceiro card utiliza o grid compacto existente e abre `projects/sustentacao-estabilizacao-erp/index.html`. Textos e rótulos em PT-BR/EN estão no grupo `erpSupport` dos JSONs compartilhados. A página reutiliza navegação, tipografia, componentes e estilos, sem alterações de CSS ou JavaScript.

O conteúdo descreve sustentação, análise de dados com SQL Server e TOTVS Protheus e colaboração com a área Fiscal. O fluxo representa atuação e resolução, não automação. Não são atribuídos desenvolvimento de customizações, atualização direta de banco de dados ou responsabilidade pelas inconsistências a pessoas/equipes/fornecedores.

Os indicadores mantêm as ressalvas fornecidas: cinco novas unidades, mais de 15 notas fiscais de transferência e aproximadamente 250 itens por nota na maioria dos documentos. Não há cálculo de total de itens, economia, horas ou produtividade. O período foi omitido por ausência de confirmação nos dados do projeto.

Verificar a navegação entre os três cards e seus estudos, entrada direta e recarga da nova URL, alternância PT/EN, retorno a Contato e currículos BR/EU. Para revisão visual, usar 375 px, 768 px e 1366 px, conferindo o terceiro card, as sete etapas do fluxo e os três indicadores. Não existe suíte de testes configurada ou etapa de build de produção neste site estático.

Validação desta entrega: seis páginas, 67 caminhos/âncoras locais e 262 chaves correspondentes por idioma conferidos; fallback PT, IDs, rótulos acessíveis e rotas em subdiretório verificados. Testes do script real com DOM/rede simulados passaram para entrada direta PT/EN, alternância, textos, títulos, rótulos, destinos dos três cards e âncora Contato. Os Cards 1 e 2 e suas traduções foram preservados literalmente; hashes confirmaram que Home, estudos anteriores, CSS, JavaScript e PDFs permaneceram intactos. As regras responsivas foram conferidas estaticamente para 375/768/1366 px. A revisão visual, o teclado real, o console e a medição de rolagem horizontal ficaram pendentes porque a ferramenta de navegador falhou ao iniciar.

## Quarto estudo de caso — Inventário e Governança de Fontes Protheus

O Card 4 utiliza o mesmo grid compacto e abre `projects/inventario-governanca-fontes-protheus/index.html`. O grupo `sourceInventory` dos JSONs contém todo o conteúdo PT-BR/EN. Cards e estudos anteriores não foram alterados. O JavaScript compartilhado permanece o mesmo.

O fluxograma reaproveita os componentes de etapas e painéis, adicionando apenas conectores CSS sob `.inventory-flow`. Duas origens independentes — informações extraídas do RPO e inventário dos arquivos ADVPL/TLPP — convergem para processamento e comparação com Python. Em telas pequenas, as origens se empilham com um conector lateral compartilhado, preservando a convergência e a ordem de leitura. O Python não lê diretamente o RPO e a solução não recupera ou descompila o código-fonte original.

Os resultados são entregas qualitativas concluídas: inventário, comparação, identificação de correspondências/divergências e relatórios. Não há indicadores quantitativos inventados. A execução no Python/VS Code foi funcionalmente concluída; empacotamento independente aparece somente como oportunidade de evolução.

A área `case-bottom` mantém espaço para futuros vínculos entre estudos, após a existência e aprovação de suas páginas. Não são criadas rotas antecipadas nem se atribui organização/versionamento automático à ferramenta.

Verificar os quatro cards e seus destinos, a nova URL direta com `?lang=en`, alternância PT/EN, termos técnicos e as duas origens do fluxo. Conferir 375/768/1366 px, com atenção à convergência, aos títulos e às tags. O site não tem build de produção ou suíte de testes configurada e continua sem dependências externas.

Validação desta entrega: sete páginas, 79 caminhos/âncoras locais e 323 chaves correspondentes por idioma; fallback PT, IDs, rótulos acessíveis e resolução em subdiretório conferidos. O script real passou nos testes com DOM/rede simulados para entrada direta PT/EN, alternância, textos, títulos, rótulos, navegação dos quatro cards, âncora Contato e ressalvas técnicas. Os três primeiros cards e suas traduções foram preservados literalmente; hashes confirmaram que Home, estudos anteriores, JavaScript e PDFs permaneceram intactos. O CSS anterior foi preservado, com extensão apenas sob `.inventory-flow`. As regras para 375/768/1366 px foram conferidas estaticamente; a revisão visual, o teclado real, o console e a medição de overflow ficaram pendentes porque o navegador falhou ao iniciar.

## Quinto estudo de caso — Padronização do Versionamento de Fontes Protheus

O Card 5 foi acrescentado após o quarto, no mesmo grid compacto. Abre `projects/padronizacao-versionamento-fontes-protheus/index.html`, com conteúdo PT-BR/EN no grupo `versionControl` dos JSONs. Reutiliza os componentes existentes de cards, seções, etapas e painéis; não altera CSS, JavaScript ou projetos anteriores.

O estudo apresenta implantação e uso prático de Git/GitHub, organização dos fontes, convenções e documentação, incluindo CONTRIBUTING.md. O fluxo de oito etapas representa trabalho técnico, sem atribuir automação, integração automática ou revisão obrigatória. Os três resultados são qualitativos: repositório implantado, fluxo utilizado e práticas documentadas.

A adoção integral pela equipe não é afirmada. Expansão da adoção, aperfeiçoamento de revisão e critérios de aprovação aparecem como oportunidades. A apresentação corporativa não foi publicada; não são atribuídos treinamentos ou apresentações formais sem evidência. Não são expostos endereços privados, branches/commits internos, código proprietário ou métricas inventadas.

O vínculo de projeto relacionado aponta para o estudo existente do Card 4 e preserva `?lang=` por meio de `data-language-link`. O Card 4 não foi alterado.

Verificar os cinco cards, a URL direta do novo estudo com `?lang=en`, troca PT/EN, termos técnicos, o vínculo com o Card 4, os três resultados qualitativos e o fluxo. Conferir 375/768/1366 px, títulos longos e navegação por teclado. Não existe etapa de build de produção nem suíte de testes configurada neste site estático.

Validação desta entrega: oito páginas, 93 caminhos/âncoras locais e 390 chaves correspondentes por idioma; fallback PT, IDs, rótulos acessíveis, três resultados qualitativos, oito etapas e vínculo para o Card 4 conferidos. O script real passou nos testes com DOM/rede simulados para entrada direta PT/EN, alternância, textos, títulos, rótulos, destinos dos cinco cards, âncora Contato e projeto relacionado com idioma preservado. Os quatro cards e todas as traduções anteriores foram preservados literalmente; hashes confirmaram que Home, CSS, JavaScript, foto, PDFs e estudos anteriores ficaram intactos. As regras para 375/768/1366 px foram conferidas estaticamente; renderização, teclado real, console e medição de overflow ficaram pendentes porque o navegador falhou ao iniciar.

## Próxima etapa

- Revisar a identidade visual v1 e fornecer os canais de contato e currículo aprovados.
- Planejar o modelo de dados e o formato das futuras páginas de projetos, sem dados sensíveis.
- Revisar a redação e as traduções com Fernando.
- Definir estratégia de SEO por idioma antes de ampliar o conteúdo.
- Validar a versão aprovada em navegadores e dispositivos reais antes da publicação.
