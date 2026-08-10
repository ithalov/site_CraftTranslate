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
    "key_name": "pvp-duel-06-server-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-server-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in this server.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-world-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in the current world.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-region-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in this region.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-session-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in your current session.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-gamemode-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in this game mode.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-event-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in the active event.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-instance-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in this server instance.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-profile-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in your current profile.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-lobby-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in the selected lobby.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the player in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-party-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the party member in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-guild-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the guild member in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-team-member",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the team member in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-moderator",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server moderator in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-new-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the new player in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-returning-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the returning player in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-trader",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the trade participant in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-event-player",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the event participant in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-duel-06-match-admin",
    "original_text": "{player} won the duel with {amount} health remaining. This notice is for the server administrator in this match.",
    "category": "pvp",
    "subcategory": "duel",
    "context": "Broadcast after a duel ends. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
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
    "key_name": "pvp-spectator-07-server-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-server-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in this server.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-world-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in the current world.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-region-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in this region.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-session-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in your current session.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-gamemode-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in this game mode.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-event-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in the active event.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-instance-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in this server instance.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-profile-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in your current profile.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-lobby-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in the selected lobby.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the player in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-party-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the party member in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-guild-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the guild member in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-team-member",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the team member in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-moderator",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server moderator in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-new-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the new player in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-returning-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the returning player in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-trader",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the trade participant in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-event-player",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the event participant in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-spectator-07-match-admin",
    "original_text": "You are now spectating the PvP match between {player} and {target}. This notice is for the server administrator in this match.",
    "category": "pvp",
    "subcategory": "spectator",
    "context": "Shown when entering spectator mode for a duel. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}",
      "{target}"
    ],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-team_fight-08-server-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-server-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in this server.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: this server.",
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
    "key_name": "pvp-team_fight-08-world-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-world-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in the current world.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: the current world.",
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
    "key_name": "pvp-team_fight-08-region-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-region-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in this region.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: this region.",
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
    "key_name": "pvp-team_fight-08-session-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-session-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in your current session.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: your current session.",
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
    "key_name": "pvp-team_fight-08-gamemode-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-gamemode-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in this game mode.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: this game mode.",
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
    "key_name": "pvp-team_fight-08-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-event-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in the active event.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: the active event.",
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
    "key_name": "pvp-team_fight-08-instance-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-instance-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in this server instance.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: this server instance.",
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
    "key_name": "pvp-team_fight-08-profile-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-profile-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in your current profile.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: your current profile.",
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
    "key_name": "pvp-team_fight-08-lobby-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-lobby-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in the selected lobby.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: the selected lobby.",
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
    "key_name": "pvp-team_fight-08-match-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the player in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: player. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-party-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the party member in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: party member. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-guild-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the guild member in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: guild member. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-team-member",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the team member in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: team member. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-moderator",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server moderator in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server moderator. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-new-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the new player in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: new player. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-returning-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the returning player in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: returning player. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-trader",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the trade participant in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: trade participant. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-event-player",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the event participant in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: event participant. Scope: this match.",
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
    "key_name": "pvp-team_fight-08-match-admin",
    "original_text": "Your team must have {amount} players before the match can start. This notice is for the server administrator in this match.",
    "category": "pvp",
    "subcategory": "team_fight",
    "context": "Shown to a PvP team that lacks enough members. Audience: server administrator. Scope: this match.",
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
    "key_name": "pvp-bounty-09-server-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-server-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in this server.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-world-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in the current world.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-region-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in this region.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-session-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in your current session.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-gamemode-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in this game mode.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-event-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in the active event.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-instance-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in this server instance.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-profile-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in your current profile.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-lobby-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in the selected lobby.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the player in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-party-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the party member in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-guild-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the guild member in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-team-member",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the team member in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-moderator",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server moderator in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-new-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the new player in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-returning-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the returning player in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-trader",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the trade participant in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-event-player",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the event participant in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-bounty-09-match-admin",
    "original_text": "A bounty of {price} has been placed on {target}. This notice is for the server administrator in this match.",
    "category": "pvp",
    "subcategory": "bounty",
    "context": "Shown when a PvP bounty is created. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{price}",
      "{target}"
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
    "key_name": "pvp-ranking-10-server-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-server-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in this server.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-world-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in the current world.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-region-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in this region.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-session-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in your current session.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-gamemode-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in this game mode.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-event-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in the active event.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-instance-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in this server instance.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-profile-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in your current profile.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-lobby-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in the selected lobby.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the player in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-party-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the party member in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-guild-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the guild member in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-team-member",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the team member in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-moderator",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server moderator in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-new-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the new player in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-returning-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the returning player in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-trader",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the trade participant in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-event-player",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the event participant in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
    "key_name": "pvp-ranking-10-match-admin",
    "original_text": "Ranked PvP is disabled while the server is in maintenance mode. This notice is for the server administrator in this match.",
    "category": "pvp",
    "subcategory": "ranking",
    "context": "Shown when ranked matchmaking is temporarily unavailable. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [
      "PvP"
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
