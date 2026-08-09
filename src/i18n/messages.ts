import type { LocaleCode } from '@/types/locale';

type UiMessages = {
  appName: string;
  foundation: string;
  navLabel: string;
  heroBadge: string;
  title: string;
  lead: string;
  statusTitle: string;
  statusSubtitle: string;
  cards: {
    multilingual: string;
    community: string;
    speed: string;
  };
  metrics: {
    languages: string;
    translations: string;
    uptime: string;
  };
  progress: {
    ingestion: string;
    review: string;
    publish: string;
  };
};

export const messages: Record<LocaleCode, UiMessages> = {
  'pt-BR': {
    appName: 'ChatTranslate Web',
    foundation: 'Fundação',
    navLabel: 'Acesso rápido',
    heroBadge: 'Tradução viva para comunidades globais',
    title: 'Uma identidade digital que parece conversa, não painel genérico.',
    lead:
      'Visual dark, modular e legível, pensado para tradução colaborativa, múltiplos idiomas e evolução sem retrabalho.',
    statusTitle: 'Sistema visual',
    statusSubtitle: 'Tokens prontos para expandir a experiência',
    cards: {
      multilingual: 'Idiomas preparados',
      community: 'Fluxo comunitário',
      speed: 'Leitura rápida'
    },
    metrics: {
      languages: 'Idiomas',
      translations: 'Traduções',
      uptime: 'Confiabilidade'
    },
    progress: {
      ingestion: 'Ingestão',
      review: 'Revisão',
      publish: 'Publicação'
    }
  },
  en: {
    appName: 'ChatTranslate Web',
    foundation: 'Foundation',
    navLabel: 'Quick access',
    heroBadge: 'Living translation for global communities',
    title: 'A digital identity that feels conversational, not like a generic AI dashboard.',
    lead:
      'A dark, modular, highly readable visual system for collaborative translation, multiple languages, and future growth without rewrites.',
    statusTitle: 'Visual system',
    statusSubtitle: 'Tokens ready for interface expansion',
    cards: {
      multilingual: 'Languages ready',
      community: 'Community flow',
      speed: 'Fast scanning'
    },
    metrics: {
      languages: 'Languages',
      translations: 'Translations',
      uptime: 'Reliability'
    },
    progress: {
      ingestion: 'Ingestion',
      review: 'Review',
      publish: 'Publish'
    }
  },
  es: {
    appName: 'ChatTranslate Web',
    foundation: 'Fundación',
    navLabel: 'Acceso rápido',
    heroBadge: 'Traducción viva para comunidades globales',
    title: 'Una identidad digital que se siente conversacional, no un panel genérico de IA.',
    lead:
      'Un sistema visual oscuro, modular y legible, pensado para traducción colaborativa, varios idiomas y crecimiento sin reescrituras.',
    statusTitle: 'Sistema visual',
    statusSubtitle: 'Tokens listos para ampliar la interfaz',
    cards: {
      multilingual: 'Idiomas listos',
      community: 'Flujo comunitario',
      speed: 'Lectura rápida'
    },
    metrics: {
      languages: 'Idiomas',
      translations: 'Traducciones',
      uptime: 'Confiabilidad'
    },
    progress: {
      ingestion: 'Ingesta',
      review: 'Revisión',
      publish: 'Publicación'
    }
  }
};
