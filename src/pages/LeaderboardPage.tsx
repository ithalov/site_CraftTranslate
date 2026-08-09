import { ProtectedFeaturePage } from '@/pages/ProtectedFeaturePage';

export function LeaderboardPage() {
  return (
    <ProtectedFeaturePage
      eyebrow="Leaderboard"
      title="Community leaderboard"
      description="Estrutura para engajamento, reputação e contribuições da comunidade."
      items={[
        { title: 'Contributor ranks', description: 'Posição por atividade, qualidade e consistência.' },
        { title: 'Weekly stats', description: 'Base para métricas semanais e campanhas.' },
        { title: 'Rewards lane', description: 'Espaço para badges e reconhecimento.' },
        { title: 'Community health', description: 'Ponto de partida para sinais de qualidade coletiva.' }
      ]}
      progress={[
        { label: 'Contributions', value: 88 },
        { label: 'Quality score', value: 74 },
        { label: 'Participation', value: 61 }
      ]}
    />
  );
}
