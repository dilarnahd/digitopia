-- Location: supabase/migrations/20250924201200_expand_egyptian_player_questionnaire.sql
-- Schema Analysis: user_profiles table exists with basic player info fields
-- Integration Type: PARTIAL_EXISTS - extending existing user_profiles table with Egyptian questionnaire fields
-- Dependencies: existing user_profiles table

-- Add comprehensive Egyptian slang questionnaire fields to existing user_profiles table
ALTER TABLE public.user_profiles
ADD COLUMN player_location TEXT,
ADD COLUMN egypt_knowledge_level TEXT,
ADD COLUMN egyptian_identity_feeling TEXT,
ADD COLUMN favorite_activity TEXT,
ADD COLUMN learning_preference TEXT,
ADD COLUMN gaming_frequency TEXT,
ADD COLUMN historical_period_preference TEXT;

-- Add indexes for new Egyptian questionnaire fields
CREATE INDEX idx_user_profiles_player_location ON public.user_profiles(player_location);
CREATE INDEX idx_user_profiles_egypt_knowledge_level ON public.user_profiles(egypt_knowledge_level);
CREATE INDEX idx_user_profiles_egyptian_identity_feeling ON public.user_profiles(egyptian_identity_feeling);
CREATE INDEX idx_user_profiles_favorite_activity ON public.user_profiles(favorite_activity);
CREATE INDEX idx_user_profiles_learning_preference ON public.user_profiles(learning_preference);
CREATE INDEX idx_user_profiles_gaming_frequency ON public.user_profiles(gaming_frequency);
CREATE INDEX idx_user_profiles_historical_period_preference ON public.user_profiles(historical_period_preference);

-- Update the existing trigger function to handle new Egyptian questionnaire fields
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
SECURITY DEFINER
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO public.user_profiles (
    id, 
    email, 
    full_name, 
    role, 
    is_first_time,
    profile_completed
  )
  VALUES (
    NEW.id, 
    NEW.email, 
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
    COALESCE(NEW.raw_user_meta_data->>'role', 'user')::public.user_role,
    true,
    false
  );
  RETURN NEW;
END;
$$;