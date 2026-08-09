import { useEffect, useMemo, useState } from 'react';
import { Card } from '@/components/ui/Card';
import { Badge } from '@/components/ui/Badge';
import { MetricCard } from '@/components/ui/MetricCard';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { PageShell } from '@/components/page/PageShell';
import { RouteLoadingScreen } from '@/components/layout/RouteLoadingScreen';
import { fetchPublicStatusData, type PublicStatusData } from '@/services/publicStatus';

function formatNumber(value: number) {
  return new Intl.NumberFormat('en-US').format(value);
}

function languageLabel(language: PublicStatusData['languages'][number]) {
  return `${language.code} - ${language.name}`;
}

export function StatusPage() {
  const [data, setData] = useState<PublicStatusData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let active = true;

    async function load() {
      try {
        setLoading(true);
        setError(null);
        const result = await fetchPublicStatusData();

        if (!active) {
          return;
        }

        setData(result);
      } catch (loadError) {
        if (active) {
          setError(loadError instanceof Error ? loadError.message : 'Unable to load project status.');
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    void load();

    return () => {
      active = false;
    };
  }, []);

  const summary = data?.summary ?? {
    total_strings: 0,
    total_languages: 0,
    collaborators: 0,
    total_translations: 0,
    total_reviews: 0,
    translated_percent: 0,
    reviewed_percent: 0,
    official_percent: 0
  };

  const topLanguages = useMemo(() => data?.languages.slice(0, 6) ?? [], [data]);

  if (loading) {
    return <RouteLoadingScreen />;
  }

  if (error) {
    return (
      <PageShell
        eyebrow="Status"
        title="Public project status"
        description="Public metrics and language coverage, without exposing strings."
      >
        <Card className="p-8 text-center">
          <h1 className="minecraft-title text-3xl text-[#101114]">Unable to load status</h1>
          <p className="mt-4 text-sm leading-7 text-[#566172]">{error}</p>
        </Card>
      </PageShell>
    );
  }

  return (
    <PageShell
      eyebrow="Status"
      title="Public project status"
      description="Public metrics from ChatTranslate Web. This page only shows aggregates and language coverage, never string content."
    >
      <div className="space-y-6">
        <Card className="bg-[#101114] p-6 text-white md:p-8">
          <div className="grid gap-6 lg:grid-cols-[1.1fr_.9fr] lg:items-center">
            <div>
              <p className="pixel-label text-[10px] text-[#c7f464]">Anonymous safe overview</p>
              <h2 className="minecraft-title mt-3 text-4xl leading-[.95] md:text-5xl">
                Live status for the translation network.
              </h2>
              <p className="mt-4 max-w-2xl text-sm leading-7 text-white/70 md:text-base">
                Only counts, coverage percentages and public activity signals are shown here. No string bodies, keys or private notes are exposed.
              </p>
              <div className="mt-5 flex flex-wrap gap-2">
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  Public metrics
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  No string content
                </Badge>
                <Badge tone="neutral" className="border-white/10 bg-white/10 text-white">
                  Auto-updated from Supabase
                </Badge>
              </div>
            </div>

            <div className="rounded-3xl border border-white/10 bg-white/5 p-4">
              <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">Coverage snapshot</p>
              <div className="mt-4 space-y-3">
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">Translated</p>
                  <p className="mt-1 text-2xl font-bold text-[#c7f464]">{summary.translated_percent}%</p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">Reviewed</p>
                  <p className="mt-1 text-2xl font-bold text-[#4cc9f0]">{summary.reviewed_percent}%</p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-xs text-white/60">Official</p>
                  <p className="mt-1 text-2xl font-bold text-[#ffb86b]">{summary.official_percent}%</p>
                </div>
              </div>
            </div>
          </div>
        </Card>

        <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
          <MetricCard label="Total strings" value={formatNumber(summary.total_strings)} hint="translation keys" />
          <MetricCard label="Languages" value={formatNumber(summary.total_languages)} hint="active locales" />
          <MetricCard label="Collaborators" value={formatNumber(summary.collaborators)} hint="public profiles" />
          <MetricCard label="Translations" value={formatNumber(summary.total_translations)} hint="suggestions" />
          <MetricCard label="Reviews" value={formatNumber(summary.total_reviews)} hint="quality checks" />
          <MetricCard label="Official coverage" value={`${summary.official_percent}%`} hint="approved strings" />
        </div>

        <Card className="overflow-hidden p-0">
          <div className="border-b-2 border-[#101114] bg-[#c7f464] px-6 py-3">
            <p className="pixel-label text-[10px] text-[#101114]">Language coverage // public progress</p>
          </div>
          <div className="grid gap-4 p-5 md:p-6 xl:grid-cols-2">
            {topLanguages.map((language) => (
              <div key={language.language_id} className="rounded-2xl border border-[#dfe3ea] bg-[#f7f8fb] p-4">
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <p className="font-[var(--font-display)] text-lg font-bold text-[#101114]">{languageLabel(language)}</p>
                    <p className="mt-1 text-sm text-[#566172]">{language.native_name}</p>
                  </div>
                  <Badge tone="accent">{language.official_percent}% official</Badge>
                </div>

                <div className="mt-4 space-y-3">
                  <ProgressBar label="Translated" value={language.translated_percent} tone="accent" />
                  <ProgressBar label="Reviewed" value={language.reviewed_percent} tone="success" />
                  <ProgressBar label="Official" value={language.official_percent} tone="warning" />
                </div>

                <div className="mt-4 grid grid-cols-2 gap-3 text-xs text-[#566172]">
                  <div className="rounded-xl border border-[#dfe3ea] bg-white p-3">
                    <p className="uppercase tracking-[0.25em]">Strings</p>
                    <p className="mt-2 text-lg font-bold text-[#101114]">{formatNumber(Number(language.total_strings ?? 0))}</p>
                  </div>
                  <div className="rounded-xl border border-[#dfe3ea] bg-white p-3">
                    <p className="uppercase tracking-[0.25em]">Approved</p>
                    <p className="mt-2 text-lg font-bold text-[#101114]">{formatNumber(Number(language.official_count ?? 0))}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </Card>
      </div>
    </PageShell>
  );
}
