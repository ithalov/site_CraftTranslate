import { useNavigate } from 'react-router-dom';
import { BrandLogo } from '@/components/branding/BrandLogo';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { LanguagePreferencesEditor } from '@/components/profile/LanguagePreferencesEditor';
import { useAuth } from '@/hooks/useAuth';
import { paths } from '@/navigation/paths';

export function OnboardingLanguagesPage() {
  const { user } = useAuth();
  const navigate = useNavigate();

  if (!user) {
    return null;
  }

  return (
    <section className="px-[var(--space-page)] py-10 text-text">
      <div className="mx-auto grid w-full max-w-7xl gap-8 lg:grid-cols-[0.95fr_1.05fr]">
        <Card className="overflow-hidden p-0">
          <div className="relative overflow-hidden bg-[#101114] px-7 py-8 text-white md:px-9 md:py-10">
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_top,rgba(76,201,240,0.18),transparent_45%),linear-gradient(135deg,rgba(199,244,100,0.12),transparent_60%)]" />
            <div className="relative">
              <BrandLogo className="h-10 w-auto" />
              <p className="pixel-label mt-6 text-[10px] text-[#c7f464]">Language onboarding</p>
              <h1 className="minecraft-title mt-3 max-w-md text-4xl leading-none md:text-5xl">
                Set the languages you know before joining the queue
              </h1>
              <p className="mt-4 max-w-xl text-sm leading-7 text-white/75">
                CraftTranslate uses this step to match you with translation and review tasks that fit
                your actual language skills. You can update everything later from your profile.
              </p>

              <div className="mt-6 flex flex-wrap gap-2">
                <Badge tone="accent">Discord login connected</Badge>
                <Badge tone="neutral">Task-aware routing</Badge>
                <Badge tone="neutral">Editable later</Badge>
              </div>

              <div className="mt-8 grid gap-3 md:grid-cols-2">
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">
                    Translation access
                  </p>
                  <p className="mt-2 text-lg font-bold text-white">Beginner+ not enough</p>
                  <p className="mt-2 text-sm leading-6 text-white/70">
                    Only users with at least Intermediate proficiency receive live translation tasks.
                  </p>
                </div>
                <div className="rounded-2xl border border-white/10 bg-white/5 p-4">
                  <p className="text-[10px] uppercase tracking-[0.3em] text-white/50">
                    Review access
                  </p>
                  <p className="mt-2 text-lg font-bold text-white">Fluent or native</p>
                  <p className="mt-2 text-sm leading-6 text-white/70">
                    Review tasks stay reserved for the strongest language profiles.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </Card>

        <div className="grid gap-6">
          <LanguagePreferencesEditor
            userId={user.id}
            mode="onboarding"
            onSaved={() => {
              navigate(paths.dashboard, { replace: true });
            }}
          />

          <Card className="p-6 md:p-8">
            <p className="pixel-label text-[10px] text-[#566172]">How it works</p>
            <div className="mt-4 grid gap-4 md:grid-cols-3">
              <div className="rounded-xl border-2 border-[#101114] bg-white p-4">
                <p className="text-sm font-bold text-[#101114]">Choose languages</p>
                <p className="mt-2 text-sm leading-6 text-[#566172]">
                  Add every language you can work with, even if one is just for reading or casual
                  translation support.
                </p>
              </div>
              <div className="rounded-xl border-2 border-[#101114] bg-white p-4">
                <p className="text-sm font-bold text-[#101114]">Set proficiency</p>
                <p className="mt-2 text-sm leading-6 text-[#566172]">
                  We use your level to decide whether you enter translation, review, or training
                  queues.
                </p>
              </div>
              <div className="rounded-xl border-2 border-[#101114] bg-white p-4">
                <p className="text-sm font-bold text-[#101114]">Edit later</p>
                <p className="mt-2 text-sm leading-6 text-[#566172]">
                  You can reopen the same editor from your profile anytime and keep your skills
                  up to date.
                </p>
              </div>
            </div>
          </Card>
        </div>
      </div>
    </section>
  );
}
