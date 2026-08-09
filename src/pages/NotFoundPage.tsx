import { RouteErrorState } from '@/components/layout/RouteErrorState';

export function NotFoundPage() {
  return (
    <RouteErrorState
      title="Page not found"
      description="A rota solicitada não existe ou foi movida. Volte para a home ou abra o login."
      actionLabel="Go home"
    />
  );
}
