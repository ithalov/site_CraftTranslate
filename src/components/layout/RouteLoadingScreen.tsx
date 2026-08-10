import { Card } from '@/components/ui/Card';

export function RouteLoadingScreen() {
  return (
    <div className="grid min-h-[60vh] place-items-center px-6">
      <Card className="w-full max-w-md p-6 text-center">
        <div className="mx-auto h-12 w-12 animate-pulse rounded-2xl border border-line bg-white/5" />
        <p className="mt-4 text-lg font-semibold text-[#101114]">Carregando seu espaco</p>
        <p className="mt-2 text-sm text-[#566172]">
          Preparando rotas, interface e sessao.
        </p>
      </Card>
    </div>
  );
}
