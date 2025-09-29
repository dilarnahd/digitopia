import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseService get instance => _instance ??= SupabaseService._();

  SupabaseService._();

  late SupabaseClient _client;
  SupabaseClient get client => _client;

  Future<void> initialize() async {
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      throw Exception(
        'Supabase URL and Anon Key must be provided in environment variables',
      );
    }

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

    _client = Supabase.instance.client;
  }

  // Authentication methods
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: fullName != null ? {'full_name': fullName} : null,
      );

      // If user was created successfully, the trigger function will handle
      // creating the user profile record automatically
      return response;
    } catch (error) {
      throw Exception('Sign up failed: $error');
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      throw Exception('Sign in failed: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }

  // User profile methods
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return null;

      final response = await _client
          .from('user_profiles')
          .select()
          .eq('id', user.id)
          .single();

      return response;
    } catch (error) {
      throw Exception('Failed to get user profile: $error');
    }
  }

  Future<void> updateUserProfile({
    required Map<String, dynamic> updates,
  }) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) throw Exception('No authenticated user');

      await _client.from('user_profiles').update(updates).eq('id', user.id);
    } catch (error) {
      throw Exception('Failed to update user profile: $error');
    }
  }

  Future<void> createUserProfile({
    required String userId,
    required String email,
    required String fullName,
    String role = 'user',
  }) async {
    try {
      await _client.from('user_profiles').insert({
        'id': userId,
        'email': email,
        'full_name': fullName,
        'role': role,
      });
    } catch (error) {
      throw Exception('Failed to create user profile: $error');
    }
  }

  // Player info methods
  Future<Map<String, dynamic>?> getPlayerInfo() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return null;

      final response = await _client
          .from('user_profiles')
          .select(
            'player_name, player_age, player_interests, difficulty_level, profile_completed, is_first_time, player_location, egypt_knowledge_level, egyptian_identity_feeling, favorite_activity, learning_preference, gaming_frequency, historical_period_preference',
          )
          .eq('id', user.id)
          .single();

      return response;
    } catch (error) {
      throw Exception('Failed to get player info: $error');
    }
  }

  Future<void> updatePlayerInfo({
    String? playerName,
    int? playerAge,
    List<String>? playerInterests,
    double? difficultyLevel,
    bool? profileCompleted,
    bool? isFirstTime,
    String? playerLocation,
    String? egyptKnowledgeLevel,
    String? egyptianIdentityFeeling,
    String? favoriteActivity,
    String? learningPreference,
    String? gamingFrequency,
    String? historicalPeriodPreference,
  }) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) throw Exception('No authenticated user');

      final updates = <String, dynamic>{};
      if (playerName != null) updates['player_name'] = playerName;
      if (playerAge != null) updates['player_age'] = playerAge;
      if (playerInterests != null)
        updates['player_interests'] = playerInterests;
      if (difficultyLevel != null)
        updates['difficulty_level'] = difficultyLevel;
      if (profileCompleted != null)
        updates['profile_completed'] = profileCompleted;
      if (isFirstTime != null) updates['is_first_time'] = isFirstTime;
      if (playerLocation != null) updates['player_location'] = playerLocation;
      if (egyptKnowledgeLevel != null)
        updates['egypt_knowledge_level'] = egyptKnowledgeLevel;
      if (egyptianIdentityFeeling != null)
        updates['egyptian_identity_feeling'] = egyptianIdentityFeeling;
      if (favoriteActivity != null)
        updates['favorite_activity'] = favoriteActivity;
      if (learningPreference != null)
        updates['learning_preference'] = learningPreference;
      if (gamingFrequency != null)
        updates['gaming_frequency'] = gamingFrequency;
      if (historicalPeriodPreference != null)
        updates['historical_period_preference'] = historicalPeriodPreference;

      if (updates.isNotEmpty) {
        await _client.from('user_profiles').update(updates).eq('id', user.id);
      }
    } catch (error) {
      throw Exception('Failed to update player info: $error');
    }
  }

  Future<String> getPlayerName() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return 'ضيف';

      final response = await _client
          .from('user_profiles')
          .select('player_name, full_name')
          .eq('id', user.id)
          .single();

      return response['player_name'] ?? response['full_name'] ?? 'ضيف';
    } catch (error) {
      return 'ضيف';
    }
  }

  // Auth state helpers
  User? get currentUser => _client.auth.currentUser;
  bool get isAuthenticated => _client.auth.currentUser != null;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<bool> hasUserStartedJourney() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return false;

      final response = await _client
          .from('user_profiles')
          .select('journey_started')
          .eq('id', user.id)
          .single();

      return response['journey_started'] == true;
    } catch (e) {
      print('Error checking journey status: $e');
      return false;
    }
  }

  Future<void> updateJourneyStatus(bool started) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return;

      await _client
          .from('user_profiles')
          .update({'journey_started': started}).eq('id', user.id);
    } catch (e) {
      print('Error updating journey status: $e');
    }
  }
}
