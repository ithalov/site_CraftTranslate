import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { LocaleProvider } from '@/contexts/LocaleContext';
import { ThemeProvider } from '@/contexts/ThemeContext';
import { AuthProvider } from '@/contexts/AuthContext';
import { DashboardLayout } from '@/components/layout/DashboardLayout';
import { PublicLayout } from '@/components/layout/PublicLayout';
import { ProtectedRoute } from '@/components/layout/ProtectedRoute';
import { getRouterBasename } from '@/navigation/basename';
import { paths } from '@/navigation/paths';
import { HomePage } from '@/pages/HomePage';
import { StatusPage } from '@/pages/StatusPage';
import { LanguagesPage } from '@/pages/LanguagesPage';
import { LanguageDetailPage } from '@/pages/LanguageDetailPage';
import { TranslatePage } from '@/pages/TranslatePage';
import { ReviewPage } from '@/pages/ReviewPage';
import { GlossaryPage } from '@/pages/GlossaryPage';
import { LeaderboardPage } from '@/pages/LeaderboardPage';
import { ProfilePage } from '@/pages/ProfilePage';
import { DashboardPage } from '@/pages/DashboardPage';
import { LoginPage } from '@/pages/LoginPage';
import { AdminPage } from '@/pages/AdminPage';
import { AuthCallbackPage } from '@/pages/AuthCallbackPage';
import { OnboardingLanguagesPage } from '@/pages/OnboardingLanguagesPage';
import { PublicProfilePage } from '@/pages/PublicProfilePage';
import { NotFoundPage } from '@/pages/NotFoundPage';

export default function App() {
  return (
    <ThemeProvider>
      <LocaleProvider>
        <AuthProvider>
        <BrowserRouter basename={getRouterBasename()}>
          <Routes>
            <Route element={<PublicLayout />}>
              <Route index element={<HomePage />} />
              <Route path={paths.status} element={<StatusPage />} />
              <Route path={paths.login} element={<LoginPage />} />
              <Route path={paths.authCallback} element={<AuthCallbackPage />} />
              <Route path={paths.publicProfile} element={<PublicProfilePage />} />
            </Route>

            <Route element={<ProtectedRoute />}>
              <Route path={paths.onboardingLanguages} element={<OnboardingLanguagesPage />} />
              <Route element={<DashboardLayout />}>
                <Route path={paths.dashboard} element={<DashboardPage />} />
                <Route path={paths.languages} element={<LanguagesPage />} />
                <Route path={paths.languageDetail} element={<LanguageDetailPage />} />
                <Route path={paths.translate} element={<TranslatePage />} />
                <Route path={paths.review} element={<ReviewPage />} />
                <Route path={paths.glossary} element={<GlossaryPage />} />
                <Route path={paths.leaderboard} element={<LeaderboardPage />} />
                <Route path={paths.profile} element={<ProfilePage />} />
              </Route>
            </Route>

            <Route element={<ProtectedRoute requireAdmin />}>
              <Route element={<DashboardLayout />}>
                <Route path={paths.admin} element={<AdminPage />} />
              </Route>
            </Route>

            <Route path="*" element={<NotFoundPage />} />
          </Routes>
        </BrowserRouter>
        </AuthProvider>
      </LocaleProvider>
    </ThemeProvider>
  );
}
