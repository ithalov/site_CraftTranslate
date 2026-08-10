import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Card } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { useAuth } from '@/hooks/useAuth';
import { useAppConfig } from '@/hooks/useAppConfig';
import { paths } from '@/navigation/paths';
import { isSupabaseConfigured } from '@/services/supabase';
import { getRouterBasename } from '@/navigation/basename';

export function LoginPage() {
  const { signInWithDiscord } = useAuth();
  const { appName } = useAppConfig();
  const [isSigningIn, setIsSigningIn] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSignIn = async () => {
    setError(null);
    setIsSigningIn(true);

    try {
      if (!isSupabaseConfigured) {
        throw new Error('Supabase is not configured for this environment.');
      }

      await signInWithDiscord();
    } catch (signInError) {
      setError(signInError instanceof Error ? signInError.message : 'Unable to continue with Discord.');
    } finally {
      setIsSigningIn(false);
    }
  };

  const baseName = getRouterBasename();
  const callbackPath = `${baseName === '/' ? '' : baseName}${paths.authCallback}`;

  return (
    <section className="grid min-h-[70vh] place-items-center py-10">
      <Card className="w-full max-w-2xl overflow-hidden p-0">
        <div className="bg-[#101114] px-8 py-8 text-white">
          <BrandLogo className="h-16 w-auto" />
          <p className="pixel-label mt-4 text-[10px] text-[#c7f464]">Discord gateway</p>
          <h2 className="minecraft-title mt-3 text-4xl leading-none md:text-5xl">
            Join the translation
            <br />
            community.
          </h2>
        </div>
        <div className="p-8 md:p-10">
          <div className="flex flex-wrap items-center gap-2">
            <Badge tone="accent">Player login</Badge>
            <Badge tone="success">secure connection</Badge>
          </div>
          <p className="mt-6 max-w-xl text-base leading-7 text-[#566172]">
            Continue with Discord to contribute translations, review messages and keep your profile
            synced automatically.
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <button
              type="button"
              onClick={() => void handleSignIn()}
              className="block-button px-5 py-3 text-sm transition disabled:cursor-not-allowed disabled:opacity-70"
              disabled={isSigningIn || !isSupabaseConfigured}
            >
              {isSigningIn ? 'Connecting...' : 'Continue with Discord'}
            </button>
            <Link to={paths.home} className="block-button-secondary px-5 py-3 text-sm transition">
              Back home
            </Link>
          </div>
          {error ? (
            <p className="mt-4 text-sm text-[#a83c34]">{error}</p>
          ) : (
            <p className="mt-4 text-xs text-[#566172]">
              Callback: <span className="font-semibold text-[#101114]">{callbackPath}</span>
            </p>
          )}
          <p className="mt-6 text-xs text-[#566172]">
            {appName} never receives or stores Discord passwords.
          </p>
        </div>
      </Card>
    </section>
  );
}
