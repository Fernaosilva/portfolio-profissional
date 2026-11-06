/* Sem dependências. O endereço dos dados é relativo a este script. */
(() => {
  'use strict';

  const dataBase = new URL('../../data/i18n/', document.currentScript.src);
  const documentsBase = new URL('../documents/', document.currentScript.src);
  const resumeFiles = {
    'pt-BR': 'fernando-silva-cv-br.pdf',
    en: 'fernando-silva-cv-eu.pdf',
  };
  const resumeLink = document.querySelector('[data-cv-download]');
  const resumeItem = document.querySelector('[data-contact-channel="resume"]');
  let resumeRequest = 0;
  const supportedLanguages = ['pt-BR', 'en'];
  const messages = new Map();
  const status = document.querySelector('[data-i18n-status]');

  function translate(dictionary, key) {
    return key.split('.').reduce((value, part) => value?.[part], dictionary);
  }

  async function updateResume(language) {
    // As páginas internas não têm botão de currículo.
    if (!resumeLink || !resumeItem) return;

    const request = ++resumeRequest;
    resumeItem.hidden = true;
    resumeLink.removeAttribute('href');
    resumeLink.removeAttribute('download');

    const filename = resumeFiles[language];
    if (!filename) return;
    const url = new URL(filename, documentsBase);

    try {
      // Verifica disponibilidade sem transferir o PDF inteiro.
      const response = await fetch(url, { method: 'HEAD', cache: 'no-store' });
      // Uma resposta antiga não pode sobrescrever uma troca de idioma recente.
      if (request !== resumeRequest || !response.ok) return;

      resumeLink.href = url.href;
      resumeLink.download = filename;
      resumeItem.hidden = false;
      const channels = resumeItem.closest('[data-contact-channels]');
      if (channels) channels.hidden = false;
    } catch {
      // Apenas o currículo fica oculto; os demais canais não são alterados.
    }
  }

  function setLanguage(language) {
    const dictionary = messages.get(language);
    if (!dictionary) return;

    document.querySelectorAll('[data-i18n]').forEach((element) => {
      const value = translate(dictionary, element.dataset.i18n);
      if (typeof value === 'string') element.textContent = value;
    });
    document.querySelectorAll('[data-i18n-aria]').forEach((element) => {
      const value = translate(dictionary, element.dataset.i18nAria);
      if (typeof value === 'string') element.setAttribute('aria-label', value);
    });
    document.documentElement.lang = language;
    document.title = translate(dictionary, document.body.dataset.titleKey);
    document.querySelectorAll('[data-language]').forEach((button) => {
      button.setAttribute('aria-pressed', String(button.dataset.language === language));
    });
    // Preserva o idioma entre páginas, sem caminhos absolutos na raiz do domínio.
    document.querySelectorAll('[data-language-link]').forEach((link) => {
      const url = new URL(link.href);
      url.searchParams.set('lang', language);
      link.href = url.href;
    });
    updateResume(language);
  }

  async function initialize() {
    try {
      const entries = await Promise.all(supportedLanguages.map(async (language) => {
        const response = await fetch(new URL(`${language}.json`, dataBase));
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        return [language, await response.json()];
      }));
      entries.forEach(([language, dictionary]) => messages.set(language, dictionary));
      const requested = new URL(window.location.href).searchParams.get('lang');
      setLanguage(supportedLanguages.includes(requested) ? requested : 'pt-BR');
      document.querySelectorAll('[data-language]').forEach((button) => {
        button.addEventListener('click', () => setLanguage(button.dataset.language));
      });
      document.querySelector('.language-switch').hidden = false;
    } catch {
      // O HTML em português permanece disponível se os dados não carregarem.
      if (status) status.textContent = 'Traduções indisponíveis. A página continua disponível em português. Para testar localmente, use um servidor HTTP conforme o README.';
    }
  }

  initialize();
})();
