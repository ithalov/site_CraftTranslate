import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { useAuth } from '@/hooks/useAuth';
import { useLocale } from '@/hooks/useLocale';
import { paths } from '@/navigation/paths';
import { isSupabaseConfigured } from '@/services/supabase';

export function LoginPage() {
  const { signInWithDiscord } = useAuth();
  const { locale } = useLocale();
  const [isSigningIn, setIsSigningIn] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const copy = {
    'pt-BR': {
      eyebrow: 'Acesso da comunidade', title: <>Entre. Contribua.<br /><span className="text-[#c7f464]">Conecte jogadores.</span></>, lead: 'Use sua conta Discord para participar das traducoes, revisoes e conquistas da comunidade.',
      primary: 'Continuar com Discord', loading: 'Conectando...', back: 'Voltar ao inicio', secure: 'Conexao protegida', synced: 'Perfil sincronizado',
      benefits: [['Seu perfil', 'Avatar e nome do Discord conectados automaticamente.'], ['Seus idiomas', 'Escolha os idiomas que voce domina e receba tarefas compativeis.'], ['Sua contribuicao', 'Acompanhe XP, reputacao e badges no seu perfil.']],
      privacyTitle: 'Sua conta continua sua.', privacy: 'O ChatTranslate nunca ve, recebe ou armazena sua senha do Discord.', unavailable: 'O login ainda nao esta configurado neste ambiente.', genericError: 'Nao foi possivel conectar ao Discord. Tente novamente.'
    },
    en: {
      eyebrow: 'Community access', title: <>Join. Contribute.<br /><span className="text-[#c7f464]">Connect players.</span></>, lead: 'Use your Discord account to take part in community translations, reviews, and achievements.',
      primary: 'Continue with Discord', loading: 'Connecting...', back: 'Back to home', secure: 'Secure connection', synced: 'Profile synced',
      benefits: [['Your profile', 'Your Discord avatar and name are connected automatically.'], ['Your languages', 'Choose the languages you know and receive compatible work.'], ['Your contribution', 'Follow XP, reputation, and badges in your profile.']],
      privacyTitle: 'Your account stays yours.', privacy: 'ChatTranslate never sees, receives, or stores your Discord password.', unavailable: 'Login is not configured in this environment yet.', genericError: 'Could not connect to Discord. Please try again.'
    },
    es: {
      eyebrow: 'Acceso de comunidad', title: <>Entra. Contribuye.<br /><span className="text-[#c7f464]">Conecta jugadores.</span></>, lead: 'Usa tu cuenta de Discord para participar en traducciones, revisiones y logros de la comunidad.',
      primary: 'Continuar con Discord', loading: 'Conectando...', back: 'Volver al inicio', secure: 'Conexion protegida', synced: 'Perfil sincronizado',
      benefits: [['Tu perfil', 'Tu avatar y nombre de Discord se conectan automaticamente.'], ['Tus idiomas', 'Elige los idiomas que conoces y recibe tareas compatibles.'], ['Tu contribucion', 'Sigue XP, reputacion e insignias en tu perfil.']],
      privacyTitle: 'Tu cuenta sigue siendo tuya.', privacy: 'ChatTranslate nunca ve, recibe ni almacena tu contrasena de Discord.', unavailable: 'El login aun no esta configurado en este entorno.', genericError: 'No se pudo conectar a Discord. Intentalo de nuevo.'
    }
  }[locale];

  async function handleSignIn() {
    setError(null);
    setIsSigningIn(true);

    try {
      if (!isSupabaseConfigured) throw new Error(copy.unavailable);
      await signInWithDiscord();
    } catch (signInError) {
      setError(signInError instanceof Error ? signInError.message : copy.genericError);
      setIsSigningIn(false);
    }
  }

  return (
    <section className="relative grid min-h-[72vh] place-items-center overflow-hidden py-10 md:py-16">
      <div className="pointer-events-none absolute inset-x-0 top-10 mx-auto h-80 max-w-4xl rounded-full bg-[#c7f464]/20 blur-3xl" />
      <div className="relative grid w-full max-w-5xl overflow-hidden rounded-2xl border-2 border-[#101114] bg-white shadow-[9px_9px_0_#101114] lg:grid-cols-[.94fr_1.06fr]">
        <aside className="relative overflow-hidden bg-[#101114] px-7 py-8 text-white md:px-10 md:py-11">
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_15%_12%,rgba(199,244,100,.24),transparent_24%),radial-gradient(circle_at_90%_88%,rgba(76,201,240,.22),transparent_30%)]" />
          <div className="relative">
            <BrandLogo className="h-16 w-auto drop-shadow-[0_10px_20px_rgba(0,0,0,.35)]" />
            <p className="pixel-label mt-10 text-[10px] text-[#c7f464]">{copy.eyebrow}</p>
            <h1 className="minecraft-title mt-3 text-4xl leading-[.94] md:text-5xl">{copy.title}</h1>
            <p className="mt-5 max-w-sm text-sm leading-7 text-white/72">{copy.lead}</p>
            <div className="mt-8 space-y-3">
              {copy.benefits.map(([title, description], index) => <div key={title} className="flex gap-3 rounded-xl border border-white/10 bg-white/[.06] p-3.5"><span className="grid h-7 w-7 shrink-0 place-items-center rounded-lg bg-[#c7f464] font-[var(--font-display)] text-xs font-extrabold text-[#101114]">0{index + 1}</span><span><strong className="block text-sm">{title}</strong><span className="mt-1 block text-xs leading-5 text-white/65">{description}</span></span></div>)}
            </div>
          </div>
        </aside>

        <div className="flex flex-col justify-center px-7 py-9 md:px-10 md:py-11">
          <div className="flex flex-wrap gap-2"><Badge tone="accent">Discord</Badge><Badge tone="success">{copy.secure}</Badge><Badge tone="neutral">{copy.synced}</Badge></div>
          <h2 className="minecraft-title mt-7 text-3xl leading-none text-[#101114]">{locale === 'pt-BR' ? 'Sua jornada comeca aqui.' : locale === 'es' ? 'Tu camino comienza aqui.' : 'Your journey starts here.'}</h2>
          <p className="mt-4 max-w-md text-sm leading-7 text-[#566172]">{locale === 'pt-BR' ? 'Em poucos segundos voce tera um perfil pronto para colaborar com as comunidades Minecraft.' : locale === 'es' ? 'En segundos tendras un perfil listo para colaborar con comunidades Minecraft.' : 'In seconds, you will have a profile ready to collaborate with Minecraft communities.'}</p>
          <button type="button" onClick={() => void handleSignIn()} disabled={isSigningIn || !isSupabaseConfigured} className="mt-8 flex w-full items-center justify-center gap-3 rounded-xl border-2 border-[#101114] bg-[#5865F2] px-5 py-4 font-[var(--font-display)] text-sm font-extrabold text-white transition hover:-translate-y-1 hover:shadow-[5px_5px_0_#101114] disabled:cursor-not-allowed disabled:opacity-60"><span className="grid h-6 w-6 place-items-center rounded-md bg-white text-xs font-black text-[#5865F2]">D</span>{isSigningIn ? copy.loading : copy.primary}</button>
          <Link to={paths.home} className="mt-3 text-center text-sm font-bold text-[#566172] transition hover:text-[#101114]">{copy.back}</Link>
          {error ? <p className="mt-6 rounded-xl border border-[#ff6b5f] bg-[#fff0ee] px-4 py-3 text-sm font-medium text-[#a83c34]">{error}</p> : <div className="mt-8 rounded-xl border border-[#dfe3ea] bg-[#f7f8fb] p-4"><p className="text-sm font-extrabold text-[#101114]">{copy.privacyTitle}</p><p className="mt-1 text-xs leading-6 text-[#566172]">{copy.privacy}</p></div>}
        </div>
      </div>
    </section>
  );
}
