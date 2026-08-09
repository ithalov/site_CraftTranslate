import { useEffect, useState, type PropsWithChildren } from 'react';
import { Navigate, Outlet, useLocation } from 'react-router-dom';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { useAuth } from '@/hooks/useAuth';
import { paths } from '@/navigation/paths';
import { supabase } from '@/services/supabase';

type ProtectedRouteProps = PropsWithChildren<{
  requireAdmin?: boolean;
}>;

export function ProtectedRoute({ children, requireAdmin = false }: ProtectedRouteProps) {
  const { status, isAuthenticated, isAdmin, user } = useAuth();
  const location = useLocation();
  const [onboardingStatus, setOnboardingStatus] = useState<'loading' | 'complete' | 'required'>(
    'loading'
  );

  useEffect(() => {
    let active = true;

    if (!isAuthenticated || !supabase || !user) {
      setOnboardingStatus('complete');
      return;
    }

    setOnboardingStatus('loading');

    void (async () => {
      try {
        const { count, error } = await supabase
          .from('user_languages')
          .select('id', { count: 'exact', head: true })
          .eq('user_id', user.id);

        if (!active) {
          return;
        }

        if (error) {
          setOnboardingStatus('complete');
          return;
        }

        setOnboardingStatus((count ?? 0) > 0 ? 'complete' : 'required');
      } catch {
        if (active) {
          setOnboardingStatus('complete');
        }
      }
    })();

    return () => {
      active = false;
    };
  }, [isAuthenticated, location.pathname, user]);

  if (status === 'loading' || onboardingStatus === 'loading') {
    return <RouteLoadingScreen />;
  }

  if (!isAuthenticated) {
    return <Navigate to={paths.login} replace state={{ from: location }} />;
  }

  if (requireAdmin && !isAdmin) {
    return <Navigate to={paths.dashboard} replace />;
  }

  if (onboardingStatus === 'required' && location.pathname !== paths.onboardingLanguages) {
    return <Navigate to={paths.onboardingLanguages} replace />;
  }

  if (onboardingStatus === 'complete' && location.pathname === paths.onboardingLanguages) {
    return <Navigate to={paths.dashboard} replace />;
  }

  return children ?? <Outlet />;
}
