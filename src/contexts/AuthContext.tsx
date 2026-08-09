import {
  createContext,
  useContext,
  useEffect,
  useMemo,
  useState,
  type PropsWithChildren
} from 'react';
import type { Session, User } from '@supabase/supabase-js';
import { supabase } from '@/services/supabase';
import type { AuthContextValue, AuthStatus } from '@/types/auth';
import { getRouterBasename } from '@/navigation/basename';
import { paths } from '@/navigation/paths';

const AuthContext = createContext<AuthContextValue | null>(null);

function isAdminUser(user: User | null) {
  const role = user?.app_metadata?.role ?? user?.user_metadata?.role;
  return role === 'admin' || role === 'owner';
}

export function AuthProvider({ children }: PropsWithChildren) {
  const [status, setStatus] = useState<AuthStatus>('loading');
  const [session, setSession] = useState<Session | null>(null);

  useEffect(() => {
    let active = true;

    if (!supabase) {
      setStatus('unauthenticated');
      return;
    }

    supabase.auth
      .getSession()
      .then(({ data }) => {
        if (!active) {
          return;
        }

        setSession(data.session);
        setStatus(data.session ? 'authenticated' : 'unauthenticated');
      })
      .catch(() => {
        if (active) {
          setStatus('unauthenticated');
        }
      });

    const {
      data: { subscription }
    } = supabase.auth.onAuthStateChange((_event, nextSession) => {
      if (!active) {
        return;
      }

      setSession(nextSession);
      setStatus(nextSession ? 'authenticated' : 'unauthenticated');
    });

    return () => {
      active = false;
      subscription.unsubscribe();
    };
  }, []);

  const signInWithDiscord = async () => {
    if (!supabase) {
      return;
    }

    const baseName = getRouterBasename() === '/' ? '' : getRouterBasename();

    await supabase.auth.signInWithOAuth({
      provider: 'discord',
      options: {
        redirectTo: `${window.location.origin}${baseName}${paths.authCallback}`
      }
    });
  };

  const signOut = async () => {
    if (!supabase) {
      setSession(null);
      setStatus('unauthenticated');
      return;
    }

    await supabase.auth.signOut();
  };

  const value = useMemo<AuthContextValue>(
    () => ({
      status,
      session,
      user: session?.user ?? null,
      isAuthenticated: Boolean(session),
      isAdmin: isAdminUser(session?.user ?? null),
      signInWithDiscord,
      signOut
    }),
    [session, status]
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuthContext() {
  const context = useContext(AuthContext);

  if (!context) {
    throw new Error('useAuthContext must be used within AuthProvider');
  }

  return context;
}
