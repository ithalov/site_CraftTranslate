import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import './styles/index.css';

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <React.Suspense fallback={<RouteLoadingScreen />}>
      <App />
    </React.Suspense>
  </React.StrictMode>
);
