export const translationDataRefreshEvent = 'chattranslate:translation-data-refresh';

/** Notifies every screen that reads aggregate translation data after a confirmed write. */
export function notifyTranslationDataRefresh() {
  if (typeof window === 'undefined') {
    return;
  }

  window.dispatchEvent(new Event(translationDataRefreshEvent));
}

export function subscribeToTranslationDataRefresh(listener: () => void) {
  if (typeof window === 'undefined') {
    return () => undefined;
  }

  window.addEventListener(translationDataRefreshEvent, listener);
  return () => window.removeEventListener(translationDataRefreshEvent, listener);
}
