import { I18n } from 'i18n-js';
import translations from '../locales.json';

export const i18n = new I18n();
i18n.store(translations);
i18n.defaultLocale = 'pt';
i18n.enableFallback = true;

i18n.error = function(attr, message) {
  return i18n.t('errors.format', { attribute: attr, message: message });
};

i18n.errorMessage = function(message, options = {}) {
  options = { ...options, ...{ scope: 'errors.messages' } };
  return i18n.t(message, options);
};

function getCookieValue(name) {
  const regex = new RegExp(`(^| )${name}=([^;]+)`);
  const match = document.cookie.match(regex);
  if (match) {
    return match[2];
  }
}
document.addEventListener('turbo:load', () => {
  i18n.locale = getCookieValue('locale');
});
window.i18n = i18n;
