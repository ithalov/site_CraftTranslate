type ContentSubject = {
  slug: string;
  subject: string;
  category: string;
  subcategory: string;
  context: string;
  protectedTerms?: string[];
};

export type GeneratedTranslationContent = {
  id: string;
  key_name: string;
  source_text: string;
  category: string;
  subcategory: string;
  theme: string;
  context: string;
  notes: string;
  protected_variables: string[];
  protected_terms: string[];
  supported_targets: string[];
};

const targets = ['pt-BR', 'fr', 'es', 'de', 'ru', 'ko', 'ja'];

const questionSubjects: ContentSubject[] = [
  { slug: 'spawn', subject: 'spawn', category: 'minecraft', subcategory: 'chat', context: 'Player chat near the server spawn.', protectedTerms: ['spawn'] },
  { slug: 'village', subject: 'the village', category: 'minecraft', subcategory: 'exploration', context: 'Player exploration chat.' },
  { slug: 'nether-portal', subject: 'the Nether portal', category: 'minecraft', subcategory: 'exploration', context: 'Player coordinating a Nether trip.', protectedTerms: ['Nether'] },
  { slug: 'boss-arena', subject: 'the boss arena', category: 'mmorpg', subcategory: 'party', context: 'Party coordination before a boss fight.' },
  { slug: 'market', subject: 'the market', category: 'economy', subcategory: 'market', context: 'Player asking about the server market.' },
  { slug: 'auction-house', subject: 'the auction house', category: 'trading', subcategory: 'auction', context: 'Trading channel question.', protectedTerms: ['auction house'] },
  { slug: 'pvp-arena', subject: 'the PvP arena', category: 'pvp', subcategory: 'arena', context: 'Player asking about the PvP arena.', protectedTerms: ['PvP'] },
  { slug: 'dungeon', subject: 'the dungeon entrance', category: 'mmorpg', subcategory: 'dungeon', context: 'Party finder and dungeon chat.' },
  { slug: 'guild-hall', subject: 'the guild hall', category: 'community', subcategory: 'guild', context: 'Guild coordination message.', protectedTerms: ['guild'] },
  { slug: 'quest-board', subject: 'the quest board', category: 'mmorpg', subcategory: 'quests', context: 'Player looking for a quest objective.' }
];

const questionTemplates = [
  'Can someone show me where {subject} is?',
  'Does anyone know how to reach {subject}?',
  'Is {subject} safe for a new player?',
  'Can I join a group going to {subject}?',
  'What is the fastest route to {subject}?',
  'Do I need special gear for {subject}?',
  'Is there a guide for {subject}?',
  'Who wants to explore {subject} with me?',
  'Can you mark {subject} on the map?',
  'When does the event at {subject} start?'
];

