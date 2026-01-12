import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// Professional Color Scheme
class AppColors {
  // Primary Colors - Modern fitness theme
  static const primary = Color(0xFF6C63FF);
  static const primaryDark = Color(0xFF5A52D5);
  static const primaryLight = Color(0xFF8B85FF);

  // Accent Colors
  static const accent = Color(0xFF00D9FF);
  static const accentOrange = Color(0xFFFF6B6B);
  static const accentGreen = Color(0xFF4ECDC4);
  static const accentPurple = Color(0xFF9D4EDD);
  static const accentGold = Color(0xFFFFD700);

  // Background Colors - Dark Theme
  static const darkBg = Color(0xFF0F0E17);
  static const darkCard = Color(0xFF1A1A2E);
  static const darkCardLight = Color(0xFF16213E);

  // Background Colors - Light Theme
  static const lightBg = Color(0xFFF8F9FA);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightCardAlt = Color(0xFFF1F3F5);

  // Text Colors
  static const textDark = Color(0xFF0F0E17);
  static const textLight = Color(0xFFFFFFFF);
  static const textGray = Color(0xFF94A3B8);
  static const textGrayDark = Color(0xFF64748B);

  // Status Colors
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);
}

// Design System Constants
class AppStyles {
  // Border Radius
  static const radiusSmall = 12.0;
  static const radiusMedium = 16.0;
  static const radiusLarge = 24.0;
  static const radiusXLarge = 32.0;

  // Spacing
  static const spacingXSmall = 4.0;
  static const spacingSmall = 8.0;
  static const spacingMedium = 16.0;
  static const spacingLarge = 24.0;
  static const spacingXLarge = 32.0;

  // Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  static List<BoxShadow> get cardShadowHover => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 32,
      offset: const Offset(0, 12),
      spreadRadius: -4,
    ),
  ];

  static List<BoxShadow> get cardShadowDark => [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [AppColors.accent, AppColors.primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const warmGradient = LinearGradient(
    colors: [AppColors.accentOrange, AppColors.warning],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const coolGradient = LinearGradient(
    colors: [AppColors.accentGreen, AppColors.accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserProgress.init();
  runApp(const BarookFitApp());
}

class BarookFitApp extends StatefulWidget {
  const BarookFitApp({Key? key}) : super(key: key);

  @override
  State<BarookFitApp> createState() => _BarookFitAppState();
}

class _BarookFitAppState extends State<BarookFitApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarookFit',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? _darkTheme() : _lightTheme(),
      home: WelcomePage(onThemeToggle: toggleTheme, isDarkMode: isDarkMode),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBg,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.darkCard,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBg,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.lightCard,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

class MotivationalQuotes {
  static final List<Map<String, String>> quotes = [
    {'quote': 'Push harder than yesterday if you want a different tomorrow.', 'author': 'Vincent Williams Sr.'},
    {'quote': 'The only bad workout is the one that didn\'t happen.', 'author': 'Unknown'},
    {'quote': 'Success starts with self-discipline.', 'author': 'Unknown'},
    {'quote': 'Your body can stand almost anything. It\'s your mind you have to convince.', 'author': 'Unknown'},
    {'quote': 'The pain you feel today will be the strength you feel tomorrow.', 'author': 'Unknown'},
    {'quote': 'Don\'t wish for it, work for it.', 'author': 'Unknown'},
    {'quote': 'The only way to define your limits is by going beyond them.', 'author': 'Unknown'},
    {'quote': 'Strive for progress, not perfection.', 'author': 'Unknown'},
    {'quote': 'Wake up with determination. Go to bed with satisfaction.', 'author': 'Unknown'},
    {'quote': 'The difference between try and triumph is a little umph.', 'author': 'Unknown'},
    {'quote': 'Your fitness is 100% mental. Your body won\'t go where your mind doesn\'t push it.', 'author': 'Unknown'},
    {'quote': 'A one hour workout is only 4% of your day. No excuses.', 'author': 'Unknown'},
    {'quote': 'The body achieves what the mind believes.', 'author': 'Unknown'},
    {'quote': 'Take care of your body. It\'s the only place you have to live.', 'author': 'Jim Rohn'},
    {'quote': 'The secret of getting ahead is getting started.', 'author': 'Mark Twain'},
  ];

  static Map<String, String> getDailyQuote() {
    final today = DateTime.now();
    final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
    final index = dayOfYear % quotes.length;
    return quotes[index];
  }
}

class PersonalRecord {
  final String exerciseName;
  final int bestValue;
  final String unit; // 'seconds', 'reps', etc.
  final DateTime achievedDate;

  PersonalRecord({
    required this.exerciseName,
    required this.bestValue,
    required this.unit,
    required this.achievedDate,
  });

  Map<String, dynamic> toJson() => {
    'exerciseName': exerciseName,
    'bestValue': bestValue,
    'unit': unit,
    'achievedDate': achievedDate.toIso8601String(),
  };

  factory PersonalRecord.fromJson(Map<String, dynamic> json) {
    return PersonalRecord(
      exerciseName: json['exerciseName'],
      bestValue: json['bestValue'],
      unit: json['unit'],
      achievedDate: DateTime.parse(json['achievedDate']),
    );
  }
}

class UserProgress {
  static int totalWorkoutsCompleted = 0;
  static int totalCaloriesBurned = 0;
  static List<String> unlockedAchievements = [];
  static List<String> completedWorkouts = [];
  static List<Workout> customWorkouts = [];
  static Map<DateTime, List<String>> workoutCalendar = {};
  static Map<String, PersonalRecord> personalRecords = {};
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    totalWorkoutsCompleted = _prefs.getInt('totalWorkoutsCompleted') ?? 0;
    totalCaloriesBurned = _prefs.getInt('totalCaloriesBurned') ?? 0;
    unlockedAchievements = _prefs.getStringList('unlockedAchievements') ?? [];
    completedWorkouts = _prefs.getStringList('completedWorkouts') ?? [];

    // Load custom workouts
    final String? customWorkoutsJson = _prefs.getString('customWorkouts');
    if (customWorkoutsJson != null) {
      final List<dynamic> decoded = json.decode(customWorkoutsJson);
      customWorkouts = decoded.map((e) => Workout.fromJson(e)).toList();
    }

    // Load calendar data
    final String? calendarJson = _prefs.getString('workoutCalendar');
    if (calendarJson != null) {
      final Map<String, dynamic> decoded = json.decode(calendarJson);
      workoutCalendar = decoded.map((key, value) {
        return MapEntry(DateTime.parse(key), List<String>.from(value));
      });
    }

    // Load personal records
    final String? prsJson = _prefs.getString('personalRecords');
    if (prsJson != null) {
      final Map<String, dynamic> decoded = json.decode(prsJson);
      personalRecords = decoded.map((key, value) {
        return MapEntry(key, PersonalRecord.fromJson(value));
      });
    }
  }

  static Future<void> _saveData() async {
    await _prefs.setInt('totalWorkoutsCompleted', totalWorkoutsCompleted);
    await _prefs.setInt('totalCaloriesBurned', totalCaloriesBurned);
    await _prefs.setStringList('unlockedAchievements', unlockedAchievements);
    await _prefs.setStringList('completedWorkouts', completedWorkouts);

    // Save custom workouts
    final String customWorkoutsJson = json.encode(customWorkouts.map((e) => e.toJson()).toList());
    await _prefs.setString('customWorkouts', customWorkoutsJson);

    // Save calendar data
    final Map<String, dynamic> calendarJson = workoutCalendar.map((key, value) {
      return MapEntry(key.toIso8601String(), value);
    });
    await _prefs.setString('workoutCalendar', json.encode(calendarJson));

    // Save personal records
    final Map<String, dynamic> prsJson = personalRecords.map((key, value) {
      return MapEntry(key, value.toJson());
    });
    await _prefs.setString('personalRecords', json.encode(prsJson));
  }

  static void completeWorkout(String workoutName, int calories) {
    totalWorkoutsCompleted++;
    totalCaloriesBurned += calories;
    completedWorkouts.add(workoutName);
    
    final today = DateTime.now();
    final dateKey = DateTime(today.year, today.month, today.day);
    
    if (workoutCalendar.containsKey(dateKey)) {
      workoutCalendar[dateKey]!.add(workoutName);
    } else {
      workoutCalendar[dateKey] = [workoutName];
    }
    
    checkAchievements();
    _saveData();
  }

  static void checkAchievements() {
    bool newUnlock = false;
    if (totalWorkoutsCompleted >= 1 && !unlockedAchievements.contains('First Workout')) {
      unlockedAchievements.add('First Workout');
      newUnlock = true;
    }
    if (totalWorkoutsCompleted >= 5 && !unlockedAchievements.contains('Getting Started')) {
      unlockedAchievements.add('Getting Started');
      newUnlock = true;
    }
    if (totalWorkoutsCompleted >= 10 && !unlockedAchievements.contains('Consistent Performer')) {
      unlockedAchievements.add('Consistent Performer');
      newUnlock = true;
    }
    if (totalWorkoutsCompleted >= 25 && !unlockedAchievements.contains('Fitness Enthusiast')) {
      unlockedAchievements.add('Fitness Enthusiast');
      newUnlock = true;
    }
    if (totalWorkoutsCompleted >= 50 && !unlockedAchievements.contains('Workout Warrior')) {
      unlockedAchievements.add('Workout Warrior');
      newUnlock = true;
    }
    if (totalCaloriesBurned >= 1000 && !unlockedAchievements.contains('Calorie Crusher')) {
      unlockedAchievements.add('Calorie Crusher');
      newUnlock = true;
    }
    if (totalCaloriesBurned >= 5000 && !unlockedAchievements.contains('Burn Master')) {
      unlockedAchievements.add('Burn Master');
      newUnlock = true;
    }
    
    if (newUnlock) {
      _saveData();
    }
  }

  static void addCustomWorkout(Workout workout) {
    customWorkouts.add(workout);
    _saveData();
  }

  static void updatePersonalRecord(String exerciseName, int value, String unit) {
    final key = exerciseName.toLowerCase();
    if (!personalRecords.containsKey(key) || personalRecords[key]!.bestValue < value) {
      personalRecords[key] = PersonalRecord(
        exerciseName: exerciseName,
        bestValue: value,
        unit: unit,
        achievedDate: DateTime.now(),
      );
      _saveData();
    }
  }

  static int get currentStreak {
    int streak = 0;
    final today = DateTime.now();
    DateTime checkDate = DateTime(today.year, today.month, today.day);

    // Check if we worked out today
    if (!workoutCalendar.containsKey(checkDate)) {
      // If not, check yesterday (maybe the streak is still alive from yesterday)
      checkDate = checkDate.subtract(const Duration(days: 1));
      if (!workoutCalendar.containsKey(checkDate)) {
        return 0;
      }
    }

    // Count backwards
    while (workoutCalendar.containsKey(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    return streak;
  }
}

class WorkoutRecommendationEngine {
  // Analyze user's workout history and recommend suitable workouts
  static List<Workout> getRecommendations(List<Workout> allWorkouts) {
    final recommendations = <Workout>[];

    // Get user's completed workout patterns
    final completedWorkoutNames = UserProgress.completedWorkouts;
    final totalWorkouts = UserProgress.totalWorkoutsCompleted;

    // If user is new (< 3 workouts), recommend beginner workouts
    if (totalWorkouts < 3) {
      recommendations.addAll(
        allWorkouts.where((w) => w.difficulty == 'Beginner').take(3)
      );
      return recommendations;
    }

    // Calculate difficulty preference based on history
    final difficultyCount = <String, int>{};
    for (var workout in allWorkouts) {
      final count = completedWorkoutNames.where((name) => name == workout.name).length;
      difficultyCount[workout.difficulty] = (difficultyCount[workout.difficulty] ?? 0) + count;
    }

    // Find user's preferred difficulty level
    String preferredDifficulty = 'Intermediate';
    int maxCount = 0;
    difficultyCount.forEach((difficulty, count) {
      if (count > maxCount) {
        maxCount = count;
        preferredDifficulty = difficulty;
      }
    });

    // Get workouts at preferred difficulty that user hasn't done much
    final workoutFrequency = <String, int>{};
    for (var name in completedWorkoutNames) {
      workoutFrequency[name] = (workoutFrequency[name] ?? 0) + 1;
    }

    // Recommend workouts user hasn't tried or done less frequently
    final lessFrequentWorkouts = allWorkouts.where((workout) {
      final frequency = workoutFrequency[workout.name] ?? 0;
      return workout.difficulty == preferredDifficulty && frequency < 3;
    }).toList();

    recommendations.addAll(lessFrequentWorkouts.take(2));

    // Also recommend one workout at the next difficulty level for progression
    String nextDifficulty;
    if (preferredDifficulty == 'Beginner') {
      nextDifficulty = 'Intermediate';
    } else if (preferredDifficulty == 'Intermediate') {
      nextDifficulty = 'Advanced';
    } else {
      nextDifficulty = 'Advanced'; // Stay at advanced
    }

    final progressionWorkout = allWorkouts.firstWhere(
      (w) => w.difficulty == nextDifficulty && (workoutFrequency[w.name] ?? 0) < 2,
      orElse: () => allWorkouts.first,
    );

    if (!recommendations.contains(progressionWorkout)) {
      recommendations.add(progressionWorkout);
    }

    // If we still don't have enough recommendations, add popular workouts
    if (recommendations.length < 3) {
      final remaining = allWorkouts.where((w) => !recommendations.contains(w)).take(3 - recommendations.length);
      recommendations.addAll(remaining);
    }

    return recommendations.take(3).toList();
  }

  static String getRecommendationReason(Workout workout) {
    final totalWorkouts = UserProgress.totalWorkoutsCompleted;
    final completedWorkoutNames = UserProgress.completedWorkouts;
    final frequency = completedWorkoutNames.where((name) => name == workout.name).length;

    if (totalWorkouts < 3) {
      return 'Perfect for beginners';
    }

    if (frequency == 0) {
      return 'Try something new!';
    }

    if (frequency < 2) {
      return 'Haven\'t tried this in a while';
    }

    if (workout.difficulty == 'Advanced') {
      return 'Challenge yourself!';
    }

    return 'Recommended for you';
  }
}

class WelcomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const WelcomePage({Key? key, required this.onThemeToggle, required this.isDarkMode}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppColors.darkBg,
                    AppColors.darkCard,
                    AppColors.primary.withOpacity(0.1),
                  ]
                : [
                    AppColors.lightBg,
                    Colors.white,
                    AppColors.primary.withOpacity(0.05),
                  ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    onPressed: widget.onThemeToggle,
                  ),
                ),
                const Spacer(flex: 1),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppStyles.accentGradient,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 50,
                                spreadRadius: 10,
                              ),
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.3),
                                blurRadius: 80,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                           child: ClipOval(
                            child: Image.asset(
                              'lib/assets/logo.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.fitness_center,
                                  size: 90,
                                  color: AppColors.textLight,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ShaderMask(
                          shaderCallback: (bounds) => AppStyles.accentGradient.createShader(bounds),
                          child: Text(
                            'BarookFit',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              color: isDark ? AppColors.textLight : AppColors.textDark,
                              letterSpacing: 1,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'YOUR FITNESS JOURNEY STARTS HERE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.textGray : AppColors.textGrayDark,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Builder(
                          builder: (context) {
                            final dailyQuote = MotivationalQuotes.getDailyQuote();
                            return Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkCard.withOpacity(0.6)
                                    : AppColors.lightCard.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.format_quote,
                                    color: AppColors.primary,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    dailyQuote['quote']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: isDark ? AppColors.textLight : AppColors.textDark,
                                      height: 1.6,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '— ${dailyQuote['author']}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainNavigationPage(
                            onThemeToggle: widget.onThemeToggle,
                            isDarkMode: widget.isDarkMode,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                      decoration: BoxDecoration(
                        gradient: AppStyles.accentGradient,
                        borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.5),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flash_on_rounded,
                            color: AppColors.textLight,
                            size: 28,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "START YOUR JOURNEY",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textLight,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.textLight,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const MainNavigationPage({Key? key, required this.onThemeToggle, required this.isDarkMode}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      WorkoutsPage(isDarkMode: widget.isDarkMode),
      CalendarPage(isDarkMode: widget.isDarkMode),
      ProfilePage(isDarkMode: widget.isDarkMode, onThemeToggle: widget.onThemeToggle),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: widget.isDarkMode ? AppColors.darkCard : AppColors.lightCard,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(widget.isDarkMode ? 0.3 : 0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppStyles.radiusLarge),
            topRight: Radius.circular(AppStyles.radiusLarge),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: widget.isDarkMode ? AppColors.textGray : AppColors.textGrayDark,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 11,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center_outlined, size: 26),
                  activeIcon: Icon(Icons.fitness_center, size: 28),
                  label: 'Workouts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined, size: 26),
                  activeIcon: Icon(Icons.calendar_today, size: 28),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, size: 26),
                  activeIcon: Icon(Icons.person, size: 28),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Workout {
  final String name;
  final String duration;
  final String difficulty;
  final int calories;
  final IconData icon;
  final List<Exercise> exercises;

  Workout({
    required this.name,
    required this.duration,
    required this.difficulty,
    required this.calories,
    required this.icon,
    required this.exercises,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'duration': duration,
    'difficulty': difficulty,
    'calories': calories,
    'icon': icon.codePoint,
    'exercises': exercises.map((e) => e.toJson()).toList(),
  };

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json['name'],
      duration: json['duration'],
      difficulty: json['difficulty'],
      calories: json['calories'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
    );
  }
}

class Exercise {
  final String name;
  final int duration;
  final int rest;

  Exercise({required this.name, required this.duration, required this.rest});

  Map<String, dynamic> toJson() => {
    'name': name,
    'duration': duration,
    'rest': rest,
  };

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      duration: json['duration'],
      rest: json['rest'],
    );
  }
}

class WorkoutsPage extends StatefulWidget {
  final bool isDarkMode;

  const WorkoutsPage({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  String selectedFilter = 'All';
  final List<Workout> workouts = [
    Workout(
      name: 'Full Body Blast',
      duration: '30 min',
      difficulty: 'Intermediate',
      calories: 300,
      icon: Icons.accessibility_new,
      exercises: [
        Exercise(name: 'Push-ups', duration: 30, rest: 15),
        Exercise(name: 'Squats', duration: 40, rest: 15),
        Exercise(name: 'Planks', duration: 45, rest: 20),
        Exercise(name: 'Lunges', duration: 30, rest: 15),
        Exercise(name: 'Burpees', duration: 30, rest: 20),
      ],
    ),
    Workout(
      name: 'Core Crusher',
      duration: '20 min',
      difficulty: 'Advanced',
      calories: 200,
      icon: Icons.sports_gymnastics,
      exercises: [
        Exercise(name: 'Crunches', duration: 30, rest: 10),
        Exercise(name: 'Russian Twists', duration: 40, rest: 15),
        Exercise(name: 'Leg Raises', duration: 30, rest: 15),
        Exercise(name: 'Mountain Climbers', duration: 30, rest: 10),
        Exercise(name: 'Plank Hold', duration: 60, rest: 20),
      ],
    ),
    Workout(
      name: 'Cardio Burn',
      duration: '25 min',
      difficulty: 'Beginner',
      calories: 350,
      icon: Icons.directions_run,
      exercises: [
        Exercise(name: 'Jumping Jacks', duration: 30, rest: 10),
        Exercise(name: 'High Knees', duration: 30, rest: 10),
        Exercise(name: 'Butt Kicks', duration: 30, rest: 10),
        Exercise(name: 'Running in Place', duration: 60, rest: 15),
        Exercise(name: 'Jump Rope', duration: 45, rest: 15),
      ],
    ),
    Workout(
      name: 'Upper Body Power',
      duration: '35 min',
      difficulty: 'Advanced',
      calories: 280,
      icon: Icons.fitness_center,
      exercises: [
        Exercise(name: 'Push-ups', duration: 40, rest: 15),
        Exercise(name: 'Dips', duration: 30, rest: 15),
        Exercise(name: 'Pike Push-ups', duration: 30, rest: 15),
        Exercise(name: 'Diamond Push-ups', duration: 30, rest: 15),
        Exercise(name: 'Arm Circles', duration: 45, rest: 10),
      ],
    ),
    Workout(
      name: 'Leg Day Intensive',
      duration: '40 min',
      difficulty: 'Advanced',
      calories: 400,
      icon: Icons.directions_walk,
      exercises: [
        Exercise(name: 'Squats', duration: 45, rest: 15),
        Exercise(name: 'Lunges', duration: 40, rest: 15),
        Exercise(name: 'Wall Sits', duration: 60, rest: 20),
        Exercise(name: 'Calf Raises', duration: 40, rest: 10),
        Exercise(name: 'Jump Squats', duration: 30, rest: 20),
      ],
    ),
    Workout(
      name: 'Morning Energizer',
      duration: '15 min',
      difficulty: 'Beginner',
      calories: 150,
      icon: Icons.wb_sunny,
      exercises: [
        Exercise(name: 'Stretches', duration: 60, rest: 10),
        Exercise(name: 'Light Cardio', duration: 30, rest: 10),
        Exercise(name: 'Yoga Poses', duration: 45, rest: 15),
        Exercise(name: 'Breathing Exercises', duration: 30, rest: 10),
        Exercise(name: 'Jumping Jacks', duration: 30, rest: 10),
      ],
    ),
    Workout(
      name: 'HIIT Inferno',
      duration: '20 min',
      difficulty: 'Advanced',
      calories: 450,
      icon: Icons.local_fire_department,
      exercises: [
        Exercise(name: 'Burpees', duration: 30, rest: 15),
        Exercise(name: 'Mountain Climbers', duration: 40, rest: 15),
        Exercise(name: 'Jump Squats', duration: 30, rest: 15),
        Exercise(name: 'High Knees', duration: 30, rest: 10),
        Exercise(name: 'Plank Jacks', duration: 30, rest: 15),
      ],
    ),
    Workout(
      name: 'Abs Sculptor',
      duration: '15 min',
      difficulty: 'Intermediate',
      calories: 120,
      icon: Icons.filter_6,
      exercises: [
        Exercise(name: 'Bicycle Crunches', duration: 30, rest: 10),
        Exercise(name: 'Plank', duration: 60, rest: 15),
        Exercise(name: 'Leg Raises', duration: 30, rest: 15),
        Exercise(name: 'V-Ups', duration: 30, rest: 15),
        Exercise(name: 'Side Planks', duration: 45, rest: 15),
      ],
    ),
    Workout(
      name: 'Flexibility Flow',
      duration: '25 min',
      difficulty: 'Beginner',
      calories: 100,
      icon: Icons.self_improvement,
      exercises: [
        Exercise(name: 'Yoga Stretches', duration: 60, rest: 10),
        Exercise(name: 'Hip Openers', duration: 45, rest: 10),
        Exercise(name: 'Hamstring Stretches', duration: 45, rest: 10),
        Exercise(name: 'Shoulder Rolls', duration: 30, rest: 10),
        Exercise(name: 'Cat-Cow', duration: 40, rest: 10),
      ],
    ),
    Workout(
      name: 'Strength Builder',
      duration: '45 min',
      difficulty: 'Advanced',
      calories: 380,
      icon: Icons.sports_kabaddi,
      exercises: [
        Exercise(name: 'Pull-ups', duration: 30, rest: 20),
        Exercise(name: 'Push-ups', duration: 40, rest: 15),
        Exercise(name: 'Squats', duration: 45, rest: 20),
        Exercise(name: 'Deadlifts', duration: 45, rest: 20),
        Exercise(name: 'Bench Press', duration: 45, rest: 20),
      ],
    ),

    Workout(
      name: 'Fat Burner Express',
      duration: '25 min',
      difficulty: 'Intermediate',
      calories: 320,
      icon: Icons.whatshot,
      exercises: [
        Exercise(name: 'Burpees', duration: 30, rest: 15),
        Exercise(name: 'Jump Rope', duration: 45, rest: 15),
        Exercise(name: 'Mountain Climbers', duration: 30, rest: 10),
        Exercise(name: 'Jumping Jacks', duration: 30, rest: 10),
        Exercise(name: 'High Knees', duration: 30, rest: 15),
      ],
    ),
    Workout(
      name: 'Mobility Master',
      duration: '20 min',
      difficulty: 'Beginner',
      calories: 90,
      icon: Icons.accessibility,
      exercises: [
        Exercise(name: 'Dynamic Stretches', duration: 45, rest: 10),
        Exercise(name: 'Hip Circles', duration: 30, rest: 10),
        Exercise(name: 'Arm Swings', duration: 30, rest: 10),
        Exercise(name: 'Leg Swings', duration: 30, rest: 10),
        Exercise(name: 'Torso Twists', duration: 30, rest: 10),
      ],
    ),
    Workout(
      name: 'Chest & Arms',
      duration: '30 min',
      difficulty: 'Intermediate',
      calories: 260,
      icon: Icons.volunteer_activism,
      exercises: [
        Exercise(name: 'Push-ups', duration: 40, rest: 15),
        Exercise(name: 'Tricep Dips', duration: 30, rest: 15),
        Exercise(name: 'Chest Flyes', duration: 35, rest: 15),
        Exercise(name: 'Bicep Curls', duration: 30, rest: 10),
        Exercise(name: 'Shoulder Press', duration: 35, rest: 15),
      ],
    ),
    Workout(
      name: 'Endurance Challenge',
      duration: '50 min',
      difficulty: 'Advanced',
      calories: 500,
      icon: Icons.timer,
      exercises: [
        Exercise(name: 'Running', duration: 300, rest: 30),
        Exercise(name: 'Cycling', duration: 240, rest: 30),
        Exercise(name: 'Jump Rope', duration: 60, rest: 20),
        Exercise(name: 'Burpees', duration: 45, rest: 20),
        Exercise(name: 'Box Jumps', duration: 40, rest: 20),
      ],
    ),
    Workout(
      name: 'Recovery & Stretch',
      duration: '30 min',
      difficulty: 'Beginner',
      calories: 80,
      icon: Icons.spa,
      exercises: [
        Exercise(name: 'Static Stretches', duration: 90, rest: 10),
        Exercise(name: 'Foam Rolling', duration: 60, rest: 15),
        Exercise(name: 'Breathing', duration: 60, rest: 10),
        Exercise(name: 'Meditation', duration: 120, rest: 0),
        Exercise(name: 'Gentle Yoga', duration: 90, rest: 10),
      ],
    ),
  ];

  List<Workout> get allWorkouts => [...UserProgress.customWorkouts, ...workouts];

  List<Workout> get filteredWorkouts {
    final filteredWorkouts = selectedFilter == 'All'
        ? allWorkouts
        : allWorkouts.where((w) => w.difficulty == selectedFilter).toList();
    return filteredWorkouts;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0A0E21),
                    const Color(0xFF1D1E33),
                  ]
                : [
                    Colors.grey[50]!,
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Workouts',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              // Recommendations Section
              if (UserProgress.totalWorkoutsCompleted > 0) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Recommended For You',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: WorkoutRecommendationEngine.getRecommendations(allWorkouts).length,
                    itemBuilder: (context, index) {
                      final recommendations = WorkoutRecommendationEngine.getRecommendations(allWorkouts);
                      final workout = recommendations[index];
                      final reason = WorkoutRecommendationEngine.getRecommendationReason(workout);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutDetailPage(workout: workout, isDarkMode: isDark),
                            ),
                          );
                        },
                        child: Container(
                          width: 280,
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.purple, Colors.deepPurple],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(workout.icon, color: Colors.white, size: 28),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      workout.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      reason,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.timer, color: Colors.white70, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        workout.duration,
                                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                                      ),
                                      const SizedBox(width: 12),
                                      const Icon(Icons.local_fire_department, color: Colors.white70, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${workout.calories} cal',
                                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: isDark ? Colors.white24 : Colors.black12),
                ),
                const SizedBox(height: 10),
              ],
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: ['All', 'Beginner', 'Intermediate', 'Advanced'].map((filter) {
                    final isSelected = selectedFilter == filter;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.cyan : (isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black54),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = filteredWorkouts[index];
                    return WorkoutCard(workout: workout, isDarkMode: isDark);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateWorkoutPage(isDarkMode: isDark),
            ),
          );
          setState(() {}); // Refresh to show new workout
        },
        label: const Text('Create Workout'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final bool isDarkMode;

  const WorkoutCard({Key? key, required this.workout, required this.isDarkMode}) : super(key: key);

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return AppColors.success;
      case 'Intermediate':
        return AppColors.warning;
      case 'Advanced':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  LinearGradient _getDifficultyGradient(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return AppStyles.coolGradient;
      case 'Intermediate':
        return AppStyles.warmGradient;
      case 'Advanced':
        return const LinearGradient(
          colors: [AppColors.error, AppColors.accentOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return AppStyles.primaryGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutDetailPage(workout: workout, isDarkMode: isDarkMode),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [
                    AppColors.darkCard,
                    AppColors.darkCardLight,
                  ]
                : [
                    AppColors.lightCard,
                    AppColors.lightCardAlt,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppStyles.radiusLarge),
          border: Border.all(
            color: _getDifficultyColor(workout.difficulty).withOpacity(0.3),
            width: 2,
          ),
          boxShadow: isDarkMode
              ? AppStyles.cardShadowDark
              : AppStyles.cardShadow,
        ),
        child: Stack(
          children: [
            // Gradient accent on the left edge
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 6,
                decoration: BoxDecoration(
                  gradient: _getDifficultyGradient(workout.difficulty),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppStyles.radiusLarge),
                    bottomLeft: Radius.circular(AppStyles.radiusLarge),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: _getDifficultyGradient(workout.difficulty),
                          borderRadius: BorderRadius.circular(AppStyles.radiusMedium),
                          boxShadow: [
                            BoxShadow(
                              color: _getDifficultyColor(workout.difficulty).withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(workout.icon, color: AppColors.textLight, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workout.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: isDarkMode ? AppColors.textLight : AppColors.textDark,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                gradient: _getDifficultyGradient(workout.difficulty),
                                borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
                              ),
                              child: Text(
                                workout.difficulty.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _InfoChip(Icons.timer_outlined, workout.duration, isDarkMode),
                      const SizedBox(width: 12),
                      _InfoChip(Icons.local_fire_department_outlined, '${workout.calories} cal', isDarkMode),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDarkMode;

  const _InfoChip(this.icon, this.label, this.isDarkMode);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.primary.withOpacity(0.15)
            : AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppStyles.radiusSmall),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isDarkMode ? AppColors.textLight : AppColors.textDark,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutDetailPage extends StatefulWidget {
  final Workout workout;
  final bool isDarkMode;

  const WorkoutDetailPage({Key? key, required this.workout, required this.isDarkMode}) : super(key: key);

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  bool isStarted = false;
  bool isPaused = false;
  bool isResting = false;
  int currentExerciseIndex = 0;
  int countdown = 0;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startWorkout() {
    setState(() {
      isStarted = true;
      isPaused = false;
      currentExerciseIndex = 0;
      countdown = widget.workout.exercises[0].duration;
      isResting = false;
    });
    startTimer();
  }

  void pauseWorkout() {
    setState(() {
      isPaused = true;
    });
    timer?.cancel();
  }

  void resumeWorkout() {
    setState(() {
      isPaused = false;
    });
    startTimer();
  }

  void stopWorkout() {
    timer?.cancel();
    
    if (currentExerciseIndex >= widget.workout.exercises.length - 1 && countdown == 0) {
      UserProgress.completeWorkout(widget.workout.name, widget.workout.calories);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: widget.isDarkMode ? const Color(0xFF1D1E33) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            '🎉 Workout Complete!',
            style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
          ),
          content: Text(
            'Great job! You burned ${widget.workout.calories} calories.',
            style: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Done', style: TextStyle(color: Colors.cyan)),
            ),
          ],
        ),
      );
    }
    
    setState(() {
      isStarted = false;
      isPaused = false;
      currentExerciseIndex = 0;
      countdown = 0;
      isResting = false;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          if (isResting) {
            isResting = false;
            currentExerciseIndex++;
            
            if (currentExerciseIndex >= widget.workout.exercises.length) {
              timer.cancel();
              stopWorkout();
              return;
            }
            
            countdown = widget.workout.exercises[currentExerciseIndex].duration;
          } else {
            isResting = true;
            countdown = widget.workout.exercises[currentExerciseIndex].rest;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0A0E21),
                    const Color(0xFF1D1E33),
                    const Color(0xFF2A2D5F),
                  ]
                : [
                    Colors.grey[50]!,
                    Colors.white,
                    Colors.blue[50]!,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.workout.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (isStarted) ...[
                        Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: isResting
                                  ? [Colors.orange.withOpacity(0.3), Colors.red.withOpacity(0.3)]
                                  : [Colors.cyan.withOpacity(0.3), Colors.blue.withOpacity(0.3)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (isResting ? Colors.orange : Colors.cyan).withOpacity(0.5),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                '$countdown',
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                isResting ? 'Rest' : 'Exercise',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          isResting ? 'Get Ready!' : widget.workout.exercises[currentExerciseIndex].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Exercise ${currentExerciseIndex + 1} of ${widget.workout.exercises.length}',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                        LinearProgressIndicator(
                          value: (currentExerciseIndex + 1) / widget.workout.exercises.length,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
                          minHeight: 8,
                        ),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.cyan.withOpacity(0.3),
                                Colors.blue.withOpacity(0.3),
                              ],
                            ),
                          ),
                          child: Icon(
                            widget.workout.icon,
                            size: 100,
                            color: Colors.cyan,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatCard('Duration', widget.workout.duration, Icons.timer, isDark),
                            _StatCard('Calories', '${widget.workout.calories}', Icons.local_fire_department, isDark),
                            _StatCard('Level', widget.workout.difficulty, Icons.trending_up, isDark),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Exercises',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (!isStarted)
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.workout.exercises.length,
                            itemBuilder: (context, index) {
                              final exercise = widget.workout.exercises[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isDark
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 5,
                                          ),
                                        ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.cyan.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.cyan,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        exercise.name,
                                        style: TextStyle(
                                          color: isDark ? Colors.white : Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${exercise.duration}s',
                                      style: TextStyle(
                                        color: isDark ? Colors.white70 : Colors.black54,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (isStarted) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: isPaused ? resumeWorkout : pauseWorkout,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.orange, width: 2),
                                ),
                                child: Icon(
                                  isPaused ? Icons.play_arrow : Icons.pause,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: stopWorkout,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.red, width: 2),
                                ),
                                child: const Icon(
                                  Icons.stop,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        GestureDetector(
                          onTap: startWorkout,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.cyan, Colors.blue],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyan.withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Start Workout',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isDarkMode;

  const _StatCard(this.label, this.value, this.icon, this.isDarkMode);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.cyan, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isDarkMode ? Colors.white.withOpacity(0.6) : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  final bool isDarkMode;

  const CalendarPage({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = _getEventsForDay(_selectedDay!);
  }

  List<String> _getEventsForDay(DateTime day) {
    final dateKey = DateTime(day.year, day.month, day.day);
    return UserProgress.workoutCalendar[dateKey] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xFF0A0E21), const Color(0xFF1D1E33)]
                : [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Workout Calendar',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark ? [] : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _selectedEvents = _getEventsForDay(selectedDay);
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: _getEventsForDay,
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
                    weekendTextStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                    outsideTextStyle: TextStyle(color: isDark ? Colors.white24 : Colors.black26),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.cyan,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    formatButtonDecoration: BoxDecoration(
                      border: Border.all(color: isDark ? Colors.white54 : Colors.black54),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black),
                    rightChevronIcon: Icon(Icons.chevron_right, color: isDark ? Colors.white : Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Workouts on ${DateFormat.yMMMd().format(_selectedDay!)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _selectedEvents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center_outlined,
                              size: 48,
                              color: isDark ? Colors.white24 : Colors.black26,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'No workouts this day',
                              style: TextStyle(
                                color: isDark ? Colors.white54 : Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _selectedEvents.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.cyan.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.cyan,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  _selectedEvents[index],
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const ProfilePage({Key? key, required this.isDarkMode, required this.onThemeToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {'title': 'First Workout', 'icon': Icons.star, 'unlocked': UserProgress.unlockedAchievements.contains('First Workout')},
      {'title': 'Getting Started', 'icon': Icons.local_fire_department, 'unlocked': UserProgress.unlockedAchievements.contains('Getting Started')},
      {'title': 'Consistent Performer', 'icon': Icons.trending_up, 'unlocked': UserProgress.unlockedAchievements.contains('Consistent Performer')},
      {'title': 'Fitness Enthusiast', 'icon': Icons.favorite, 'unlocked': UserProgress.unlockedAchievements.contains('Fitness Enthusiast')},
      {'title': 'Workout Warrior', 'icon': Icons.military_tech, 'unlocked': UserProgress.unlockedAchievements.contains('Workout Warrior')},
      {'title': 'Calorie Crusher', 'icon': Icons.whatshot, 'unlocked': UserProgress.unlockedAchievements.contains('Calorie Crusher')},
      {'title': 'Burn Master', 'icon': Icons.emoji_events, 'unlocked': UserProgress.unlockedAchievements.contains('Burn Master')},
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [const Color(0xFF0A0E21), const Color(0xFF1D1E33)]
                : [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isDarkMode ? Icons.light_mode : Icons.dark_mode,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            onPressed: onThemeToggle,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.settings,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsPage(isDarkMode: isDarkMode),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.cyan, Colors.blue],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Colors.white, size: 40),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fitness Hero',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Keep pushing!',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalRecordsPage(isDarkMode: isDarkMode),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange.withOpacity(0.8), Colors.deepOrange.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.emoji_events, color: Colors.white, size: 30),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal Records',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'View your best performances',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          '${UserProgress.totalWorkoutsCompleted}',
                          'Workouts',
                          Icons.fitness_center,
                          isDarkMode,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatBox(
                          '${UserProgress.totalCaloriesBurned}',
                          'Calories',
                          Icons.local_fire_department,
                          isDarkMode,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _StatBox(
                    '${UserProgress.currentStreak} days',
                    'Current Streak',
                    Icons.whatshot,
                    isDarkMode,
                    fullWidth: true,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: achievements.length,
                    itemBuilder: (context, index) {
                      final achievement = achievements[index];
                      final isUnlocked = achievement['unlocked'] as bool;
                      
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isUnlocked ? Colors.cyan : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: isDarkMode
                              ? []
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                  ),
                                ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              achievement['icon'] as IconData,
                              color: isUnlocked ? Colors.cyan : (isDarkMode ? Colors.white30 : Colors.grey),
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              achievement['title'] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isUnlocked
                                    ? (isDarkMode ? Colors.white : Colors.black)
                                    : (isDarkMode ? Colors.white30 : Colors.grey),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final bool isDarkMode;
  final bool fullWidth;

  const _StatBox(this.value, this.label, this.icon, this.isDarkMode, {this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.cyan, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class CreateWorkoutPage extends StatefulWidget {
  final bool isDarkMode;

  const CreateWorkoutPage({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _durationController = TextEditingController();
  final _caloriesController = TextEditingController();
  String _difficulty = 'Beginner';
  List<Exercise> _exercises = [];

  void _addExercise() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final durationController = TextEditingController();
        final restController = TextEditingController();
        
        return AlertDialog(
          backgroundColor: widget.isDarkMode ? const Color(0xFF1D1E33) : Colors.white,
          title: Text('Add Exercise', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54)),
                style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
              TextField(
                controller: durationController,
                decoration: InputDecoration(labelText: 'Duration (sec)', labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54)),
                keyboardType: TextInputType.number,
                style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
              TextField(
                controller: restController,
                decoration: InputDecoration(labelText: 'Rest (sec)', labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54)),
                keyboardType: TextInputType.number,
                style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && durationController.text.isNotEmpty) {
                  setState(() {
                    _exercises.add(Exercise(
                      name: nameController.text,
                      duration: int.parse(durationController.text),
                      rest: int.tryParse(restController.text) ?? 10,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveWorkout() {
    if (_formKey.currentState!.validate() && _exercises.isNotEmpty) {
      final workout = Workout(
        name: _nameController.text,
        duration: _durationController.text,
        difficulty: _difficulty,
        calories: int.tryParse(_caloriesController.text) ?? 100,
        icon: Icons.fitness_center,
        exercises: _exercises,
      );
      
      UserProgress.addCustomWorkout(workout);
      Navigator.pop(context);
    } else if (_exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one exercise')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0E21) : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Create Workout'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Workout Name',
                labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
              ),
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _durationController,
                    decoration: InputDecoration(
                      labelText: 'Duration (e.g. 30 min)',
                      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    ),
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _caloriesController,
                    decoration: InputDecoration(
                      labelText: 'Est. Calories',
                      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _difficulty,
              dropdownColor: isDark ? const Color(0xFF1D1E33) : Colors.white,
              decoration: InputDecoration(
                labelText: 'Difficulty',
                labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
              ),
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              items: ['Beginner', 'Intermediate', 'Advanced'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _difficulty = newValue!;
                });
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercises',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: _addExercise,
                  icon: const Icon(Icons.add_circle, color: Colors.cyan),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ..._exercises.asMap().entries.map((entry) {
              final index = entry.key;
              final exercise = entry.value;
              return Card(
                color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.cyan.withOpacity(0.2),
                    child: Text('${index + 1}', style: const TextStyle(color: Colors.cyan)),
                  ),
                  title: Text(exercise.name, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                  subtitle: Text('${exercise.duration}s work / ${exercise.rest}s rest', style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _exercises.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveWorkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Save Workout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;

  const SettingsPage({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('userName') ?? 'Fitness Hero';
      _weightController.text = prefs.getString('userWeight') ?? '';
      _heightController.text = prefs.getString('userHeight') ?? '';
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userWeight', _weightController.text);
    await prefs.setString('userHeight', _heightController.text);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved!')),
      );
    }
  }

  Future<void> _resetProgress() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: widget.isDarkMode ? const Color(0xFF1D1E33) : Colors.white,
        title: Text('Reset Progress?', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
        content: Text('This will delete all your workout history and achievements. This cannot be undone.', style: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // Re-init UserProgress to clear static variables
      await UserProgress.init();
      if (mounted) {
        Navigator.pop(context); // Close settings
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Progress reset. Please restart the app.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0E21) : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Profile Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Display Name',
              labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
              prefixIcon: Icon(Icons.person, color: isDark ? Colors.white70 : Colors.black54),
            ),
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    prefixIcon: Icon(Icons.monitor_weight, color: isDark ? Colors.white70 : Colors.black54),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    prefixIcon: Icon(Icons.height, color: isDark ? Colors.white70 : Colors.black54),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'Danger Zone',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: _resetProgress,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'Reset All Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalRecordsPage extends StatefulWidget {
  final bool isDarkMode;

  const PersonalRecordsPage({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<PersonalRecordsPage> createState() => _PersonalRecordsPageState();
}

class _PersonalRecordsPageState extends State<PersonalRecordsPage> {
  void _addPersonalRecord() {
    final nameController = TextEditingController();
    final valueController = TextEditingController();
    String selectedUnit = 'seconds';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: widget.isDarkMode ? const Color(0xFF1D1E33) : Colors.white,
              title: Text('Add Personal Record', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Exercise Name',
                      labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54),
                    ),
                    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: valueController,
                    decoration: InputDecoration(
                      labelText: 'Best Value',
                      labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedUnit,
                    dropdownColor: widget.isDarkMode ? const Color(0xFF1D1E33) : Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Unit',
                      labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white70 : Colors.black54),
                    ),
                    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
                    items: ['seconds', 'reps', 'kg', 'miles', 'km'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setDialogState(() {
                        selectedUnit = newValue!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && valueController.text.isNotEmpty) {
                      UserProgress.updatePersonalRecord(
                        nameController.text,
                        int.parse(valueController.text),
                        selectedUnit,
                      );
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                  child: const Text('Add', style: TextStyle(color: Colors.cyan)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final records = UserProgress.personalRecords.values.toList();
    records.sort((a, b) => b.achievedDate.compareTo(a.achievedDate));

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0E21) : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Personal Records'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: records.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 80,
                    color: isDark ? Colors.white24 : Colors.black26,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No Personal Records Yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Track your best performances!',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)]
                          : [Colors.white, Colors.grey[50]!],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.orange.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: isDark
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(Icons.emoji_events, color: Colors.white, size: 30),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.exerciseName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${record.bestValue} ${record.unit}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Achieved on ${DateFormat.yMMMd().format(record.achievedDate)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white54 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPersonalRecord,
        label: const Text('Add PR'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
