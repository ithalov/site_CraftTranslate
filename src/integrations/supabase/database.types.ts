export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          avatar_url: string | null;
          bio: string | null;
          created_at: string;
          display_name: string | null;
          id: string;
          discord_id: string | null;
          preferred_locale: string;
          role: Database['public']['Enums']['member_role'];
          updated_at: string;
          user_id: string;
          username: string | null;
        };
        Insert: {
          avatar_url?: string | null;
          bio?: string | null;
          created_at?: string;
          display_name?: string | null;
          id?: string;
          discord_id?: string | null;
          preferred_locale?: string;
          role?: Database['public']['Enums']['member_role'];
          updated_at?: string;
          user_id: string;
          username?: string | null;
        };
        Update: {
          avatar_url?: string | null;
          bio?: string | null;
          created_at?: string;
          display_name?: string | null;
          id?: string;
          discord_id?: string | null;
          preferred_locale?: string;
          role?: Database['public']['Enums']['member_role'];
          updated_at?: string;
          user_id?: string;
          username?: string | null;
        };
        Relationships: [];
      };
      languages: {
        Row: {
          code: string;
          created_at: string;
          created_by: string | null;
          id: string;
          direction: Database['public']['Enums']['language_direction'];
          emoji: string | null;
          is_active: boolean;
          name: string;
          native_name: string;
          sort_order: number;
          updated_at: string;
        };
        Insert: {
          code: string;
          created_at?: string;
          created_by?: string | null;
          id?: string;
          direction?: Database['public']['Enums']['language_direction'];
          emoji?: string | null;
          is_active?: boolean;
          name: string;
          native_name: string;
          sort_order?: number;
          updated_at?: string;
        };
        Update: {
          code?: string;
          created_at?: string;
          created_by?: string | null;
          id?: string;
          direction?: Database['public']['Enums']['language_direction'];
          emoji?: string | null;
          is_active?: boolean;
          name?: string;
          native_name?: string;
          sort_order?: number;
          updated_at?: string;
        };
        Relationships: [];
      };
      translation_entries: {
        Row: {
          author_id: string | null;
          context: string | null;
          created_at: string;
          id: string;
          metadata: Json;
          reviewer_id: string | null;
          source_language_code: string;
          source_text: string;
          status: Database['public']['Enums']['translation_status'];
          target_language_code: string;
          translated_text: string | null;
          updated_at: string;
        };
        Insert: {
          author_id?: string | null;
          context?: string | null;
          created_at?: string;
          id?: string;
          metadata?: Json;
          reviewer_id?: string | null;
          source_language_code: string;
          source_text: string;
          status?: Database['public']['Enums']['translation_status'];
          target_language_code: string;
          translated_text?: string | null;
          updated_at?: string;
        };
        Update: {
          author_id?: string | null;
          context?: string | null;
          created_at?: string;
          id?: string;
          metadata?: Json;
          reviewer_id?: string | null;
          source_language_code?: string;
          source_text?: string;
          status?: Database['public']['Enums']['translation_status'];
          target_language_code?: string;
          translated_text?: string | null;
          updated_at?: string;
        };
        Relationships: [];
      };
      review_assignments: {
        Row: {
          assigned_to: string | null;
          created_at: string;
          due_at: string | null;
          id: string;
          notes: string | null;
          review_status: Database['public']['Enums']['review_status'];
          reviewed_by: string | null;
          translation_entry_id: string;
          updated_at: string;
        };
        Insert: {
          assigned_to?: string | null;
          created_at?: string;
          due_at?: string | null;
          id?: string;
          notes?: string | null;
          review_status?: Database['public']['Enums']['review_status'];
          reviewed_by?: string | null;
          translation_entry_id: string;
          updated_at?: string;
        };
        Update: {
          assigned_to?: string | null;
          created_at?: string;
          due_at?: string | null;
          id?: string;
          notes?: string | null;
          review_status?: Database['public']['Enums']['review_status'];
          reviewed_by?: string | null;
          translation_entry_id?: string;
          updated_at?: string;
        };
        Relationships: [];
      };
      glossary_terms: {
        Row: {
          aliases: string[];
          created_at: string;
          created_by: string | null;
          definition: string;
          examples: string[];
          id: string;
          language_code: string | null;
          status: Database['public']['Enums']['term_status'];
          tags: string[];
          term: string;
          updated_at: string;
          updated_by: string | null;
        };
        Insert: {
          aliases?: string[];
          created_at?: string;
          created_by?: string | null;
          definition: string;
          examples?: string[];
          id?: string;
          language_code?: string | null;
          status?: Database['public']['Enums']['term_status'];
          tags?: string[];
          term: string;
          updated_at?: string;
          updated_by?: string | null;
        };
        Update: {
          aliases?: string[];
          created_at?: string;
          created_by?: string | null;
          definition?: string;
          examples?: string[];
          id?: string;
          language_code?: string | null;
          status?: Database['public']['Enums']['term_status'];
          tags?: string[];
          term?: string;
          updated_at?: string;
          updated_by?: string | null;
        };
        Relationships: [];
      };
      leaderboard_snapshots: {
        Row: {
          created_at: string;
          id: string;
          language_contributions: number;
          points: number;
          position: number;
          review_contributions: number;
          snapshot_date: string;
          translation_contributions: number;
          user_id: string;
        };
        Insert: {
          created_at?: string;
          id?: string;
          language_contributions?: number;
          points?: number;
          position?: number;
          review_contributions?: number;
          snapshot_date?: string;
          translation_contributions?: number;
          user_id: string;
        };
        Update: {
          created_at?: string;
          id?: string;
          language_contributions?: number;
          points?: number;
          position?: number;
          review_contributions?: number;
          snapshot_date?: string;
          translation_contributions?: number;
          user_id?: string;
        };
        Relationships: [];
      };
      user_languages: {
        Row: {
          created_at: string;
          id: string;
          is_learning: boolean;
          is_native: boolean;
          is_primary: boolean;
          language_id: string;
          notes: string | null;
          proficiency: Database['public']['Enums']['language_proficiency'];
          updated_at: string;
          user_id: string;
        };
        Insert: {
          created_at?: string;
          id?: string;
          is_learning?: boolean;
          is_native?: boolean;
          is_primary?: boolean;
          language_id: string;
          notes?: string | null;
          proficiency?: Database['public']['Enums']['language_proficiency'];
          updated_at?: string;
          user_id: string;
        };
        Update: {
          created_at?: string;
          id?: string;
          is_learning?: boolean;
          is_native?: boolean;
          is_primary?: boolean;
          language_id?: string;
          notes?: string | null;
          proficiency?: Database['public']['Enums']['language_proficiency'];
          updated_at?: string;
          user_id?: string;
        };
        Relationships: [];
      };
      language_members: {
        Row: {
          contribution_score: number;
          created_at: string;
          id: string;
          invited_by: string | null;
          is_active: boolean;
          joined_at: string;
          language_id: string;
          role: Database['public']['Enums']['member_role'];
          updated_at: string;
          user_id: string;
        };
        Insert: {
          contribution_score?: number;
          created_at?: string;
          id?: string;
          invited_by?: string | null;
          is_active?: boolean;
          joined_at?: string;
          language_id: string;
          role?: Database['public']['Enums']['member_role'];
          updated_at?: string;
          user_id: string;
        };
        Update: {
          contribution_score?: number;
          created_at?: string;
          id?: string;
          invited_by?: string | null;
          is_active?: boolean;
          joined_at?: string;
          language_id?: string;
          role?: Database['public']['Enums']['member_role'];
          updated_at?: string;
          user_id?: string;
        };
        Relationships: [];
      };
      translation_keys: {
        Row: {
          category: string;
          context: string | null;
          created_at: string;
          created_by: string | null;
          current_suggestion_id: string | null;
          id: string;
          key_name: string;
          latest_version: number;
          notes: string | null;
          original_text: string;
          protected_terms: string[];
          protected_variables: string[];
          source_language_id: string;
          status: Database['public']['Enums']['translation_key_status'];
          subcategory: string | null;
          updated_at: string;
          updated_by: string | null;
        };
        Insert: {
          category: string;
          context?: string | null;
          created_at?: string;
          created_by?: string | null;
          current_suggestion_id?: string | null;
          id?: string;
          key_name: string;
          latest_version?: number;
          notes?: string | null;
          original_text: string;
          protected_terms?: string[];
          protected_variables?: string[];
          source_language_id: string;
          status?: Database['public']['Enums']['translation_key_status'];
          subcategory?: string | null;
          updated_at?: string;
          updated_by?: string | null;
        };
        Update: {
          category?: string;
          context?: string | null;
          created_at?: string;
          created_by?: string | null;
          current_suggestion_id?: string | null;
          id?: string;
          key_name?: string;
          latest_version?: number;
          notes?: string | null;
          original_text?: string;
          protected_terms?: string[];
          protected_variables?: string[];
          source_language_id?: string;
          status?: Database['public']['Enums']['translation_key_status'];
          subcategory?: string | null;
          updated_at?: string;
          updated_by?: string | null;
        };
        Relationships: [];
      };
      translation_suggestions: {
        Row: {
          author_id: string;
          created_at: string;
          id: string;
          notes: string | null;
          rationale: string | null;
          source_hash: string | null;
          status: Database['public']['Enums']['translation_suggestion_status'];
          supersedes_suggestion_id: string | null;
          suggestion_text: string;
          target_language_id: string;
          translation_key_id: string;
          updated_at: string;
          version_number: number;
        };
        Insert: {
          author_id: string;
          created_at?: string;
          id?: string;
          notes?: string | null;
          rationale?: string | null;
          source_hash?: string | null;
          status?: Database['public']['Enums']['translation_suggestion_status'];
          supersedes_suggestion_id?: string | null;
          suggestion_text: string;
          target_language_id: string;
          translation_key_id: string;
          updated_at?: string;
          version_number?: number;
        };
        Update: {
          author_id?: string;
          created_at?: string;
          id?: string;
          notes?: string | null;
          rationale?: string | null;
          source_hash?: string | null;
          status?: Database['public']['Enums']['translation_suggestion_status'];
          supersedes_suggestion_id?: string | null;
          suggestion_text?: string;
          target_language_id?: string;
          translation_key_id?: string;
          updated_at?: string;
          version_number?: number;
        };
        Relationships: [];
      };
      reviews: {
        Row: {
          created_at: string;
          decision: Database['public']['Enums']['review_decision'];
          id: string;
          notes: string | null;
          reviewed_at: string;
          reviewer_id: string;
          score: number;
          translation_suggestion_id: string;
          updated_at: string;
        };
        Insert: {
          created_at?: string;
          decision: Database['public']['Enums']['review_decision'];
          id?: string;
          notes?: string | null;
          reviewed_at?: string;
          reviewer_id: string;
          score?: number;
          translation_suggestion_id: string;
          updated_at?: string;
        };
        Update: {
          created_at?: string;
          decision?: Database['public']['Enums']['review_decision'];
          id?: string;
          notes?: string | null;
          reviewed_at?: string;
          reviewer_id?: string;
          score?: number;
          translation_suggestion_id?: string;
          updated_at?: string;
        };
        Relationships: [];
      };
      translation_votes: {
        Row: {
          created_at: string;
          id: string;
          translation_suggestion_id: string;
          updated_at: string;
          voter_id: string;
          vote: Database['public']['Enums']['vote_kind'];
          weight: number;
        };
        Insert: {
          created_at?: string;
          id?: string;
          translation_suggestion_id: string;
          updated_at?: string;
          voter_id: string;
          vote?: Database['public']['Enums']['vote_kind'];
          weight?: number;
        };
        Update: {
          created_at?: string;
          id?: string;
          translation_suggestion_id?: string;
          updated_at?: string;
          voter_id?: string;
          vote?: Database['public']['Enums']['vote_kind'];
          weight?: number;
        };
        Relationships: [];
      };
      translation_comments: {
        Row: {
          anchor_end: number | null;
          anchor_start: number | null;
          author_id: string;
          body: string;
          created_at: string;
          id: string;
          is_resolved: boolean;
          parent_comment_id: string | null;
          translation_suggestion_id: string;
          updated_at: string;
        };
        Insert: {
          anchor_end?: number | null;
          anchor_start?: number | null;
          author_id: string;
          body: string;
          created_at?: string;
          id?: string;
          is_resolved?: boolean;
          parent_comment_id?: string | null;
          translation_suggestion_id: string;
          updated_at?: string;
        };
        Update: {
          anchor_end?: number | null;
          anchor_start?: number | null;
          author_id?: string;
          body?: string;
          created_at?: string;
          id?: string;
          is_resolved?: boolean;
          parent_comment_id?: string | null;
          translation_suggestion_id?: string;
          updated_at?: string;
        };
        Relationships: [];
      };
      glossary: {
        Row: {
          aliases: string[];
          category: string;
          created_at: string;
          created_by: string | null;
          definition: string;
          id: string;
          language_id: string;
          source_translation_key_id: string | null;
          status: Database['public']['Enums']['glossary_status'];
          subcategory: string | null;
          tags: string[];
          term: string;
          updated_at: string;
          updated_by: string | null;
        };
        Insert: {
          aliases?: string[];
          category: string;
          created_at?: string;
          created_by?: string | null;
          definition: string;
          id?: string;
          language_id: string;
          source_translation_key_id?: string | null;
          status?: Database['public']['Enums']['glossary_status'];
          subcategory?: string | null;
          tags?: string[];
          term: string;
          updated_at?: string;
          updated_by?: string | null;
        };
        Update: {
          aliases?: string[];
          category?: string;
          created_at?: string;
          created_by?: string | null;
          definition?: string;
          id?: string;
          language_id?: string;
          source_translation_key_id?: string | null;
          status?: Database['public']['Enums']['glossary_status'];
          subcategory?: string | null;
          tags?: string[];
          term?: string;
          updated_at?: string;
          updated_by?: string | null;
        };
        Relationships: [];
      };
      glossary_proposals: {
        Row: {
          created_at: string;
          glossary_id: string | null;
          id: string;
          language_id: string;
          proposed_definition: string;
          proposed_term: string;
          proposer_id: string;
          rationale: string | null;
          reviewer_id: string | null;
          source_translation_key_id: string | null;
          status: Database['public']['Enums']['glossary_proposal_status'];
          updated_at: string;
        };
        Insert: {
          created_at?: string;
          glossary_id?: string | null;
          id?: string;
          language_id: string;
          proposed_definition: string;
          proposed_term: string;
          proposer_id: string;
          rationale?: string | null;
          reviewer_id?: string | null;
          source_translation_key_id?: string | null;
          status?: Database['public']['Enums']['glossary_proposal_status'];
          updated_at?: string;
        };
        Update: {
          created_at?: string;
          glossary_id?: string | null;
          id?: string;
          language_id?: string;
          proposed_definition?: string;
          proposed_term?: string;
          proposer_id?: string;
          rationale?: string | null;
          reviewer_id?: string | null;
          source_translation_key_id?: string | null;
          status?: Database['public']['Enums']['glossary_proposal_status'];
          updated_at?: string;
        };
        Relationships: [];
      };
      badges: {
        Row: {
          active: boolean;
          category: string;
          created_at: string;
          criteria: Json;
          description: string;
          icon: string | null;
          id: string;
          name: string;
          rarity: Database['public']['Enums']['badge_rarity'];
          slug: string;
          updated_at: string;
          xp_reward: number;
        };
        Insert: {
          active?: boolean;
          category?: string;
          created_at?: string;
          criteria?: Json;
          description: string;
          icon?: string | null;
          id?: string;
          name: string;
          rarity?: Database['public']['Enums']['badge_rarity'];
          slug: string;
          updated_at?: string;
          xp_reward?: number;
        };
        Update: {
          active?: boolean;
          category?: string;
          created_at?: string;
          criteria?: Json;
          description?: string;
          icon?: string | null;
          id?: string;
          name?: string;
          rarity?: Database['public']['Enums']['badge_rarity'];
          slug?: string;
          updated_at?: string;
          xp_reward?: number;
        };
        Relationships: [];
      };
      user_badges: {
        Row: {
          awarded_at: string;
          awarded_by: string | null;
          badge_id: string;
          id: string;
          metadata: Json;
          reason: string | null;
          user_id: string;
        };
        Insert: {
          awarded_at?: string;
          awarded_by?: string | null;
          badge_id: string;
          id?: string;
          metadata?: Json;
          reason?: string | null;
          user_id: string;
        };
        Update: {
          awarded_at?: string;
          awarded_by?: string | null;
          badge_id?: string;
          id?: string;
          metadata?: Json;
          reason?: string | null;
          user_id?: string;
        };
        Relationships: [];
      };
      reputation_events: {
        Row: {
          actor_id: string | null;
          created_at: string;
          delta: number;
          event_type: Database['public']['Enums']['reputation_event_type'];
          id: string;
          metadata: Json;
          reason: string | null;
          source_id: string | null;
          source_table: string | null;
          user_id: string;
        };
        Insert: {
          actor_id?: string | null;
          created_at?: string;
          delta: number;
          event_type: Database['public']['Enums']['reputation_event_type'];
          id?: string;
          metadata?: Json;
          reason?: string | null;
          source_id?: string | null;
          source_table?: string | null;
          user_id: string;
        };
        Update: {
          actor_id?: string | null;
          created_at?: string;
          delta?: number;
          event_type?: Database['public']['Enums']['reputation_event_type'];
          id?: string;
          metadata?: Json;
          reason?: string | null;
          source_id?: string | null;
          source_table?: string | null;
          user_id?: string;
        };
        Relationships: [];
      };
      xp_events: {
        Row: {
          actor_id: string | null;
          created_at: string;
          event_type: Database['public']['Enums']['xp_event_type'];
          id: string;
          metadata: Json;
          reason: string | null;
          source_id: string | null;
          source_table: string | null;
          user_id: string;
          xp_delta: number;
        };
        Insert: {
          actor_id?: string | null;
          created_at?: string;
          event_type: Database['public']['Enums']['xp_event_type'];
          id?: string;
          metadata?: Json;
          reason?: string | null;
          source_id?: string | null;
          source_table?: string | null;
          user_id: string;
          xp_delta: number;
        };
        Update: {
          actor_id?: string | null;
          created_at?: string;
          event_type?: Database['public']['Enums']['xp_event_type'];
          id?: string;
          metadata?: Json;
          reason?: string | null;
          source_id?: string | null;
          source_table?: string | null;
          user_id?: string;
          xp_delta?: number;
        };
        Relationships: [];
      };
      reports: {
        Row: {
          created_at: string;
          details: string;
          glossary_id: string | null;
          glossary_proposal_id: string | null;
          id: string;
          report_target_type: Database['public']['Enums']['report_target_type'];
          reported_user_id: string | null;
          reporter_id: string;
          resolution: string | null;
          resolved_at: string | null;
          resolved_by: string | null;
          review_id: string | null;
          status: Database['public']['Enums']['report_status'];
          translation_comment_id: string | null;
          translation_key_id: string | null;
          translation_suggestion_id: string | null;
          updated_at: string;
        };
        Insert: {
          created_at?: string;
          details: string;
          glossary_id?: string | null;
          glossary_proposal_id?: string | null;
          id?: string;
          report_target_type: Database['public']['Enums']['report_target_type'];
          reported_user_id?: string | null;
          reporter_id: string;
          resolution?: string | null;
          resolved_at?: string | null;
          resolved_by?: string | null;
          review_id?: string | null;
          status?: Database['public']['Enums']['report_status'];
          translation_comment_id?: string | null;
          translation_key_id?: string | null;
          translation_suggestion_id?: string | null;
          updated_at?: string;
        };
        Update: {
          created_at?: string;
          details?: string;
          glossary_id?: string | null;
          glossary_proposal_id?: string | null;
          id?: string;
          report_target_type?: Database['public']['Enums']['report_target_type'];
          reported_user_id?: string | null;
          reporter_id?: string;
          resolution?: string | null;
          resolved_at?: string | null;
          resolved_by?: string | null;
          review_id?: string | null;
          status?: Database['public']['Enums']['report_status'];
          translation_comment_id?: string | null;
          translation_key_id?: string | null;
          translation_suggestion_id?: string | null;
          updated_at?: string;
        };
        Relationships: [];
      };
      donations: {
        Row: {
          amount: number;
          created_at: string;
          currency: string;
          donated_at: string | null;
          id: string;
          metadata: Json;
          provider: string;
          provider_reference: string;
          status: Database['public']['Enums']['donation_status'];
          updated_at: string;
          user_id: string;
        };
        Insert: {
          amount: number;
          created_at?: string;
          currency?: string;
          donated_at?: string | null;
          id?: string;
          metadata?: Json;
          provider: string;
          provider_reference: string;
          status?: Database['public']['Enums']['donation_status'];
          updated_at?: string;
          user_id: string;
        };
        Update: {
          amount?: number;
          created_at?: string;
          currency?: string;
          donated_at?: string | null;
          id?: string;
          metadata?: Json;
          provider?: string;
          provider_reference?: string;
          status?: Database['public']['Enums']['donation_status'];
          updated_at?: string;
          user_id?: string;
        };
        Relationships: [];
      };
    };
    Views: {
      public_profile_cards_view: {
        Row: {
          avatar_url: string | null;
          bio: string | null;
          badges_count: number;
          display_name: string | null;
          languages_count: number;
          preferred_locale: string;
          rank: number;
          reputation_score: number;
          role: string;
          reviews_count: number;
          total_xp: number;
          translations_count: number;
          user_id: string;
          username: string | null;
        };
        Insert: never;
        Update: never;
        Relationships: [];
      };
      public_leaderboard_view: {
        Row: {
          avatar_url: string | null;
          badges_count: number;
          display_name: string | null;
          rank: number;
          reputation_score: number;
          role: string;
          reviews_count: number;
          total_xp: number;
          translations_count: number;
          user_id: string;
          username: string | null;
        };
        Insert: never;
        Update: never;
        Relationships: [];
      };
      public_language_progress_view: {
        Row: {
          active_moderators: number;
          active_reviewers: number;
          active_translators: number;
          approved_suggestions: number;
          code: string;
          direction: string;
          emoji: string | null;
          glossary_proposals: number;
          glossary_terms: number;
          language_id: string;
          name: string;
          native_name: string;
          progress_percent: string;
          translation_keys: number;
          translation_suggestions: number;
        };
        Insert: never;
        Update: never;
        Relationships: [];
      };
    };
    Functions: {
      handle_new_user: {
        Args: Record<string, never>;
        Returns: unknown;
      };
      public_language_progress: {
        Args: Record<string, never>;
        Returns: {
          active_moderators: number;
          active_reviewers: number;
          active_translators: number;
          approved_suggestions: number;
          code: string;
          direction: string;
          emoji: string | null;
          glossary_proposals: number;
          glossary_terms: number;
          language_id: string;
          name: string;
          native_name: string;
          progress_percent: string;
          translation_keys: number;
          translation_suggestions: number;
        }[];
      };
      public_leaderboard: {
        Args: Record<string, never>;
        Returns: {
          avatar_url: string | null;
          badges_count: number;
          display_name: string | null;
          rank: number;
          reputation_score: number;
          role: string;
          reviews_count: number;
          total_xp: number;
          translations_count: number;
          user_id: string;
          username: string | null;
        }[];
      };
      public_leaderboard_rankings: {
        Args: {
          leaderboard_period?: string;
        };
        Returns: {
          approval_rate: number;
          avatar_url: string | null;
          badges: Json;
          badges_count: number;
          contribution_points: number;
          display_name: string | null;
          leaderboard_kind: string;
          period: string;
          primary_language_code: string | null;
          primary_language_emoji: string | null;
          primary_language_name: string | null;
          primary_language_native_name: string | null;
          rank: number;
          ranking_score: number;
          reputation_score: number;
          role: string;
          reviews_count: number;
          approved_reviews_count: number;
          approved_suggestions_count: number;
          total_xp: number;
          translations_count: number;
          user_id: string;
          username: string | null;
        }[];
      };
      public_status_overview: {
        Args: Record<string, never>;
        Returns: {
          collaborators: number;
          official_percent: number;
          reviewed_percent: number;
          total_languages: number;
          total_reviews: number;
          total_strings: number;
          total_translations: number;
          translated_percent: number;
        }[];
      };
      public_status_language_coverage: {
        Args: Record<string, never>;
        Returns: {
          active_moderators: number;
          active_reviewers: number;
          active_translators: number;
          code: string;
          direction: string;
          emoji: string | null;
          language_id: string;
          name: string;
          native_name: string;
          official_count: number;
          official_percent: number;
          reviewed_count: number;
          reviewed_percent: number;
          total_strings: number;
          translated_count: number;
          translated_percent: number;
        }[];
      };
      public_profile_cards: {
        Args: Record<string, never>;
        Returns: {
          avatar_url: string | null;
          bio: string | null;
          badges_count: number;
          display_name: string | null;
          languages_count: number;
          preferred_locale: string;
          rank: number;
          reputation_score: number;
          role: string;
          reviews_count: number;
          total_xp: number;
          translations_count: number;
          user_id: string;
          username: string | null;
        }[];
      };
      public_profile_page: {
        Args: {
          profile_handle: string;
        };
        Returns: {
          approval_rate: number;
          avatar_url: string | null;
          badges: Json;
          badges_count: number;
          bio: string | null;
          contribution_points: number;
          display_name: string | null;
          functions: Json;
          languages: Json;
          languages_count: number;
          preferred_locale: string;
          profile_level: number;
          profile_state: string;
          rank: number;
          reputation_score: number;
          reviews_count: number;
          role: string;
          total_xp: number;
          translations_count: number;
          user_id: string;
          username: string | null;
        }[];
      };
      public_language_catalog: {
        Args: Record<string, never>;
        Returns: {
          active_moderators: number;
          active_reviewers: number;
          active_translators: number;
          approved_suggestions: number;
          collaborators_count: number;
          code: string;
          direction: string;
          emoji: string | null;
          glossary_proposals: number;
          glossary_terms: number;
          language_id: string;
          name: string;
          native_name: string;
          official_count: number;
          official_percent: number;
          reviewed_count: number;
          reviewed_percent: number;
          total_strings: number;
          translated_count: number;
          translated_percent: number;
          translation_keys: number;
          translation_suggestions: number;
        }[];
      };
      public_language_page: {
        Args: {
          language_code: string;
        };
        Returns: {
          active_moderators: number;
          active_reviewers: number;
          active_translators: number;
          approved_suggestions: number;
          categories: Json;
          code: string;
          collaborators_count: number;
          direction: string;
          emoji: string | null;
          glossary_proposals: number;
          glossary_terms: number;
          language_id: string;
          lead_member: Json;
          name: string;
          native_name: string;
          official_count: number;
          official_percent: number;
          reviewers: Json;
          reviewed_count: number;
          reviewed_percent: number;
          team_members: Json;
          top_contributors: Json;
          total_strings: number;
          translated_count: number;
          translated_percent: number;
          translation_keys: number;
          translation_suggestions: number;
        }[];
      };
      is_admin: {
        Args: Record<string, never>;
        Returns: boolean;
      };
      is_moderator_or_admin: {
        Args: Record<string, never>;
        Returns: boolean;
      };
      set_updated_at: {
        Args: Record<string, never>;
        Returns: unknown;
      };
    };
    Enums: {
      badge_rarity: 'common' | 'rare' | 'epic' | 'legendary';
      donation_status: 'pending' | 'completed' | 'failed' | 'refunded';
      glossary_proposal_status: 'pending' | 'approved' | 'rejected' | 'superseded';
      glossary_status: 'draft' | 'pending' | 'approved' | 'deprecated';
      language_direction: 'ltr' | 'rtl';
      language_proficiency: 'beginner' | 'intermediate' | 'fluent' | 'advanced' | 'native';
      member_role:
        | 'member'
        | 'moderator'
        | 'admin'
        | 'user'
        | 'translator'
        | 'trusted_translator'
        | 'reviewer'
        | 'language_moderator'
        | 'owner';
      report_status: 'open' | 'under_review' | 'resolved' | 'dismissed';
      report_target_type:
        | 'profile'
        | 'translation_key'
        | 'translation_suggestion'
        | 'review'
        | 'translation_comment'
        | 'glossary'
        | 'glossary_proposal';
      review_decision: 'approve' | 'request_changes' | 'reject' | 'flag';
      review_status: 'pending' | 'needs_changes' | 'approved' | 'rejected';
      translation_key_status: 'draft' | 'active' | 'archived';
      translation_suggestion_status: 'draft' | 'pending' | 'approved' | 'rejected' | 'archived';
      vote_kind: 'upvote' | 'downvote' | 'helpful' | 'not_helpful';
      term_status: 'draft' | 'approved' | 'deprecated';
      translation_status: 'draft' | 'in_review' | 'published' | 'archived';
      reputation_event_type:
        | 'translation_created'
        | 'translation_approved'
        | 'translation_rejected'
        | 'review_completed'
        | 'report_resolved'
        | 'badge_awarded'
        | 'manual_adjustment';
      xp_event_type:
        | 'translation_created'
        | 'translation_approved'
        | 'translation_rejected'
        | 'review_completed'
        | 'report_resolved'
        | 'badge_awarded'
        | 'manual_adjustment';
    };
    CompositeTypes: Record<string, never>;
  };
};
