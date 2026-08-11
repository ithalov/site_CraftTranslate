import { useEffect, useState } from 'react';
import { useLocale } from '@/hooks/useLocale';
import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';
import { fetchPublicStatusData, type PublicStatusData } from '@/services/publicStatus';
import { subscribeToTranslationDataRefresh } from '@/services/translations/translationRefresh';

export function DashboardPage() {
  const { locale } = useLocale();
  const [status, setStatus] = useState<PublicStatusData | null>(null);
  const copy = {
    'pt-BR': {
      eyebrow: 'Painel', title: 'Central de comando', description: 'Acompanhe seu espaco de traducao, atividades e proximas areas de trabalho.',
      items: [
        { title: 'Atividade recente', description: 'Resumo das suas acoes e eventos mais recentes.' },
        { title: 'Qualidade da traducao', description: 'Base para manter clareza, consistencia e velocidade.' },
        { title: 'Sinais da comunidade', description: 'Indicadores de colaboracao, revisao e moderacao.' },
        { title: 'Proximos lancamentos', description: 'Espaco para novidades, metas e marcos do projeto.' }
      ],
      progressTitle: 'Progresso do servidor', progress: [{ label: 'Saude do sistema', value: 84 }, { label: 'Atividade', value: 71 }, { label: 'Prontidao', value: 47 }]
    },
    en: {
      eyebrow: 'Dashboard', title: 'Command center', description: 'Follow your translation workspace, activity, and next areas of work.',
      items: [
        { title: 'Recent activity', description: 'A summary of your latest actions and events.' },
        { title: 'Translation health', description: 'A foundation for clarity, consistency, and speed.' },
        { title: 'Community signals', description: 'Collaboration, review, and moderation indicators.' },
        { title: 'Upcoming releases', description: 'A space for news, goals, and project milestones.' }
      ],
      progressTitle: 'Server progress', progress: [{ label: 'System health', value: 84 }, { label: 'Activity', value: 71 }, { label: 'Readiness', value: 47 }]
    },
    es: {
      eyebrow: 'Panel', title: 'Centro de control', description: 'Acompana tu espacio de traduccion, actividad y proximas areas de trabajo.',
      items: [
        { title: 'Actividad reciente', description: 'Resumen de tus acciones y eventos mas recientes.' },
        { title: 'Calidad de traduccion', description: 'Base para claridad, consistencia y velocidad.' },
        { title: 'Senales de comunidad', description: 'Indicadores de colaboracion, revision y moderacion.' },
        { title: 'Proximos lanzamientos', description: 'Espacio para novedades, metas e hitos del proyecto.' }
      ],
      progressTitle: 'Progreso del servidor', progress: [{ label: 'Salud del sistema', value: 84 }, { label: 'Actividad', value: 71 }, { label: 'Preparacion', value: 47 }]
    }
  }[locale];

  useEffect(() => {
    let active = true;
    const load = () => {
      void fetchPublicStatusData().then((data) => {
        if (active) setStatus(data);
      }).catch(() => undefined);
    };

    load();
    const unsubscribe = subscribeToTranslationDataRefresh(load);
    return () => {
      active = false;
      unsubscribe();
    };
  }, []);

  const liveProgress = status
    ? [
        { label: locale === 'pt-BR' ? 'Traduzido' : locale === 'es' ? 'Traducido' : 'Translated', value: status.summary.translated_percent },
        { label: locale === 'pt-BR' ? 'Revisado' : locale === 'es' ? 'Revisado' : 'Reviewed', value: status.summary.reviewed_percent },
        { label: locale === 'pt-BR' ? 'Oficial' : locale === 'es' ? 'Oficial' : 'Official', value: status.summary.official_percent }
      ]
    : copy.progress;

  return <ProtectedFeaturePage {...copy} progress={liveProgress} />;
}
