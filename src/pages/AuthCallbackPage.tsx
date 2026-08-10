import { useEffect, useState } from 'react';
import { Navigate, useLocation, useNavigate } from 'react-router-dom';
import { Card } from '@/components/ui/Card';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { useAuth } from '@/hooks/useAuth';
import { paths } from '@/navigation/paths';
import { supabase, isSupabaseConfigured } from '@/services/supabase';

export function AuthCallbackPage() {
  const { isAuthenticated } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const [error, setError] = useState<string | null>(null);
  const [consumed, setConsumed] = useState(false);

  useEffect(() => {
    let active = true;

    async function finalize() {
      if (!supabase || !isSupabaseConfigured) {
        setError('Supabase is not configured in this environment.');
        setConsumed(true);
        return;
      }

      if (isAuthenticated) {
        if (active) {
          window.history.replaceState({}, document.title, window.location.pathname);
          setConsumed(true);
          navigate(paths.profile, { replace: true });
        }
        return;
      }

      const currentUrl = new URL(window.location.href);
      const code = currentUrl.searchParams.get('code');
      const authError = currentUrl.searchParams.get('error_description') ?? currentUrl.searchParams.get('error');
      const handledCodeKey = 'chattranslate_oauth_handled_code';

      if (authError) {
        if (authError.includes('flow_state_already_used')) {
          const { data } = await supabase.auth.getSession();

          if (!active) {
            return;
          }

          if (data.session) {
            window.history.replaceState({}, document.title, currentUrl.pathname);
            setConsumed(true);
            navigate(paths.profile, { replace: true });
            return;
          }
        }

        setError(authError);
        setConsumed(true);
        return;
      }

      if (code) {
        const previouslyHandledCode = window.sessionStorage.getItem(handledCodeKey);

        if (previouslyHandledCode === code) {
          window.history.replaceState({}, document.title, currentUrl.pathname);
          setConsumed(true);
          navigate(paths.profile, { replace: true });
          return;
        }

        const { error: exchangeError } = await supabase.auth.exchangeCodeForSession(code);
        if (!active) {
          return;
        }

        if (exchangeError) {
          if (exchangeError.message.includes('flow_state_already_used')) {
            const { data } = await supabase.auth.getSession();

            if (!active) {
              return;
            }

            if (data.session) {
              window.sessionStorage.setItem(handledCodeKey, code);
              window.history.replaceState({}, document.title, currentUrl.pathname);
              setConsumed(true);
              navigate(paths.profile, { replace: true });
              return;
            }
          }

          setError(exchangeError.message);
          setConsumed(true);
          return;
        }

        window.sessionStorage.setItem(handledCodeKey, code);
        window.history.replaceState({}, document.title, currentUrl.pathname);
      }

      if (active) {
        setConsumed(true);
        navigate(paths.profile, { replace: true });
      }
    }

    void finalize();

    return () => {
      active = false;
    };
  }, [isAuthenticated, navigate]);

  if (isAuthenticated && consumed && !error) {
    return <Navigate to={paths.profile} replace state={{ from: location }} />;
  }

  if (error) {
    return (
      <div className="grid min-h-[70vh] place-items-center px-6">
        <Card className="w-full max-w-xl p-8 text-center">
          <p className="pixel-label text-[10px] text-[#566172]">Discord OAuth</p>
          <h1 className="minecraft-title mt-3 text-4xl text-[#101114]">Login failed</h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error}</p>
          <button
            type="button"
            onClick={() => navigate(paths.login, { replace: true })}
            className="block-button mt-6 px-5 py-3 text-sm"
          >
            Return to login
          </button>
        </Card>
      </div>
    );
  }

  return <RouteLoadingScreen />;
}
