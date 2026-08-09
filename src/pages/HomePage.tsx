import { Link } from 'react-router-dom';
import { Badge } from '@/components/ui/Badge';
import { Card } from '@/components/ui/Card';
import { MetricCard } from '@/components/ui/MetricCard';
import { ProgressBar } from '@/components/ui/ProgressBar';
import { StatusPill } from '@/components/ui/StatusPill';
import { paths } from '@/navigation/paths';

const chatPreview = [
  { player: 'LunaCraft', message: 'can someone help me at spawn?', translation: 'alguem pode me ajudar no spawn?', color: '#5652ff' },
  { player: 'RedstoneRui', message: 'i found a village!', translation: 'encontrei uma vila!', color: '#2da44e' },
  { player: 'Nox', message: 'trade enchanted books?', translation: 'troca livros encantados?', color: '#ff6b5f' }
];

export function HomePage() {
  return <section className="pb-12">
    <div className="mx-[calc(var(--space-page)*-1)] border-b-2 border-[#101114] bg-[#101114] text-white">
      <div className="mx-auto grid w-full max-w-7xl gap-10 px-[var(--space-page)] py-16 md:py-24 lg:grid-cols-[1.05fr_.95fr] lg:items-center">
        <div className="animate-[block-rise_.7s_ease-out_both]">
          <p className="pixel-label text-xs text-[#c7f464]">Minecraft chat translation</p>
          <h1 className="minecraft-title mt-4 max-w-3xl text-5xl leading-[.94] tracking-[-.06em] sm:text-6xl md:text-7xl">Every player<br />speaks the <span className="text-[#c7f464]">same world.</span></h1>
          <p className="mt-6 max-w-xl text-base leading-8 text-white/70 md:text-lg">A shared translation layer for Minecraft communities. Keep every player in the conversation, whatever language they bring to the server.</p>
          <div className="mt-8 flex flex-wrap gap-3"><Link to={paths.dashboard} className="block-button px-5 py-3 text-sm transition">Open workspace <span aria-hidden="true">-&gt;</span></Link><Link to={paths.login} className="rounded-lg border-2 border-white/80 px-5 py-3 font-[var(--font-display)] text-sm font-bold text-white transition hover:-translate-y-1 hover:bg-white hover:text-[#101114]">Connect Discord</Link></div>
        </div>
        <div className="relative animate-[block-rise_.7s_.14s_ease-out_both]">
          <div className="absolute -inset-5 bg-[radial-gradient(circle_at_20%_15%,rgba(199,244,100,.25),transparent_38%),radial-gradient(circle_at_85%_75%,rgba(76,201,240,.2),transparent_35%)] blur-2xl" />
          <div className="relative overflow-hidden rounded-lg border-2 border-white/90 bg-[#f7f8fb] text-[#101114] shadow-[9px_9px_0_#c7f464]">
            <div className="flex items-center justify-between border-b-2 border-[#101114] px-5 py-4"><div><p className="pixel-label text-[10px] text-[#566172]">Live chat layer</p><h2 className="mt-1 font-[var(--font-display)] text-lg font-bold">survival-world</h2></div><Badge tone="success">online</Badge></div>
            <div className="space-y-3 p-5"><p className="pixel-label text-[10px] text-[#566172]">Translation stream</p>{chatPreview.map((chat) => <div key={chat.player} className="rounded-md border border-[#dfe3ea] bg-white p-3" style={{ borderLeft: `5px solid ${chat.color}` }}><p className="text-sm font-semibold"><span style={{ color: chat.color }}>&lt;{chat.player}&gt;</span> {chat.message}</p><p className="mt-1 text-sm text-[#566172]"><span className="font-bold text-[#2da44e]">PT-BR</span> {chat.translation}</p></div>)}</div>
            <div className="flex items-center justify-between border-t border-[#dfe3ea] bg-[#f0f2f6] px-5 py-3"><span className="pixel-label text-[10px] text-[#566172]">42ms latency</span><span className="pixel-label text-[10px] text-[#566172]">EN to PT-BR</span></div>
          </div>
        </div>
      </div>
    </div>

    <div className="mx-auto w-full max-w-7xl px-[var(--space-page)]">
      <div className="grid gap-4 py-10 sm:grid-cols-3"><MetricCard label="Active languages" value="03" hint="EN / PT / ES" /><MetricCard label="Chat messages" value="∞" hint="community ready" /><MetricCard label="Translation speed" value="42ms" hint="fast by default" /></div>
      <div className="grid gap-12 border-t border-[#dfe3ea] py-16 lg:grid-cols-[.78fr_1.22fr]">
        <div><p className="pixel-label text-xs text-[#566172]">How it works</p><h2 className="minecraft-title mt-3 text-4xl leading-none text-[#101114] md:text-5xl">One chat.<br /><span className="text-[#5652ff]">No language wall.</span></h2><p className="mt-5 max-w-sm leading-7 text-[#566172]">A calm, fast place for communities to translate together and keep game context intact.</p></div>
        <div className="grid gap-4 md:grid-cols-3">{[['01', 'Capture', 'Messages arrive with their original context.'], ['02', 'Translate', 'Players suggest a clear, natural translation.'], ['03', 'Share', 'Approved phrases travel back to the community.']].map(([number, title, copy], index) => <Card key={number} className="p-5 transition duration-200 hover:-translate-x-1 hover:-translate-y-1 hover:shadow-[10px_10px_0_#101114]"><span className="font-[var(--font-display)] text-sm font-bold" style={{ color: ['#4cc9f0', '#5652ff', '#ff6b5f'][index] }}>{number}</span><h3 className="minecraft-title mt-8 text-2xl text-[#101114]">{title}</h3><p className="mt-3 text-sm leading-6 text-[#566172]">{copy}</p></Card>)}</div>
      </div>
      <div className="-mx-[var(--space-page)] bg-[#101114] px-[var(--space-page)] py-16 text-white"><div className="mx-auto grid w-full max-w-7xl gap-10 lg:grid-cols-[.9fr_1.1fr]"><div><p className="pixel-label text-xs text-[#c7f464]">Community pulse</p><h2 className="minecraft-title mt-3 text-4xl leading-none md:text-5xl">Built for the<br />whole server.</h2><p className="mt-5 max-w-md leading-7 text-white/70">From first-time players to trusted reviewers, every contributor has a place in the translation flow.</p><div className="mt-6 flex gap-2"><StatusPill tone="success">community-led</StatusPill><StatusPill tone="accent">discord-ready</StatusPill></div></div><Card className="p-6 text-[#101114]"><p className="pixel-label text-[10px] text-[#566172]">Server progress</p><div className="mt-6 space-y-6"><ProgressBar label="Translation queue" value={82} tone="accent" /><ProgressBar label="Community review" value={64} tone="warning" /><ProgressBar label="Published language packs" value={91} tone="success" /></div></Card></div></div>
    </div>
  </section>;
}
