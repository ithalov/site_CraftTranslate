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
    "key_name": "commands-party-01-server-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-server-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in this server.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-world-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in the current world.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-region-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in this region.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-session-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in your current session.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-gamemode-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in this game mode.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-event-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in the active event.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-instance-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in this server instance.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-profile-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in your current profile.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-lobby-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in the selected lobby.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-player",
    "original_text": "Usage: /party invite {player} This notice is for the player in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-party-member",
    "original_text": "Usage: /party invite {player} This notice is for the party member in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-guild-member",
    "original_text": "Usage: /party invite {player} This notice is for the guild member in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-team-member",
    "original_text": "Usage: /party invite {player} This notice is for the team member in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-moderator",
    "original_text": "Usage: /party invite {player} This notice is for the server moderator in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-new-player",
    "original_text": "Usage: /party invite {player} This notice is for the new player in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-returning-player",
    "original_text": "Usage: /party invite {player} This notice is for the returning player in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-trader",
    "original_text": "Usage: /party invite {player} This notice is for the trade participant in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-event-player",
    "original_text": "Usage: /party invite {player} This notice is for the event participant in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-party-01-match-admin",
    "original_text": "Usage: /party invite {player} This notice is for the server administrator in this match.",
    "category": "commands",
    "subcategory": "party",
    "context": "Shown after incorrect use of the party invite command. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-server-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in this server.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-world-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in the current world.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-region-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in this region.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-session-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in your current session.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-gamemode-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in this game mode.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-event-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in the active event.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-instance-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in this server instance.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-profile-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in your current profile.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-lobby-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in the selected lobby.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-player",
    "original_text": "You do not have permission to use this command. This notice is for the player in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-party-member",
    "original_text": "You do not have permission to use this command. This notice is for the party member in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-guild-member",
    "original_text": "You do not have permission to use this command. This notice is for the guild member in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-team-member",
    "original_text": "You do not have permission to use this command. This notice is for the team member in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-moderator",
    "original_text": "You do not have permission to use this command. This notice is for the server moderator in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-new-player",
    "original_text": "You do not have permission to use this command. This notice is for the new player in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-returning-player",
    "original_text": "You do not have permission to use this command. This notice is for the returning player in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-trader",
    "original_text": "You do not have permission to use this command. This notice is for the trade participant in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-event-player",
    "original_text": "You do not have permission to use this command. This notice is for the event participant in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-permission-02-match-admin",
    "original_text": "You do not have permission to use this command. This notice is for the server administrator in this match.",
    "category": "commands",
    "subcategory": "permission",
    "context": "Shown when a command is blocked by permissions. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-server-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in this server.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-world-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in the current world.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-region-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in this region.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-session-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in your current session.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-gamemode-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in this game mode.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-event-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in the active event.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-instance-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in this server instance.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-profile-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in your current profile.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-lobby-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in the selected lobby.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-player",
    "original_text": "Teleport request sent to {player}. This notice is for the player in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-party-member",
    "original_text": "Teleport request sent to {player}. This notice is for the party member in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-guild-member",
    "original_text": "Teleport request sent to {player}. This notice is for the guild member in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-team-member",
    "original_text": "Teleport request sent to {player}. This notice is for the team member in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-moderator",
    "original_text": "Teleport request sent to {player}. This notice is for the server moderator in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-new-player",
    "original_text": "Teleport request sent to {player}. This notice is for the new player in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-returning-player",
    "original_text": "Teleport request sent to {player}. This notice is for the returning player in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-trader",
    "original_text": "Teleport request sent to {player}. This notice is for the trade participant in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-event-player",
    "original_text": "Teleport request sent to {player}. This notice is for the event participant in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-teleport-03-match-admin",
    "original_text": "Teleport request sent to {player}. This notice is for the server administrator in this match.",
    "category": "commands",
    "subcategory": "teleport",
    "context": "Shown after sending a teleport request. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{player}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-server-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in this server.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-world-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in the current world.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-region-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in this region.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-session-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in your current session.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-gamemode-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in this game mode.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-event-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in the active event.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-instance-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in this server instance.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-profile-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in your current profile.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-lobby-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in the selected lobby.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the player in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-party-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the party member in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-guild-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the guild member in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-team-member",
    "original_text": "Home {world} has been saved successfully. This notice is for the team member in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-moderator",
    "original_text": "Home {world} has been saved successfully. This notice is for the server moderator in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-new-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the new player in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-returning-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the returning player in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-trader",
    "original_text": "Home {world} has been saved successfully. This notice is for the trade participant in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-event-player",
    "original_text": "Home {world} has been saved successfully. This notice is for the event participant in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-home-04-match-admin",
    "original_text": "Home {world} has been saved successfully. This notice is for the server administrator in this match.",
    "category": "commands",
    "subcategory": "home",
    "context": "Shown after saving a named or world-specific home. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-server-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in this server.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-world-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in the current world.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-region-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in this region.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-session-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in your current session.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-gamemode-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in this game mode.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-event-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in the active event.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-instance-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in this server instance.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-profile-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in your current profile.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-lobby-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in the selected lobby.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the player in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-party-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the party member in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-guild-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the guild member in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-team-member",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the team member in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-moderator",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server moderator in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-new-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the new player in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-returning-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the returning player in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-trader",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the trade participant in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-event-player",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the event participant in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "commands-warp-05-match-admin",
    "original_text": "Warp {region} is temporarily unavailable. This notice is for the server administrator in this match.",
    "category": "commands",
    "subcategory": "warp",
    "context": "Shown when a configured warp cannot be used. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly.",
    "protected_variables": [
      "{region}"
    ],
    "protected_terms": [],
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