const phraseSubjects: ContentSubject[] = [
  { slug: 'welcome', subject: 'Welcome to the server!', category: 'system_messages', subcategory: 'welcome', context: 'Welcome broadcast for a newly connected player.' },
  { slug: 'rules', subject: 'Please read the rules before playing.', category: 'system_messages', subcategory: 'rules', context: 'Server rules reminder.' },
  { slug: 'daily-reward', subject: 'Your daily reward is ready to claim.', category: 'economy', subcategory: 'rewards', context: 'Daily reward notification.' },
  { slug: 'trade-request', subject: 'Trade request sent successfully.', category: 'trading', subcategory: 'requests', context: 'Trading action confirmation.' },
  { slug: 'party-invite', subject: 'You have been invited to a party.', category: 'mmorpg', subcategory: 'party', context: 'Party invite notification.', protectedTerms: ['party'] },
  { slug: 'pvp-countdown', subject: 'The PvP match begins in {seconds} seconds.', category: 'pvp', subcategory: 'match', context: 'PvP match countdown.', protectedTerms: ['PvP'] },
  { slug: 'home-command', subject: 'Teleporting you home in {seconds} seconds.', category: 'commands', subcategory: 'teleport', context: 'Home command countdown.' },
  { slug: 'claim-protection', subject: 'This land is protected by {player}.', category: 'system_messages', subcategory: 'protection', context: 'Land protection warning.' },
  { slug: 'mining-level', subject: 'Your mining level increased to {level}.', category: 'minecraft', subcategory: 'skills', context: 'Mining skill progression notification.' },
  { slug: 'quest-complete', subject: 'Quest complete: {quest}.', category: 'mmorpg', subcategory: 'quests', context: 'Quest completion message.' },
  { slug: 'guild-level', subject: 'Your guild reached level {level}.', category: 'community', subcategory: 'guild', context: 'Guild progression announcement.', protectedTerms: ['guild'] },
  { slug: 'auction-win', subject: 'You won the auction for {item}.', category: 'trading', subcategory: 'auction', context: 'Auction result notification.', protectedTerms: ['auction'] },
  { slug: 'economy-balance', subject: 'Your balance is now {amount}.', category: 'economy', subcategory: 'balance', context: 'Economy balance update.' },
  { slug: 'mod-update', subject: 'A new mod update is available.', category: 'mods', subcategory: 'updates', context: 'Modpack update notification.', protectedTerms: ['mod'] },
  { slug: 'resource-pack', subject: 'The resource pack is downloading.', category: 'mods', subcategory: 'resource-pack', context: 'Resource pack loading status.', protectedTerms: ['resource pack'] },
  { slug: 'server-restart', subject: 'The server restarts in {minutes} minutes.', category: 'system_messages', subcategory: 'maintenance', context: 'Scheduled maintenance warning.' },
  { slug: 'friend-online', subject: '{player} is now online.', category: 'community', subcategory: 'friends', context: 'Friend presence notification.' },
  { slug: 'chat-filter', subject: 'Your message was blocked by the chat filter.', category: 'system_messages', subcategory: 'moderation', context: 'Chat moderation feedback.' },
  { slug: 'crate-key', subject: 'You received a crate key.', category: 'economy', subcategory: 'rewards', context: 'Reward inventory notification.', protectedTerms: ['crate key'] },
  { slug: 'season-pass', subject: 'Your season pass tier is complete.', category: 'mmorpg', subcategory: 'season', context: 'Season pass progress notification.' }
];

const phraseTemplates = [
  '{subject}',
  '{subject} Keep the protected tokens unchanged.',
  '{subject} Check your inventory for more details.',
  '{subject} You can continue playing now.',
  '{subject} Ask a moderator if you need help.',
  '{subject} This action cannot be undone.',
  '{subject} Thank you for contributing to the community.',
  '{subject} Please wait a moment before trying again.',
  '{subject} Your progress has been saved.',
  '{subject} Open the menu to view the next step.'
];

function getTokens(text: string) {
  return [...new Set(text.match(/\{[a-zA-Z0-9_]+\}|%[sd]/g) ?? [])];
}

function buildQuestionContent(): GeneratedTranslationContent[] {
  return questionSubjects.flatMap((subject) =>
    questionTemplates.map((template, index) => {
      const sourceText = template.replace('{subject}', subject.subject);

      return {
        id: `batch.question.${subject.slug}.${index + 1}`,
        key_name: `batch.question.${subject.slug}.${index + 1}`,
        source_text: sourceText,
        category: subject.category,
        subcategory: subject.subcategory,
        theme: 'minecraft-community',
        context: subject.context,
        notes: 'Natural question for community chat. Keep the tone friendly and direct.',
        protected_variables: [],
        protected_terms: subject.protectedTerms ?? [],
        supported_targets: targets
      };
    })
  );
}

function buildPhraseContent(): GeneratedTranslationContent[] {
  return phraseSubjects.flatMap((subject) =>
    phraseTemplates.map((template, index) => {
      const sourceText = template.replace('{subject}', subject.subject);

      return {
        id: `batch.phrase.${subject.slug}.${index + 1}`,
        key_name: `batch.phrase.${subject.slug}.${index + 1}`,
        source_text: sourceText,
        category: subject.category,
        subcategory: subject.subcategory,
        theme: 'minecraft-system',
        context: subject.context,
        notes: 'In-game interface or system message. Preserve variables and protected terms exactly.',
        protected_variables: getTokens(sourceText),
        protected_terms: subject.protectedTerms ?? [],
        supported_targets: targets
      };
    })
  );
}

export const generatedTranslationContent = [...buildQuestionContent(), ...buildPhraseContent()];

export const generatedTranslationContentSummary = {
  questions: 100,
  phrases: 200,
  total: generatedTranslationContent.length
};
