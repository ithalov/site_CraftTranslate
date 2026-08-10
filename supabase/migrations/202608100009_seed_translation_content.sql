-- ChatTranslate content pack: 100 questions + 200 phrases, all sourced in English.
-- Safe to run more than once: existing key names are never overwritten.
begin;

with english as (
  select id from public.languages where lower(code) = 'en' limit 1
),
question_subjects (slug, subject, category, subcategory, context, protected_terms) as (
  values
    ('spawn', 'spawn', 'minecraft', 'chat', 'Player chat near the server spawn.', array['spawn']::text[]),
    ('village', 'the village', 'minecraft', 'exploration', 'Player exploration chat.', array[]::text[]),
    ('nether-portal', 'the Nether portal', 'minecraft', 'exploration', 'Player coordinating a Nether trip.', array['Nether']::text[]),
    ('boss-arena', 'the boss arena', 'mmorpg', 'party', 'Party coordination before a boss fight.', array[]::text[]),
    ('market', 'the market', 'economy', 'market', 'Player asking about the server market.', array[]::text[]),
    ('auction-house', 'the auction house', 'trading', 'auction', 'Trading channel question.', array['auction house']::text[]),
    ('pvp-arena', 'the PvP arena', 'pvp', 'arena', 'Player asking about the PvP arena.', array['PvP']::text[]),
    ('dungeon', 'the dungeon entrance', 'mmorpg', 'dungeon', 'Party finder and dungeon chat.', array[]::text[]),
    ('guild-hall', 'the guild hall', 'community', 'guild', 'Guild coordination message.', array['guild']::text[]),
    ('quest-board', 'the quest board', 'mmorpg', 'quests', 'Player looking for a quest objective.', array[]::text[])
),
question_templates (position, text) as (
  values
    (1, 'Can someone show me where {subject} is?'),
    (2, 'Does anyone know how to reach {subject}?'),
    (3, 'Is {subject} safe for a new player?'),
    (4, 'Can I join a group going to {subject}?'),
    (5, 'What is the fastest route to {subject}?'),
    (6, 'Do I need special gear for {subject}?'),
    (7, 'Is there a guide for {subject}?'),
    (8, 'Who wants to explore {subject} with me?'),
    (9, 'Can you mark {subject} on the map?'),
    (10, 'When does the event at {subject} start?')
),
phrase_subjects (slug, subject, category, subcategory, context, protected_terms) as (
  values
    ('welcome', 'Welcome to the server!', 'system_messages', 'welcome', 'Welcome broadcast for a newly connected player.', array[]::text[]),
    ('rules', 'Please read the rules before playing.', 'system_messages', 'rules', 'Server rules reminder.', array[]::text[]),
    ('daily-reward', 'Your daily reward is ready to claim.', 'economy', 'rewards', 'Daily reward notification.', array[]::text[]),
    ('trade-request', 'Trade request sent successfully.', 'trading', 'requests', 'Trading action confirmation.', array[]::text[]),
    ('party-invite', 'You have been invited to a party.', 'mmorpg', 'party', 'Party invite notification.', array['party']::text[]),
    ('pvp-countdown', 'The PvP match begins in {seconds} seconds.', 'pvp', 'match', 'PvP match countdown.', array['PvP']::text[]),
    ('home-command', 'Teleporting you home in {seconds} seconds.', 'commands', 'teleport', 'Home command countdown.', array[]::text[]),
    ('claim-protection', 'This land is protected by {player}.', 'system_messages', 'protection', 'Land protection warning.', array[]::text[]),
    ('mining-level', 'Your mining level increased to {level}.', 'minecraft', 'skills', 'Mining skill progression notification.', array[]::text[]),
    ('quest-complete', 'Quest complete: {quest}.', 'mmorpg', 'quests', 'Quest completion message.', array[]::text[]),
    ('guild-level', 'Your guild reached level {level}.', 'community', 'guild', 'Guild progression announcement.', array['guild']::text[]),
    ('auction-win', 'You won the auction for {item}.', 'trading', 'auction', 'Auction result notification.', array['auction']::text[]),
    ('economy-balance', 'Your balance is now {amount}.', 'economy', 'balance', 'Economy balance update.', array[]::text[]),
    ('mod-update', 'A new mod update is available.', 'mods', 'updates', 'Modpack update notification.', array['mod']::text[]),
    ('resource-pack', 'The resource pack is downloading.', 'mods', 'resource-pack', 'Resource pack loading status.', array['resource pack']::text[]),
    ('server-restart', 'The server restarts in {minutes} minutes.', 'system_messages', 'maintenance', 'Scheduled maintenance warning.', array[]::text[]),
    ('friend-online', '{player} is now online.', 'community', 'friends', 'Friend presence notification.', array[]::text[]),
    ('chat-filter', 'Your message was blocked by the chat filter.', 'system_messages', 'moderation', 'Chat moderation feedback.', array[]::text[]),
    ('crate-key', 'You received a crate key.', 'economy', 'rewards', 'Reward inventory notification.', array['crate key']::text[]),
    ('season-pass', 'Your season pass tier is complete.', 'mmorpg', 'season', 'Season pass progress notification.', array[]::text[])
),
phrase_templates (position, text) as (
  values
    (1, '{subject}'),
    (2, '{subject} Keep the protected tokens unchanged.'),
    (3, '{subject} Check your inventory for more details.'),
    (4, '{subject} You can continue playing now.'),
    (5, '{subject} Ask a moderator if you need help.'),
    (6, '{subject} This action cannot be undone.'),
    (7, '{subject} Thank you for contributing to the community.'),
    (8, '{subject} Please wait a moment before trying again.'),
    (9, '{subject} Your progress has been saved.'),
    (10, '{subject} Open the menu to view the next step.')
),
content as (
  select
    format('batch.question.%s.%s', qs.slug, qt.position) as key_name,
    replace(qt.text, '{subject}', qs.subject) as original_text,
    qs.category,
    qs.subcategory,
    qs.context,
    array[]::text[] as protected_variables,
    qs.protected_terms,
    'Natural question for community chat. Keep the tone friendly and direct.' as notes
  from question_subjects qs cross join question_templates qt
  union all
  select
    format('batch.phrase.%s.%s', ps.slug, pt.position) as key_name,
    replace(pt.text, '{subject}', ps.subject) as original_text,
    ps.category,
    ps.subcategory,
    ps.context,
    coalesce(array(select distinct (token_match)[1] from regexp_matches(replace(pt.text, '{subject}', ps.subject), '\\{[A-Za-z0-9_]+\\}|%[sd]', 'g') as token_match), array[]::text[]) as protected_variables,
    ps.protected_terms,
    'In-game interface or system message. Preserve variables and protected terms exactly.' as notes
  from phrase_subjects ps cross join phrase_templates pt
)
insert into public.translation_keys (
  key_name, source_language_id, original_text, category, subcategory, context,
  protected_variables, protected_terms, notes, status
)
select
  c.key_name, e.id, c.original_text, c.category, c.subcategory, c.context,
  c.protected_variables, c.protected_terms, c.notes, 'active'::public.translation_key_status
from content c cross join english e
on conflict (key_name) do nothing;

commit;
