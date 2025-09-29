-- Location: supabase/migrations/20250924200256_add_player_info_fields.sql
-- Schema Analysis: user_profiles table exists with basic fields
-- Integration Type: PARTIAL_EXISTS - extending existing user_profiles table
-- Dependencies: existing user_profiles table

-- Add player-specific fields to existing user_profiles table
ALTER TABLE public.user_profiles
ADD COLUMN player_name TEXT,
ADD COLUMN player_age INTEGER DEFAULT 18,
ADD COLUMN player_interests TEXT[] DEFAULT '{}',
ADD COLUMN difficulty_level NUMERIC(3,2) DEFAULT 1.0 CHECK (difficulty_level >= 1.0 AND difficulty_level <= 5.0),
ADD COLUMN profile_completed BOOLEAN DEFAULT false,
ADD COLUMN is_first_time BOOLEAN DEFAULT true;

-- Add indexes for new player fields
CREATE INDEX idx_user_profiles_player_name ON public.user_profiles(player_name);
CREATE INDEX idx_user_profiles_profile_completed ON public.user_profiles(profile_completed);
CREATE INDEX idx_user_profiles_is_first_time ON public.user_profiles(is_first_time);

-- Update trigger function to handle player info fields
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
SECURITY DEFINER
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO public.user_profiles (id, email, full_name, role, is_first_time)
  VALUES (
    NEW.id, 
    NEW.email, 
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
    COALESCE(NEW.raw_user_meta_data->>'role', 'user')::public.user_role,
    true
  );
  RETURN NEW;
END;
$$;