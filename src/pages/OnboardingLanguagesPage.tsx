import { useNavigate } from 'react-router-dom';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { LanguagePreferencesEditor } from '@/components/profile/LanguagePreferencesEditor';
import { useAuth } from '@/hooks/useAuth';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';

export function OnboardingLanguagesPage() {
  const { user } = useAuth();
  const { locale } = useLocale();
  const navigate = useNavigate();
  const copy = {
    'pt-BR': {
      label: 'Configuracao de idiomas', title: 'Monte seu perfil de idiomas antes de entrar na fila.',
      lead: 'O CraftTranslate usa esta etapa para conectar voce a tarefas de traducao e revisao que combinam com suas habilidades. Voce pode alterar tudo depois no perfil.',
      badges: ['Discord conectado', 'Tarefas compativeis', 'Edite quando quiser'], translation: 'Acesso a traducao', translationTitle: 'A partir do intermediario', translationText: 'Somente quem possui nivel Intermediario ou superior recebe tarefas de traducao ao vivo.',
      review: 'Acesso a revisao', reviewTitle: 'Fluente ou nativo', reviewText: 'Tarefas de revisao ficam reservadas para perfis com maior dominio.',
      how: 'Como funciona', steps: [
        ['Escolha os idiomas', 'Adicione cada idioma no qual voce consegue colaborar, mesmo que seja apenas para leitura.'],
        ['Defina seu nivel', 'Seu nivel decide se voce entra em filas de traducao, revisao ou treinamento.'],
        ['Atualize depois', 'O mesmo editor fica disponivel no seu perfil sempre que suas habilidades mudarem.']
      ]
    },
    en: {
      label: 'Language setup', title: 'Build your language profile before joining the queue.',
      lead: 'CraftTranslate uses this step to connect you with translation and review work that matches your skills. You can edit everything later from your profile.',
      badges: ['Discord connected', 'Compatible tasks', 'Editable anytime'], translation: 'Translation access', translationTitle: 'Intermediate or higher', translationText: 'Only members with Intermediate proficiency or higher receive live translation work.',
      review: 'Review access', reviewTitle: 'Fluent or native', reviewText: 'Review work is reserved for profiles with stronger language mastery.',
      how: 'How it works', steps: [
        ['Choose languages', 'Add every language you can work with, even if it is only for reading support.'],
        ['Set your level', 'Your level decides whether you join translation, review, or training queues.'],
        ['Edit later', 'The same editor is always available in your profile when your skills change.']
      ]
    },
    es: {
      label: 'Configuracion de idiomas', title: 'Crea tu perfil de idiomas antes de entrar a la cola.',
      lead: 'CraftTranslate usa este paso para conectarte con tareas que coinciden con tus habilidades. Puedes editar todo despues desde tu perfil.',
      badges: ['Discord conectado', 'Tareas compatibles', 'Editable cuando quieras'], translation: 'Acceso a traduccion', translationTitle: 'Intermedio o superior', translationText: 'Solo usuarios con nivel Intermedio o superior reciben tareas de traduccion en vivo.',
      review: 'Acceso a revision', reviewTitle: 'Fluido o nativo', reviewText: 'Las tareas de revision quedan reservadas para perfiles con mayor dominio.',
      how: 'Como funciona', steps: [
        ['Elige idiomas', 'Agrega cada idioma con el que puedes colaborar, incluso si es solo para lectura.'],
        ['Define tu nivel', 'Tu nivel decide si entras en colas de traduccion, revision o entrenamiento.'],
        ['Edita despues', 'El mismo editor siempre queda disponible en tu perfil.']
      ]
    }
  }[locale];

  if (!user) return null;

  return (
    <section className="page-enter px-[var(--space-page)] py-8 text-text md:py-10">
      <div className="mx-auto grid w-full max-w-7xl gap-7 lg:grid-cols-[0.88fr_1.12fr]">
        <Card className="overflow-hidden p-0 lg:sticky lg:top-6 lg:self-start">
          <div className="relative overflow-hidden bg-[#101114] px-7 py-8 text-white md:px-9 md:py-10">
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_14%_16%,rgba(199,244,100,0.25),transparent_22%),radial-gradient(circle_at_88%_12%,rgba(76,201,240,0.28),transparent_35%),linear-gradient(135deg,rgba(255,255,255,0.04),transparent_60%)]" />
            <div className="relative">
              <BrandLogo className="h-12 w-auto drop-shadow-[0_10px_22px_rgba(0,0,0,0.35)]" />
              <p className="pixel-label mt-8 text-[10px] text-[#c7f464]">{copy.label}</p>
              <h1 className="minecraft-title mt-3 max-w-md text-4xl leading-[.95] md:text-5xl">{copy.title}</h1>
              <p className="mt-5 max-w-xl text-sm leading-7 text-white/75">{copy.lead}</p>
              <div className="mt-7 flex flex-wrap gap-2">{copy.badges.map((badge, index) => <Badge key={badge} tone={index === 0 ? 'accent' : 'neutral'}>{badge}</Badge>)}</div>
              <div className="mt-9 grid gap-3 sm:grid-cols-2 lg:grid-cols-1 xl:grid-cols-2">
                <div className="rounded-2xl border border-white/10 bg-white/[.07] p-4 transition hover:-translate-y-1 hover:bg-white/10">
                  <p className="text-[10px] uppercase tracking-[0.24em] text-white/55">{copy.translation}</p><p className="mt-2 text-lg font-bold text-white">{copy.translationTitle}</p><p className="mt-2 text-sm leading-6 text-white/70">{copy.translationText}</p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/[.07] p-4 transition hover:-translate-y-1 hover:bg-white/10">
                  <p className="text-[10px] uppercase tracking-[0.24em] text-white/55">{copy.review}</p><p className="mt-2 text-lg font-bold text-white">{copy.reviewTitle}</p><p className="mt-2 text-sm leading-6 text-white/70">{copy.reviewText}</p>
                </div>
              </div>
            </div>
          </div>
        </Card>
        <div className="grid gap-6"><LanguagePreferencesEditor userId={user.id} mode="onboarding" onSaved={() => navigate(paths.dashboard, { replace: true })} />
          <Card className="p-6 md:p-8"><p className="pixel-label text-[10px] text-[#566172]">{copy.how}</p><div className="mt-5 grid gap-3 md:grid-cols-3">{copy.steps.map(([title, description], index) => <div key={title} className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4 transition duration-200 hover:-translate-y-1 hover:bg-white hover:shadow-[3px_3px_0_#101114]"><span className="font-[var(--font-display)] text-xs font-extrabold text-[#5652ff]">0{index + 1}</span><p className="mt-3 text-sm font-extrabold text-[#101114]">{title}</p><p className="mt-2 text-sm leading-6 text-[#566172]">{description}</p></div>)}</div></Card>
        </div>
      </div>
    </section>
  );
}
