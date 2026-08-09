import { paths } from '@/navigation/paths';

export const publicNavItems = [
  { label: 'Home', to: paths.home },
  { label: 'Dashboard', to: paths.dashboard },
  { label: 'Login', to: paths.login }
];

export const dashboardNavItems = [
  { label: 'Dashboard', to: paths.dashboard },
  { label: 'Languages', to: paths.languages },
  { label: 'Translate', to: paths.translate },
  { label: 'Review', to: paths.review },
  { label: 'Glossary', to: paths.glossary },
  { label: 'Leaderboard', to: paths.leaderboard },
  { label: 'Profile', to: paths.profile },
  { label: 'Admin', to: paths.admin }
];
