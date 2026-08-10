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
    "key_name": "minecraft-inventory-01-server-player-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-party-member-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-guild-member-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-team-member-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-moderator-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-new-player-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-returning-player-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-trader-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-event-player-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-server-admin-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: this server.",
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
    "key_name": "minecraft-inventory-01-world-player-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-party-member-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-guild-member-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-team-member-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-moderator-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-new-player-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-returning-player-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-trader-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-event-player-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-world-admin-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: the current world.",
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
    "key_name": "minecraft-inventory-01-region-player-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-party-member-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-guild-member-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-team-member-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-moderator-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-new-player-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-returning-player-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-trader-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-event-player-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-region-admin-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: this region.",
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
    "key_name": "minecraft-inventory-01-session-player-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-party-member-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-guild-member-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-team-member-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-moderator-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-new-player-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-returning-player-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-trader-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-event-player-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-session-admin-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: your current session.",
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
    "key_name": "minecraft-inventory-01-gamemode-player-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-party-member-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-guild-member-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-team-member-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-moderator-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-new-player-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-returning-player-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-trader-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-event-player-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-gamemode-admin-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: this game mode.",
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
    "key_name": "minecraft-inventory-01-event-player-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-party-member-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-guild-member-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-team-member-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-moderator-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-new-player-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-returning-player-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-trader-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-event-player-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-event-admin-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: the active event.",
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
    "key_name": "minecraft-inventory-01-instance-player-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-party-member-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-guild-member-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-team-member-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-moderator-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-new-player-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-returning-player-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-trader-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-event-player-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-instance-admin-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: this server instance.",
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
    "key_name": "minecraft-inventory-01-profile-player-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-party-member-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-guild-member-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-team-member-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-moderator-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-new-player-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-returning-player-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-trader-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-event-player-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-profile-admin-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: your current profile.",
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
    "key_name": "minecraft-inventory-01-lobby-player-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-party-member-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-guild-member-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-team-member-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-moderator-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-new-player-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-returning-player-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-trader-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-event-player-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-lobby-admin-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: the selected lobby.",
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
    "key_name": "minecraft-inventory-01-match-player-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the player in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: player. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-party-member-immediate",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the party member in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: party member. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-guild-member-recorded",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the guild member in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: guild member. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-team-member-no-action",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the team member in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: team member. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-moderator-details",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server moderator in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server moderator. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-new-player-preserved",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the new player in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: new player. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-returning-player-private",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the returning player in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: returning player. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-trader-notify",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the trade participant in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: trade participant. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-event-player-support",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the event participant in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: event participant. Scope: this match.",
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
    "key_name": "minecraft-inventory-01-match-admin-retry",
    "original_text": "Your {item} was moved to an available inventory slot. This notice is for the server administrator in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "inventory",
    "context": "Shown after the server rearranges an item because its original slot is unavailable. Audience: server administrator. Scope: this match.",
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
    "key_name": "minecraft-building-02-server-player-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-party-member-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-guild-member-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-team-member-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-moderator-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-new-player-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-returning-player-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-trader-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-event-player-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-server-admin-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-player-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-party-member-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-guild-member-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-team-member-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-moderator-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-new-player-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-returning-player-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-trader-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-event-player-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-world-admin-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-player-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-party-member-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-guild-member-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-team-member-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-moderator-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-new-player-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-returning-player-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-trader-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-event-player-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-region-admin-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-player-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-party-member-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-guild-member-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-team-member-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-moderator-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-new-player-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-returning-player-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-trader-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-event-player-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-session-admin-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-player-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-party-member-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-guild-member-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-team-member-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-moderator-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-new-player-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-returning-player-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-trader-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-event-player-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-gamemode-admin-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-player-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-party-member-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-guild-member-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-team-member-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-moderator-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-new-player-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-returning-player-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-trader-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-event-player-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-event-admin-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-player-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-party-member-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-guild-member-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-team-member-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-moderator-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-new-player-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-returning-player-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-trader-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-event-player-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-instance-admin-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-player-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-party-member-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-guild-member-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-team-member-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-moderator-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-new-player-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-returning-player-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-trader-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-event-player-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-profile-admin-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-player-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-party-member-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-guild-member-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-team-member-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-moderator-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-new-player-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-returning-player-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-trader-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-event-player-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-lobby-admin-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-player-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the player in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-party-member-recorded",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the party member in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-guild-member-no-action",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the guild member in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-team-member-details",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the team member in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-moderator-preserved",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server moderator in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-new-player-private",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the new player in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-returning-player-notify",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the returning player in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-trader-support",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the trade participant in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-event-player-retry",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the event participant in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-building-02-match-admin-immediate",
    "original_text": "You need {amount} more blocks before this build can be completed. This notice is for the server administrator in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "building",
    "context": "Shown to a player using a server-assisted building feature. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-player-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-party-member-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-guild-member-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-team-member-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-moderator-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-new-player-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-returning-player-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-trader-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-event-player-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-server-admin-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-player-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-party-member-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-guild-member-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-team-member-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-moderator-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-new-player-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-returning-player-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-trader-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-event-player-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-world-admin-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-player-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-party-member-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-guild-member-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-team-member-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-moderator-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-new-player-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-returning-player-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-trader-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-event-player-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-region-admin-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-player-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-party-member-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-guild-member-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-team-member-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-moderator-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-new-player-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-returning-player-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-trader-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-event-player-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-session-admin-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-player-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-party-member-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-guild-member-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-team-member-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-moderator-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-new-player-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-returning-player-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-trader-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-event-player-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-gamemode-admin-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-player-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-party-member-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-guild-member-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-team-member-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-moderator-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-new-player-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-returning-player-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-trader-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-event-player-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-event-admin-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-player-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-party-member-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-guild-member-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-team-member-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-moderator-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-new-player-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-returning-player-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-trader-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-event-player-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-instance-admin-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-player-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-party-member-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-guild-member-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-team-member-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-moderator-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-new-player-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-returning-player-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-trader-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-event-player-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-profile-admin-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-player-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-party-member-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-guild-member-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-team-member-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-moderator-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-new-player-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-returning-player-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-trader-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-event-player-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-lobby-admin-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-player-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the player in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-party-member-no-action",
    "original_text": "Mining is disabled inside {region}. This notice is for the party member in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-guild-member-details",
    "original_text": "Mining is disabled inside {region}. This notice is for the guild member in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-team-member-preserved",
    "original_text": "Mining is disabled inside {region}. This notice is for the team member in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-moderator-private",
    "original_text": "Mining is disabled inside {region}. This notice is for the server moderator in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-new-player-notify",
    "original_text": "Mining is disabled inside {region}. This notice is for the new player in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-returning-player-support",
    "original_text": "Mining is disabled inside {region}. This notice is for the returning player in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-trader-retry",
    "original_text": "Mining is disabled inside {region}. This notice is for the trade participant in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-event-player-immediate",
    "original_text": "Mining is disabled inside {region}. This notice is for the event participant in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-mining-03-match-admin-recorded",
    "original_text": "Mining is disabled inside {region}. This notice is for the server administrator in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "mining",
    "context": "Shown when a player attempts to mine in a protected region. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
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
    "key_name": "minecraft-farming-04-server-player-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-party-member-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-guild-member-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-team-member-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-moderator-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-new-player-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-returning-player-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-trader-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-event-player-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: this server.",
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
    "key_name": "minecraft-farming-04-server-admin-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: this server.",
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
    "key_name": "minecraft-farming-04-world-player-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-party-member-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-guild-member-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-team-member-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-moderator-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-new-player-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-returning-player-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-trader-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-event-player-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-world-admin-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: the current world.",
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
    "key_name": "minecraft-farming-04-region-player-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-party-member-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-guild-member-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-team-member-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-moderator-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-new-player-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-returning-player-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-trader-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-event-player-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: this region.",
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
    "key_name": "minecraft-farming-04-region-admin-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: this region.",
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
    "key_name": "minecraft-farming-04-session-player-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-party-member-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-guild-member-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-team-member-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-moderator-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-new-player-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-returning-player-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-trader-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-event-player-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-session-admin-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: your current session.",
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
    "key_name": "minecraft-farming-04-gamemode-player-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-party-member-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-guild-member-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-team-member-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-moderator-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-new-player-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-returning-player-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-trader-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-event-player-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-gamemode-admin-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: this game mode.",
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
    "key_name": "minecraft-farming-04-event-player-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-party-member-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-guild-member-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-team-member-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-moderator-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-new-player-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-returning-player-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-trader-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-event-player-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-event-admin-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: the active event.",
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
    "key_name": "minecraft-farming-04-instance-player-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-party-member-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-guild-member-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-team-member-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-moderator-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-new-player-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-returning-player-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-trader-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-event-player-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-instance-admin-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: this server instance.",
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
    "key_name": "minecraft-farming-04-profile-player-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-party-member-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-guild-member-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-team-member-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-moderator-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-new-player-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-returning-player-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-trader-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-event-player-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-profile-admin-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: your current profile.",
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
    "key_name": "minecraft-farming-04-lobby-player-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-party-member-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-guild-member-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-team-member-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-moderator-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-new-player-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-returning-player-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-trader-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-event-player-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-lobby-admin-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: the selected lobby.",
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
    "key_name": "minecraft-farming-04-match-player-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the player in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: player. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-party-member-details",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the party member in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: party member. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-guild-member-preserved",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the guild member in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: guild member. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-team-member-private",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the team member in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: team member. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-moderator-notify",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server moderator in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server moderator. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-new-player-support",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the new player in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: new player. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-returning-player-retry",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the returning player in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: returning player. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-trader-immediate",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the trade participant in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: trade participant. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-event-player-recorded",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the event participant in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: event participant. Scope: this match.",
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
    "key_name": "minecraft-farming-04-match-admin-no-action",
    "original_text": "The crop cannot be planted here because the soil is not valid. This notice is for the server administrator in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "farming",
    "context": "Shown when planting fails due to a block or region rule. Audience: server administrator. Scope: this match.",
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
    "key_name": "minecraft-world-05-server-player-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-party-member-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in this server. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-guild-member-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in this server. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-team-member-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in this server. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-moderator-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in this server. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-new-player-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in this server. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-returning-player-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in this server. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-trader-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in this server. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-event-player-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in this server. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-server-admin-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in this server. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: this server.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-player-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-party-member-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in the current world. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-guild-member-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in the current world. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-team-member-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in the current world. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-moderator-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in the current world. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-new-player-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in the current world. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-returning-player-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in the current world. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-trader-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in the current world. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-event-player-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in the current world. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-world-admin-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in the current world. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: the current world.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-player-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-party-member-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in this region. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-guild-member-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in this region. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-team-member-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in this region. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-moderator-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in this region. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-new-player-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in this region. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-returning-player-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in this region. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-trader-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in this region. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-event-player-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in this region. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-region-admin-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in this region. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: this region.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-player-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-party-member-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in your current session. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-guild-member-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in your current session. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-team-member-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in your current session. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-moderator-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in your current session. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-new-player-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in your current session. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-returning-player-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in your current session. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-trader-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in your current session. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-event-player-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in your current session. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-session-admin-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in your current session. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: your current session.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-player-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-party-member-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in this game mode. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-guild-member-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in this game mode. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-team-member-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in this game mode. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-moderator-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in this game mode. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-new-player-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in this game mode. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-returning-player-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in this game mode. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-trader-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in this game mode. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-event-player-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in this game mode. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-gamemode-admin-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in this game mode. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: this game mode.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-player-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-party-member-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in the active event. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-guild-member-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in the active event. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-team-member-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in the active event. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-moderator-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in the active event. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-new-player-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in the active event. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-returning-player-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in the active event. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-trader-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in the active event. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-event-player-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in the active event. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-event-admin-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in the active event. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: the active event.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-player-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-party-member-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in this server instance. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-guild-member-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in this server instance. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-team-member-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in this server instance. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-moderator-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in this server instance. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-new-player-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in this server instance. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-returning-player-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in this server instance. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-trader-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in this server instance. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-event-player-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in this server instance. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-instance-admin-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in this server instance. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: this server instance.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-player-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-party-member-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in your current profile. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-guild-member-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in your current profile. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-team-member-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in your current profile. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-moderator-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in your current profile. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-new-player-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in your current profile. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-returning-player-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in your current profile. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-trader-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in your current profile. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-event-player-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in your current profile. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-profile-admin-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in your current profile. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: your current profile.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-player-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-party-member-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in the selected lobby. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-guild-member-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in the selected lobby. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-team-member-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in the selected lobby. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-moderator-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in the selected lobby. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-new-player-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in the selected lobby. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-returning-player-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in the selected lobby. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-trader-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in the selected lobby. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-event-player-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in the selected lobby. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-lobby-admin-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in the selected lobby. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: the selected lobby.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-player-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the player in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-party-member-preserved",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the party member in this match. Your current progress is preserved.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: party member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-guild-member-private",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the guild member in this match. This notice applies only to you.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: guild member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-team-member-notify",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the team member in this match. The server will notify you when the status changes.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: team member. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-moderator-support",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server moderator in this match. Contact a moderator if the issue continues.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server moderator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-new-player-retry",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the new player in this match. Please try again.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: new player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-returning-player-immediate",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the returning player in this match. This change takes effect immediately.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: returning player. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-trader-recorded",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the trade participant in this match. The action has been recorded.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: trade participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-event-player-no-action",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the event participant in this match. No further action is required.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: event participant. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
    "supported_targets": [
      "pt-BR",
      "fr",
      "es",
      "de",
      "ru",
      "ko",
      "ja"
    ]
  },
  {
    "key_name": "minecraft-world-05-match-admin-details",
    "original_text": "Your spawn point has been updated for {world}. This notice is for the server administrator in this match. Check the relevant menu for details.",
    "category": "minecraft",
    "subcategory": "world",
    "context": "Shown after the player's respawn location changes. Audience: server administrator. Scope: this match.",
    "notes": "Keep it concise and natural for Minecraft UI/chat; preserve placeholders exactly. Additional operational status text is intentional.",
    "protected_variables": [
      "{world}"
    ],
    "protected_terms": [
      "spawn"
    ],
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
