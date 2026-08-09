import { Card } from '@/components/ui/Card';

export function RouteLoadingScreen() {
  return (
    <div className="grid min-h-[60vh] place-items-center px-6">
      <Card className="w-full max-w-md p-6 text-center">
        <div className="mx-auto h-12 w-12 animate-pulse rounded-2xl border border-line bg-white/5" />
        <p className="mt-4 text-lg font-semibold text-white">Loading workspace</p>
        <p className="mt-2 text-sm text-slate-400">
          Preparing routes, layout, and session state.
        </p>
      </Card>
    </div>
  );
}
