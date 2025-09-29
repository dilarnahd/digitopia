-- Location: supabase/migrations/20250924204212_add_journey_progress_field.sql
-- Schema Analysis: user_profiles table exists with player questionnaire fields
-- Integration Type: modification/extension
-- Dependencies: existing user_profiles table

-- Add journey progress tracking field to existing user_profiles table
ALTER TABLE public.user_profiles
ADD COLUMN journey_started BOOLEAN DEFAULT false;

-- Add index for journey progress queries
CREATE INDEX idx_user_profiles_journey_started ON public.user_profiles(journey_started);