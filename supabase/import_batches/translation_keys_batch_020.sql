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
    "key_name": "minecraft-crafting-06-server-player-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-party-member-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-guild-member-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-team-member-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-moderator-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-new-player-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-returning-player-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-trader-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-event-player-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-server-admin-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-player-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-party-member-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-guild-member-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-team-member-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-moderator-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-new-player-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-returning-player-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-trader-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-event-player-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-world-admin-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-player-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-party-member-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-guild-member-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-team-member-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-moderator-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-new-player-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-returning-player-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-trader-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-event-player-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-region-admin-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-player-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-party-member-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-guild-member-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-team-member-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-moderator-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-new-player-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-returning-player-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-trader-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-event-player-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-session-admin-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-player-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-party-member-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-guild-member-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-team-member-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-moderator-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-new-player-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-returning-player-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-trader-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-event-player-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-gamemode-admin-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-player-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-party-member-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-guild-member-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-team-member-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-moderator-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-new-player-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-returning-player-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-trader-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-event-player-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-event-admin-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-player-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-party-member-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-guild-member-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-team-member-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-moderator-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-new-player-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-returning-player-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-trader-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-event-player-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-instance-admin-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-player-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-party-member-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-guild-member-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-team-member-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-moderator-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-new-player-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-returning-player-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-trader-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-event-player-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-profile-admin-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-player-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-party-member-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-guild-member-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-team-member-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-moderator-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-new-player-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-returning-player-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-trader-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-event-player-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-lobby-admin-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-player-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the player in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-party-member-private",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the party member in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-guild-member-notify",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the guild member in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-team-member-support",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the team member in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-moderator-retry",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server moderator in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-new-player-immediate",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the new player in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-returning-player-recorded",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the returning player in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-trader-no-action",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the trade participant in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-event-player-details",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the event participant in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-crafting-06-match-admin-preserved",
    "original_text": "This recipe requires {amount} of {item}. This notice is for the server administrator in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "crafting",
    "context": "Shown in a custom crafting interface when ingredients are missing. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{amount}",
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-player-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-party-member-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-guild-member-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-team-member-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-moderator-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-new-player-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-returning-player-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-trader-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-event-player-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-server-admin-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-player-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-party-member-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-guild-member-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-team-member-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-moderator-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-new-player-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-returning-player-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-trader-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-event-player-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-world-admin-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-player-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-party-member-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-guild-member-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-team-member-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-moderator-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-new-player-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-returning-player-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-trader-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-event-player-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-region-admin-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-player-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-party-member-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-guild-member-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-team-member-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-moderator-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-new-player-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-returning-player-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-trader-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-event-player-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-session-admin-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-player-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-party-member-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-guild-member-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-team-member-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-moderator-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-new-player-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-returning-player-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-trader-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-event-player-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-gamemode-admin-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-player-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-party-member-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-guild-member-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-team-member-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-moderator-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-new-player-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-returning-player-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-trader-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-event-player-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-event-admin-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-player-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-party-member-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-guild-member-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-team-member-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-moderator-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-new-player-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-returning-player-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-trader-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-event-player-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-instance-admin-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-player-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-party-member-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-guild-member-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-team-member-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-moderator-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-new-player-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-returning-player-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-trader-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-event-player-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-profile-admin-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-player-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-party-member-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-guild-member-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-team-member-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-moderator-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-new-player-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-returning-player-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-trader-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-event-player-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-lobby-admin-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-player-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the player in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-party-member-notify",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the party member in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-guild-member-support",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the guild member in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-team-member-retry",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the team member in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-moderator-immediate",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server moderator in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-new-player-recorded",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the new player in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-returning-player-no-action",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the returning player in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-trader-details",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the trade participant in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-event-player-preserved",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the event participant in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-enchanting-07-match-admin-private",
    "original_text": "The enchantment cannot be applied to {item}. This notice is for the server administrator in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "enchanting",
    "context": "Shown when an enchantment is incompatible with the selected item. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-player-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-party-member-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-guild-member-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-team-member-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-moderator-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-new-player-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-returning-player-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-trader-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-event-player-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-server-admin-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-player-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-party-member-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-guild-member-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-team-member-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-moderator-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-new-player-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-returning-player-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-trader-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-event-player-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-world-admin-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-player-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-party-member-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-guild-member-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-team-member-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-moderator-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-new-player-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-returning-player-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-trader-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-event-player-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-region-admin-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-player-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-party-member-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-guild-member-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-team-member-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-moderator-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-new-player-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-returning-player-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-trader-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-event-player-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-session-admin-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-player-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-party-member-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-guild-member-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-team-member-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-moderator-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-new-player-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-returning-player-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-trader-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-event-player-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-gamemode-admin-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-player-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-party-member-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-guild-member-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-team-member-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-moderator-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-new-player-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-returning-player-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-trader-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-event-player-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-event-admin-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-player-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-party-member-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-guild-member-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-team-member-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-moderator-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-new-player-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-returning-player-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-trader-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-event-player-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-instance-admin-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-player-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-party-member-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-guild-member-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-team-member-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-moderator-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-new-player-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-returning-player-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-trader-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-event-player-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-profile-admin-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-player-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-party-member-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-guild-member-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-team-member-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-moderator-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-new-player-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-returning-player-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-trader-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-event-player-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-lobby-admin-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-player-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the player in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-party-member-support",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the party member in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-guild-member-retry",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the guild member in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-team-member-immediate",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the team member in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-moderator-recorded",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server moderator in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-new-player-no-action",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the new player in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-returning-player-details",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the returning player in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-trader-preserved",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the trade participant in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-event-player-private",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the event participant in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-mobs-08-match-admin-notify",
    "original_text": "A hostile mob is too close to use this feature. This notice is for the server administrator in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mobs",
    "context": "Shown when a safety-sensitive action is blocked by nearby hostile mobs. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-redstone-09-server-player-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-party-member-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-guild-member-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-team-member-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-moderator-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-new-player-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-returning-player-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-trader-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-event-player-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-server-admin-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-player-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-party-member-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-guild-member-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-team-member-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-moderator-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-new-player-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-returning-player-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-trader-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-event-player-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-world-admin-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-player-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-party-member-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-guild-member-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-team-member-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-moderator-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-new-player-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-returning-player-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-trader-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-event-player-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-region-admin-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-player-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-party-member-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-guild-member-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-team-member-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-moderator-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-new-player-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-returning-player-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-trader-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-event-player-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-session-admin-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-player-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-party-member-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-guild-member-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-team-member-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-moderator-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-new-player-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-returning-player-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-trader-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-event-player-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-gamemode-admin-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-player-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-party-member-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-guild-member-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-team-member-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-moderator-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-new-player-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-returning-player-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-trader-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-event-player-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-event-admin-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-player-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-party-member-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-guild-member-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-team-member-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-moderator-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-new-player-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-returning-player-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-trader-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-event-player-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-instance-admin-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-player-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-party-member-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-guild-member-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-team-member-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-moderator-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-new-player-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-returning-player-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-trader-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-event-player-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-profile-admin-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-player-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-party-member-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-guild-member-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-team-member-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-moderator-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-new-player-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-returning-player-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-trader-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-event-player-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-lobby-admin-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-player-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the player in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-party-member-retry",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the party member in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-guild-member-immediate",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the guild member in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-team-member-recorded",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the team member in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-moderator-no-action",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server moderator in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-new-player-details",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the new player in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-returning-player-preserved",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the returning player in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-trader-private",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the trade participant in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-event-player-notify",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the event participant in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-redstone-09-match-admin-support",
    "original_text": "Redstone updates are temporarily limited in {region} to protect TPS. This notice is for the server administrator in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "redstone",
    "context": "Shown when server performance protection throttles redstone. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{region}"
    ],
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
    "key_name": "minecraft-building-10-server-player-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-party-member-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-guild-member-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-team-member-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-moderator-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-new-player-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-returning-player-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-trader-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-event-player-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-server-admin-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-player-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-party-member-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-guild-member-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-team-member-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-moderator-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-new-player-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-returning-player-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-trader-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-event-player-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-world-admin-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-player-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-party-member-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-guild-member-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-team-member-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-moderator-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-new-player-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-returning-player-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-trader-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-event-player-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-region-admin-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-player-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-party-member-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-guild-member-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-team-member-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-moderator-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-new-player-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-returning-player-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-trader-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-event-player-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-session-admin-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-player-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-party-member-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-guild-member-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-team-member-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-moderator-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-new-player-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-returning-player-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-trader-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-event-player-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-gamemode-admin-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-player-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-party-member-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-guild-member-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-team-member-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-moderator-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-new-player-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-returning-player-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-trader-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-event-player-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-event-admin-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-player-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-party-member-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-guild-member-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-team-member-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-moderator-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-new-player-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-returning-player-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-trader-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-event-player-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-instance-admin-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-player-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-party-member-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-guild-member-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-team-member-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-moderator-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-new-player-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-returning-player-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-trader-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-event-player-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-profile-admin-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-player-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-party-member-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-guild-member-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-team-member-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-moderator-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-new-player-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-returning-player-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-trader-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-event-player-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-lobby-admin-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-player-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the player in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-party-member-immediate",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the party member in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-guild-member-recorded",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the guild member in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-team-member-no-action",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the team member in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-moderator-details",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server moderator in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-new-player-preserved",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the new player in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-returning-player-private",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the returning player in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-trader-notify",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the trade participant in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-event-player-support",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the event participant in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-building-10-match-admin-retry",
    "original_text": "You cannot place {item} above the world height limit. This notice is for the server administrator in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown when block placement exceeds the configured build height. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{item}"
    ],
    "protected_terms": [],
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
