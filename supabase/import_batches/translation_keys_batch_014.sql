begin;

  insert into public.translation_keys (
  key_name,
  source_language_id,
  original_text,
  category,
  subcategory,
  context,
  protected_variables,
  protected_terms,
  notes,
  supported_targets,
  status
)
select
  src.key_name,
  (select id from public.languages where lower(code) = 'en' limit 1),
  src.original_text,
  src.category,
  nullif(src.subcategory, ''),
  nullif(src.context, ''),
  coalesce(src.protected_variables, '{}'::text[]),
  coalesce(src.protected_terms, '{}'::text[]),
  nullif(src.notes, ''),
  coalesce(src.supported_targets, '{}'::text[]),
  'active'::public.translation_key_status
from jsonb_to_recordset($$[
  {
    "key_name": "system_messages-error-06-server-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-server-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in this server.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-world-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in the current world.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-region-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in this region.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-session-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in your current session.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-gamemode-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in this game mode.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-event-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in the active event.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-instance-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in this server instance.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-profile-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in your current profile.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-lobby-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the player in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-party-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the party member in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-guild-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the guild member in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-team-member",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the team member in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-moderator",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server moderator in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-new-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the new player in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-returning-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the returning player in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-trader",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the trade participant in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-event-player",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the event participant in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-error-06-match-admin",
    "original_text": "Unable to save your profile. Please contact a moderator. This notice is for the server administrator in this match.",
    "category": "system_messages",
    "subcategory": "error",
    "context": "Shown after a persistent player-data save failure. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-player",
    "original_text": "Settings saved successfully. This notice is for the player in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-server-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in this server.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-player",
    "original_text": "Settings saved successfully. This notice is for the player in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-world-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in the current world.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-player",
    "original_text": "Settings saved successfully. This notice is for the player in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-region-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in this region.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-player",
    "original_text": "Settings saved successfully. This notice is for the player in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-session-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in your current session.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-player",
    "original_text": "Settings saved successfully. This notice is for the player in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-gamemode-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in this game mode.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-player",
    "original_text": "Settings saved successfully. This notice is for the player in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-event-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in the active event.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-player",
    "original_text": "Settings saved successfully. This notice is for the player in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-instance-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in this server instance.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-player",
    "original_text": "Settings saved successfully. This notice is for the player in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-profile-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in your current profile.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-player",
    "original_text": "Settings saved successfully. This notice is for the player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-lobby-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-player",
    "original_text": "Settings saved successfully. This notice is for the player in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-party-member",
    "original_text": "Settings saved successfully. This notice is for the party member in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-guild-member",
    "original_text": "Settings saved successfully. This notice is for the guild member in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-team-member",
    "original_text": "Settings saved successfully. This notice is for the team member in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-moderator",
    "original_text": "Settings saved successfully. This notice is for the server moderator in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-new-player",
    "original_text": "Settings saved successfully. This notice is for the new player in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-returning-player",
    "original_text": "Settings saved successfully. This notice is for the returning player in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-trader",
    "original_text": "Settings saved successfully. This notice is for the trade participant in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-event-player",
    "original_text": "Settings saved successfully. This notice is for the event participant in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-success-07-match-admin",
    "original_text": "Settings saved successfully. This notice is for the server administrator in this match.",
    "category": "system_messages",
    "subcategory": "success",
    "context": "Shown after server-side settings are saved. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-server-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in this server.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-world-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in the current world.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-region-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in this region.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-session-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in your current session.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-gamemode-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in this game mode.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-event-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in the active event.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-instance-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in this server instance.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-profile-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in your current profile.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-lobby-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the player in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-party-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the party member in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-guild-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the guild member in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-team-member",
    "original_text": "You are number {amount} in the login queue. This notice is for the team member in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-moderator",
    "original_text": "You are number {amount} in the login queue. This notice is for the server moderator in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-new-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the new player in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-returning-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the returning player in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-trader",
    "original_text": "You are number {amount} in the login queue. This notice is for the trade participant in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-event-player",
    "original_text": "You are number {amount} in the login queue. This notice is for the event participant in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-queue-08-match-admin",
    "original_text": "You are number {amount} in the login queue. This notice is for the server administrator in this match.",
    "category": "system_messages",
    "subcategory": "queue",
    "context": "Shown while waiting to join a full server. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{amount}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-server-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in this server.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-world-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in the current world.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-region-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in this region.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-session-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in your current session.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-gamemode-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in this game mode.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-event-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in the active event.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-instance-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in this server instance.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-profile-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in your current profile.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-lobby-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the player in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-party-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the party member in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-guild-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the guild member in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-team-member",
    "original_text": "Player data synchronization is still in progress. This notice is for the team member in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-moderator",
    "original_text": "Player data synchronization is still in progress. This notice is for the server moderator in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-new-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the new player in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-returning-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the returning player in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-trader",
    "original_text": "Player data synchronization is still in progress. This notice is for the trade participant in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-event-player",
    "original_text": "Player data synchronization is still in progress. This notice is for the event participant in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-sync-09-match-admin",
    "original_text": "Player data synchronization is still in progress. This notice is for the server administrator in this match.",
    "category": "system_messages",
    "subcategory": "sync",
    "context": "Shown when a feature is accessed before synchronization finishes. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-server-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in this server.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-world-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in the current world.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-region-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in this region.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-session-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in your current session.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-gamemode-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in this game mode.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-event-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in the active event.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-instance-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in this server instance.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-profile-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in your current profile.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-lobby-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in the selected lobby.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the player in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-party-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the party member in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-guild-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the guild member in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-team-member",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the team member in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-moderator",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server moderator in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-new-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the new player in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-returning-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the returning player in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-trader",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the trade participant in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-event-player",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the event participant in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "system_messages-performance-10-match-admin",
    "original_text": "Server TPS is below the recommended threshold. This notice is for the server administrator in this match.",
    "category": "system_messages",
    "subcategory": "performance",
    "context": "Shown to staff or players when server performance degrades. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "TPS"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  }
]$$::jsonb) as src(
  key_name text,
  original_text text,
  category text,
  subcategory text,
  context text,
  notes text,
  protected_variables text[],
  protected_terms text[],
  supported_targets text[]
)
on conflict (key_name) do update set
  source_language_id = excluded.source_language_id,
  original_text = excluded.original_text,
  category = excluded.category,
  subcategory = excluded.subcategory,
  context = excluded.context,
  protected_variables = excluded.protected_variables,
  protected_terms = excluded.protected_terms,
  notes = excluded.notes,
  supported_targets = excluded.supported_targets,
  status = excluded.status,
  updated_at = timezone('utc', now());

commit;
