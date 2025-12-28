import 'package:flutter/material.dart';
import '../../../../theme/ash_colors.dart';
import '../../../../theme/ash_text_styles.dart';
import '../../../../widgets/ash_scaffold.dart';
import '../../../../widgets/ash_button.dart';
import '../../../../widgets/ash_selection_tile.dart';
import '../../../../widgets/ash_card.dart';
import '../../../../widgets/ash_glass_card.dart';
import '../../../../widgets/ash_text_field.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNext;
  const WelcomeScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 16), // spacing
            // Avatar / Image area
            Expanded(
              flex: 3,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AshColors.primary.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AspectRatio(
                    aspectRatio: 4 / 5,
                    child: Image.network(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuDs-D1UA5-1YetZgjT_mK70OSof9_e0YkT06Ce6WPDNROxmWumhWVK7cobTZ9mvfrIvd0CK1BrY2VJ5sWXyUpb9fSmgAqbkGVPtvvqCjqtxm6tiYPR0po88JKKwx8jHk98WottOc5ZbYlK748UpYsz8Lfm0lTNVkFWYiN0lRtvFUp8NFp-VTEwTa3RJJNUMyHCk_grhnN9nF6uM3JrRwm3khdR4SivgojKhaWHwjvrsDGGAHOJG90N55NKiop7qS4HGLkuKdZzDoKI",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AshTextStyles.h2.copyWith(height: 1.2),
                        children: [
                          const TextSpan(text: "Hey! I'm Ash, your energetic "),
                          TextSpan(
                            text: "workout buddy",
                            style: AshTextStyles.h2.copyWith(
                              color: AshColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureItem(
                      Icons.sentiment_satisfied,
                      "Fun & Custom Plans",
                      "No boring routines. Just workouts that fit your vibe.",
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      Icons.bolt,
                      "I've Got Your Back",
                      "I'll spot your form and keep the energy high!",
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      Icons.emoji_events,
                      "Level Up Your Life",
                      "Smash those milestones and celebrate every single win.",
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Footer Button
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: AshButton(
                label: "Let's dive in!",
                icon: Icons.rocket_launch,
                onPressed: onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return AshCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AshColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AshColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AshTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: AshTextStyles.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FitnessLevelScreen extends StatefulWidget {
  final VoidCallback onNext;
  const FitnessLevelScreen({super.key, required this.onNext});

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  String _selectedLevel = "regular"; // Default selection

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: widget.onNext,
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: AshColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: AshColors.surfaceDark,
                      backgroundImage: NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuBPt_Hv684fZOPyKg_gPajsyCFKjYYPiAVnPxRzvpacDqBVyd8ixdAYx9Q7FU2_cjtXc0A0gUIzlV4yBiyTm8fCcizu3GUzQSbi5-8v4i7BpxrtULi3azW2zkVGvuVBKilKgyq6WaYsVu3TGgmwTidnKZmAO_Xy6W1xMMlETjwauhYllFTb8dWyzImuy3bvv8jbz_aCPYlrV-KmX-SuisZ7fUolzYfmwY1jMOjgAgJ9AYAdehfAK60UD4cxSY6cEiqPDOjGHxl7Ih0",
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "How epic is your activity level right now?",
                      style: AshTextStyles.h2.copyWith(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "No judgment here! Ash just wants to make sure your first workout hits the sweet spot.",
                      style: AshTextStyles.bodyMedium.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Options
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AshSelectionTile(
                              title: "Just planting the seeds",
                              leading: const Text(
                                "🌱",
                                style: TextStyle(fontSize: 24),
                              ),
                              isSelected: _selectedLevel == "beginner",
                              onTap: () =>
                                  setState(() => _selectedLevel = "beginner"),
                            ),
                            const SizedBox(height: 12),
                            AshSelectionTile(
                              title: "Keeping it casual",
                              subtitle: "1-2x/week",
                              leading: const Text(
                                "🏃",
                                style: TextStyle(fontSize: 24),
                              ),
                              isSelected: _selectedLevel == "casual",
                              onTap: () =>
                                  setState(() => _selectedLevel = "casual"),
                            ),
                            const SizedBox(height: 12),
                            AshSelectionTile(
                              title: "Making gains steadily",
                              subtitle: "3-4x/week",
                              leading: const Text(
                                "💪",
                                style: TextStyle(fontSize: 24),
                              ),
                              isSelected: _selectedLevel == "regular",
                              onTap: () =>
                                  setState(() => _selectedLevel = "regular"),
                            ),
                            const SizedBox(height: 12),
                            AshSelectionTile(
                              title: "Full-on beast mode",
                              subtitle: "5+x/week",
                              leading: const Text(
                                "🔥",
                                style: TextStyle(fontSize: 24),
                              ),
                              isSelected: _selectedLevel == "athlete",
                              onTap: () =>
                                  setState(() => _selectedLevel = "athlete"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: AshButton(
                label: "Let's Go!",
                icon: Icons.arrow_forward,
                onPressed: widget.onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalSettingScreen extends StatefulWidget {
  final VoidCallback onNext;
  const GoalSettingScreen({super.key, required this.onNext});

  @override
  State<GoalSettingScreen> createState() => _GoalSettingScreenState();
}

class _GoalSettingScreenState extends State<GoalSettingScreen> {
  String _selectedGoalType = "milestone";
  String? _selectedDistance = "5k";
  String _datePreference = "asap"; // asap or date

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AshColors.surfaceHighlight,
                        backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuAh52uLrAIjMfrnffhyRqN1wbR-ypOAUwQ2dQbh_z9MSp2-WVyRquJt4ib8mibKagsVOlAHAdCiBjWuuSPvpAAlLjWNIassYRXFvDHzoVzS2w2s99H5T6HsbF0dPTwfzZF6V7yrYmOMPdoJW0uzSgdO701mqRzcCQR2DNYhHYPIRZ_rBZWtVDxB41_mwf9wk527-C1Hd18Fg5kzguoI2H1XgyqH3K7powbNCVo1EQ_bozHSuPiZoW77NfGZWCq-b32Oj5v1vvqjLxI",
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        "ASH AI",
                        style: TextStyle(
                          color: AshColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "What awesome goal\nare you chasing?",
                      style: AshTextStyles.h1.copyWith(
                        fontSize: 32,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          color: AshColors.primary.withOpacity(0.5),
                          margin: const EdgeInsets.only(top: 4),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Let's figure out what gets you excited so I can build your dream plan!",
                            style: AshTextStyles.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildGoalCard(
                      "Milestone",
                      "Crush a specific distance",
                      Icons.flag,
                      "milestone",
                    ),
                    const SizedBox(height: 12),
                    _buildGoalCard(
                      "Performance",
                      "Get faster & stronger",
                      Icons.timer,
                      "performance",
                    ),
                    const SizedBox(height: 12),
                    _buildGoalCard(
                      "Just Flow",
                      "Keep the good vibes going",
                      Icons.cleaning_services,
                      "flow",
                    ),

                    const SizedBox(height: 32),
                    if (_selectedGoalType == "milestone") ...[
                      Text(
                        "Your Target Distance",
                        style: AshTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AshColors.surfaceHighlight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedDistance,
                            isExpanded: true,
                            dropdownColor: AshColors.surfaceHighlight,
                            style: AshTextStyles.display.copyWith(fontSize: 18),
                            icon: const Icon(
                              Icons.expand_more,
                              color: AshColors.textSecondary,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "5k",
                                child: Text("5 Kilometers (5K)"),
                              ),
                              DropdownMenuItem(
                                value: "10k",
                                child: Text("10 Kilometers (10K)"),
                              ),
                              DropdownMenuItem(
                                value: "21k",
                                child: Text("Half Marathon (21.1K)"),
                              ),
                              DropdownMenuItem(
                                value: "42k",
                                child: Text("Marathon (42.2K)"),
                              ),
                            ],
                            onChanged: (val) =>
                                setState(() => _selectedDistance = val),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.smart_toy,
                            size: 16,
                            color: AshColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Awesome choice! A 5K is the perfect start.",
                            style: AshTextStyles.bodyMedium.copyWith(
                              color: AshColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(height: 1, color: AshColors.borderDark),
                      const SizedBox(height: 24),
                      Text(
                        "When do you want to conquer it?",
                        style: AshTextStyles.h2,
                      ),
                      const SizedBox(height: 16),
                      // Date picker card mock
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AshColors.surfaceHighlight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AshColors.borderDark),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.calendar_month,
                              color: AshColors.textSecondary,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Pick your victory date...",
                              style: TextStyle(
                                fontSize: 16,
                                color: AshColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AshColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      GestureDetector(
                        onTap: () => setState(() => _datePreference = "asap"),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AshColors.surfaceDark,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _datePreference == "asap"
                                  ? AshColors.primary
                                  : AshColors.borderDark,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _datePreference == "asap"
                                        ? AshColors.primary
                                        : AshColors.textSecondary,
                                  ),
                                  color: _datePreference == "asap"
                                      ? AshColors.primary
                                      : null,
                                ),
                                child: _datePreference == "asap"
                                    ? const Center(
                                        child: Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Colors.white,
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "As soon as possible!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "We'll build up to it smartly",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AshColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: AshButton(
                label: "Let's Get Moving!",
                icon: Icons.arrow_forward,
                onPressed: widget.onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(
    String title,
    String subtitle,
    IconData icon,
    String value,
  ) {
    bool isSelected = _selectedGoalType == value;
    return AshCard(
      isSelected: isSelected,
      onTap: () => setState(() => _selectedGoalType = value),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AshColors.primary.withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? AshColors.primary : AshColors.textSecondary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AshColors.textSecondary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AshColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AshColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 16, color: Colors.white),
            )
          else
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: AshColors.textSecondary),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class TrainingPreferencesScreen extends StatefulWidget {
  final VoidCallback onNext;
  const TrainingPreferencesScreen({super.key, required this.onNext});

  @override
  State<TrainingPreferencesScreen> createState() =>
      _TrainingPreferencesScreenState();
}

class _TrainingPreferencesScreenState extends State<TrainingPreferencesScreen> {
  double _daysPerWeek = 4;
  final TextEditingController _injuryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  // Progress dots can be added here if needed
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Avatar & Title
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AshColors.backgroundDark,
                              width: 2,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuCEqoPKxbBAVtWfy8p6dMfnKreL73p18ZOlh4fHWxMHFkhHQvMvcmVM8_GYqMQ_WvwoXDO3KpkX4UgAnS5JwnvK0ZfyOEN5x4MFUOHEaj5ljFqjj3j_ARaVo4babEieTMVobvl07fmIJU04v5YVegLWbKO4L_oPKcL1LmGEZqyuQrLhTIamIftmOUOVtApsoXgOHDrHZChtEn9X471ivmlpEiZquL1jSg1JCwEBveVBTeHX06aSO5uSWk2l60UERUz0W6v4QZkff_I",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Let's plan your week!",
                              style: AshTextStyles.h3,
                            ),
                            Text(
                              "I'm ready when you are.",
                              style: AshTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Days Per Week Card
                    AshGlassCard(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Sweat Sessions",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "How many days can you train?",
                                    style: AshTextStyles.bodyMedium.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AshColors.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AshColors.primary.withOpacity(0.4),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AshColors.primary.withOpacity(0.3),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    _daysPerWeek.round().toString(),
                                    style: const TextStyle(
                                      color: AshColors.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors
                                  .transparent, // Custom gradient track simulation
                              inactiveTrackColor: AshColors.borderDark,
                              thumbColor: AshColors.white,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 12,
                                elevation: 5,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 24,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                // Custom Gradient Track
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    gradient: LinearGradient(
                                      colors: [
                                        AshColors.primary,
                                        Colors.orangeAccent,
                                      ],
                                      stops: [0, _daysPerWeek / 7],
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width *
                                      (_daysPerWeek - 3) /
                                      4 *
                                      0.75, // Rough approximation for demo
                                ),
                                Slider(
                                  value: _daysPerWeek,
                                  min: 3,
                                  max: 7,
                                  divisions: 4,
                                  onChanged: (val) =>
                                      setState(() => _daysPerWeek = val),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "3",
                                  style: TextStyle(
                                    color: AshColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "4",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                    color: AshColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "6",
                                  style: TextStyle(
                                    color: AshColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "7",
                                  style: TextStyle(
                                    color: AshColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Injuries
                    const Text(
                      "Body Check",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Any injuries or limits? I'll keep it safe.",
                      style: AshTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    AshTextField(
                      placeholder: "e.g. My knees hurt when I jump...",
                      maxLines: 4,
                      controller: _injuryController,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildTag("No Injuries"),
                        _buildTag("Back Issues"),
                        _buildTag("Sensitive Knees"),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: AshButton(
                label: "Let's Go!",
                icon: Icons.arrow_forward,
                onPressed: widget.onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return GestureDetector(
      onTap: () {
        _injuryController.text = label; // Simple demo logic
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: AshColors.textSecondary, fontSize: 13),
        ),
      ),
    );
  }
}

class PillarPrioritizationScreen extends StatefulWidget {
  final VoidCallback onNext;
  const PillarPrioritizationScreen({super.key, required this.onNext});

  @override
  State<PillarPrioritizationScreen> createState() =>
      _PillarPrioritizationScreenState();
}

class _PillarPrioritizationScreenState
    extends State<PillarPrioritizationScreen> {
  String _selectedPillar = "running"; // running, strength, mobility

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            // Tips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AshColors.primary, Colors.orangeAccent],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AshColors.primary.withOpacity(0.4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AshColors.surfaceHighlight,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: AshTextStyles.bodyMedium.copyWith(
                            color: AshColors.textSecondary,
                            height: 1.5,
                          ),
                          children: const [
                            TextSpan(
                              text: "Ash: ",
                              style: TextStyle(
                                color: AshColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "Hey! 👋 Let's get moving. Pick your main obsession for the week, and I'll keep the rest in check so you can have fun without burning out!",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    _buildHeroPillarCard(
                      "RUNNING",
                      "Full Send",
                      "Chasing that runner's high & boosting endurance.",
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBSBEQEK5xBanNHhemlnKjCQ23wDLXj-wHsKZkpDnF71IfV3QeQg_UtEuUT0-y-S01kASRR16PJyTCA06sxhv4IpVKKN9En2SMxvtHLd5iyG9lUa0SBetvyiaR7i6RPcslNwSZCrIxEq0zdc5DPRXRIXVsn3q72TCmhYdirT3UHwb4aFfu4465d39VeQWFu57uTAObw7Be2QwCrgTY7UDXN6bSS4lZNeL_4go3uJPD-PANmOkB-1TlSjI9yv2ogZW0RpFj4B_OLScg",
                      "running",
                    ),
                    const SizedBox(height: 16),
                    _buildMiniPillarCard(
                      "STRENGTH",
                      "Keeping it steady",
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBHaIZ0qQyWRifJZAcPjiOC8F2V6hO5-L-iJ-BgyZ3TiZ2n_c-aNrIqCb6qO1NTXw5Xy_2Q8CgoVJ77920Cg2QMMg91G9lqhEsifvgeOa-ADZG4s0wLcKEBa6SSTkseoR6TcHRNOa4zb06t2cpUAsOBMz5YBC1Qrv1tBrFQDmnm1RfIYRHVkgwMUpATa_hD_8ssKceAGn2BP_0aX7Blj0NOmVAyI1-pAKyjSC-VUpmJrvNW3L6KyE_nqCWI_GALYtCK48sScTnIh84",
                      "strength",
                    ),
                    const SizedBox(height: 16),
                    _buildMiniPillarCard(
                      "MOBILITY",
                      "Flowing freely",
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuDL-WRA-WntmN-zIcBgKUqd8Y2KVlrC6e0MCjQLVBQokAv9E-GtUJ-d5DMcFbDEwXEyTVDLrBa-1-_QcO8rBiJNINeS0A3X5QRSenzDQbOig3FUpXZQhrk0bkRSEU6nPs6mJIQmklyjOARb5dOxMhDIfk52syXN2avevvXhH3gpUsYf4R2rTQ33cbAoucV0dUe0VwBvnWXMcyP0BQe73xPAI3ACZZPrgUp17kg1CoyAoxh8w7MccxmKhrp7mi1jK7btFcL4DVTU6Uc",
                      "mobility",
                    ),
                    const SizedBox(height: 100), // Space for bottom sheet
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AshColors.surfaceDark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Weekly Mix",
                  style: AshTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AshColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "SWEET SPOT",
                    style: TextStyle(
                      color: AshColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildMixStat("Directions_Run", "4", "Runs", AshColors.primary),
                const SizedBox(width: 8),
                _buildMixStat("Fitness_Center", "2", "Lifts", Colors.grey),
                const SizedBox(width: 8),
                _buildMixStat("Self_Improvement", "3", "Flows", Colors.grey),
              ],
            ),
            const SizedBox(height: 24),
            AshButton(
              label: "Let's Do This!",
              icon: Icons.rocket_launch,
              onPressed: widget.onNext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMixStat(
    String iconName,
    String count,
    String label,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AshColors.backgroundDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            // Note: Using standard Icons for simplicity instead of string mapping for this demo
            Icon(Icons.directions_run, color: color, size: 24),
            const SizedBox(height: 4),
            Text(count, style: AshTextStyles.h2.copyWith(fontSize: 24)),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AshColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroPillarCard(
    String title,
    String subtitle,
    String desc,
    String imageUrl,
    String id,
  ) {
    bool isSelected = _selectedPillar == id;
    if (!isSelected) {
      // If logic to swap hero if another is selected (omitted for simplicity of demo, assuming 'Running' is default hero)
      // styles would normally adapt.
    }

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AshColors.primary.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: AshColors.primary.withOpacity(0.15), blurRadius: 30),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AshColors.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    "MAIN GOAL 🔥",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(title, style: AshTextStyles.h1),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Weekly Vibe",
                            style: TextStyle(
                              color: AshColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.8,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation(
                            AshColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        desc,
                        style: const TextStyle(
                          color: AshColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: AshColors.primary,
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniPillarCard(
    String title,
    String subtitle,
    String imageUrl,
    String id,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPillar = id),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AshColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.saturation,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AshColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.add,
                  color: AshColors.textSecondary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanGenerationScreen extends StatefulWidget {
  final VoidCallback onNext;
  const PlanGenerationScreen({super.key, required this.onNext});

  @override
  State<PlanGenerationScreen> createState() => _PlanGenerationScreenState();
}

class _PlanGenerationScreenState extends State<PlanGenerationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    Future.delayed(const Duration(seconds: 4), widget.onNext);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar Animation
              SizedBox(
                height: 250,
                width: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Ring
                    RotationTransition(
                      turns: _controller,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AshColors.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    // Inner Ring Reverse
                    RotationTransition(
                      turns: ReverseAnimation(_controller),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AshColors.primary.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    // Glow
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AshColors.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AshColors.primary.withOpacity(0.4),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                    ),
                    // Image
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AshColors.primary, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuB-dk_SZj-84fIs5vjhWTomfq0xSoPB5TQIxnsDEVho9x0Ijzwc-gU5HXctvJLHlkJtbD3C6UxLfAe_RhMv_6oDWGS4NGnnfvbO-UaCLMfcbZdLOCAuSGYrR5l7kMHxp1jrramWIYt_rq4JEjISGYPL5x2Ede2KGRpkdtHVqX49EzqP0eTwDKECrVfSkzWh8xqLGGqISXjpmYqF6L3gjMcJ3LKTBthwgIJTLGLbke-gCPl3ezNdOZwaodWqB9SKQmP9L0QNlCH8LFU",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              Text(
                "Whipping up your perfect plan!",
                style: AshTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Hang tight, Ash is finding the best moves just for you.",
                style: AshTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Progress Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "MIXING THE MAGIC",
                    style: TextStyle(
                      color: AshColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "65%",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  minHeight: 8,
                  backgroundColor: AshColors.surfaceHighlight,
                  valueColor: const AlwaysStoppedAnimation(AshColors.primary),
                  value: 0.65,
                ),
              ),

              const SizedBox(height: 48),

              // Fun Fact Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AshColors.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AshColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb,
                        color: AshColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "ASH'S FUN FACT",
                                style: TextStyle(
                                  color: AshColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Tip #42",
                                style: TextStyle(
                                  color: AshColors.textSecondary,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "\"Moving around (dynamic stretching) is way better than holding still like a statue before a workout!\"",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanReviewScreen extends StatelessWidget {
  final VoidCallback onNext;
  const PlanReviewScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  const Text(
                    "Plan Review",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Avatar Header
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AshColors.primary,
                              width: 2,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuAWXbAdGe_bvU9FwXHq2bU8U6xB_KQc3fLFKG8BLud5clXPrvE9OP_be_AMiCxQIq-BMnvWjHR6EJK2GKvywhi5a0tG1069KfEX4wqJQPdVyegoGrpLe1n9Cje4dGEWd2Ttou8weNjPwVnU0GUW1IlDmUGQE6rnbLI9YB3_BXBiIQDiycYkzBAoNYlaM7cQ-voGwASTtOm54WnJPoGFxL2kaEb2o_vuDrMXFcRKdi35ySjuO8rtls07VWymVPRsG7GWAgrTzTwoARM",
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AshColors.primary.withOpacity(0.3),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Ash",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AshColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      "YOUR COACH",
                                      style: TextStyle(
                                        color: AshColors.primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "High five! 🙌 I've built a custom plan to get you moving. Check out Week 1!",
                                style: TextStyle(
                                  color: AshColors.textSecondary,
                                  fontSize: 13,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Stats Row
                    Row(
                      children: [
                        _buildStatCard(
                          "Total Miles",
                          "15 mi",
                          Icons.directions_run,
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard("Workouts", "4", Icons.fitness_center),
                        const SizedBox(width: 12),
                        _buildStatCard("Active Time", "3h 20m", Icons.timer),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Week Schedule Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Week 1 Schedule", style: AshTextStyles.h3),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AshColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Nov 12 - 19",
                            style: TextStyle(
                              color: AshColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Schedule Items
                    _buildScheduleItem(
                      "MON",
                      "12",
                      "Easy Peasy Run 🏃",
                      "Run • Easy",
                      "30 min",
                      AshColors.primary,
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuA9rIZMQZZjZb2Fiq0GkKa6N0AkpLYfR_VdKlQbcrELHtgs0hpNvncEqRDMGn1KIp6YUInjjMppCdzauQC_t3Vqbx3pfpgHZ_uWEY6YeBnmRRefuhn8FO7eDwmwVkyh9bN93WBNhzLkih_b3q0i7jrvgDUD3TikDBGw2Og1WYqOpZlZo0VLxEmfvjXk7ltzYymEZAMeABQHStC_3hTVXuvoyCChiMZt20uMLOBcLlfTmbZKgselsd80qIEN2lVL3TmrNwq_Cdnveew",
                    ),
                    const SizedBox(height: 12),
                    _buildScheduleItem(
                      "TUE",
                      "13",
                      "Iron Pump Sesh 🏋️",
                      "Strength • Full Body",
                      "45 min",
                      Colors.purple,
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuC5qiA4KNmzHglB0YQeb-TyAqExhQ1eRqqhVc0cDiu3KdyifsYeSN2DYrQYEK0khhUJma8-GrooJcdLJqd22H_sS8pMMWrAQJDwFOENpQwYKLbSFDTv4ncnkqDbAbj7XufsPW_qO1cU0FuuuR3dTy9RlPcAZeelPt11yDeRmw8YntjFzoydJ5HBHCDqqtxo27y3A7AfUedLzrC3ZTpV6pxUYjOOWC7Ys8pi0gCLYCclwT8GK-oGZfiU_eQoPcbw4FFnTDZzQC1E_48",
                    ),
                    const SizedBox(height: 12),
                    // Rest Day
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              Text(
                                "WED",
                                style: TextStyle(
                                  color: AshColors.textSecondary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "14",
                                style: TextStyle(
                                  color: AshColors.textSecondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.white.withOpacity(0.1),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Rest & Chill 😴",
                                  style: TextStyle(
                                    color: AshColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Recharge your battery",
                                  style: TextStyle(
                                    color: AshColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.bedtime,
                            color: AshColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildScheduleItem(
                      "THU",
                      "15",
                      "Speed Demon Intervals ⚡",
                      "Speed • High Intensity",
                      "35 min",
                      Colors.orange,
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuA3FtMst8J4F3mjX3Isjo7xkXR7WTfqxb-fDyuMTCqIt3dqzJ-NrVfis5xWUerh7_9goFr0b39rlYQ2CeVeTSUejhyCNBJHFuwxNWsITn54ZaB7yW67g-Q39kZWFT6-bXWSCrVyjDQgPvKgJryzvxMLlHFc2ZVVkMzk1iRM_Pbj6tgBCJp4E_aDXwxVVuBIIz_XmIgp43k2LNcj9CKJ9ch3_eSj_ZUy91vt2Fs17Z7H2OHv26if0n26cKtYWM4Y_jG8PQ_eios-OC8",
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AshColors.surfaceDark.withOpacity(0.9),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.05)),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  AshButton(
                    label: "This rocks! Let's Go 🚀",
                    onPressed: onNext,
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune,
                      color: AshColors.textSecondary,
                      size: 20,
                    ),
                    label: const Text(
                      "Let's tweak it first",
                      style: TextStyle(
                        color: AshColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(
    String day,
    String date,
    String title,
    String subtitle,
    String time,
    Color color,
    String imageUrl,
  ) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AshColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 6, color: color),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day,
                          style: const TextStyle(
                            color: AshColors.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.white.withOpacity(0.1),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  subtitle.split(" • ")[0],
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "• ${subtitle.split(" • ")[1]}",
                                style: const TextStyle(
                                  color: AshColors.textSecondary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.timer,
                                size: 14,
                                color: AshColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                time,
                                style: const TextStyle(
                                  color: AshColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AshColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AshColors.primary, size: 20),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AshColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstWorkoutReadyScreen extends StatelessWidget {
  final VoidCallback onFinish;
  const FirstWorkoutReadyScreen({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  const Text(
                    "YOU'RE IN!",
                    style: TextStyle(
                      color: AshColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Success Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AshColors.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.celebration,
                        color: AshColors.primary,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Woohoo! You're set.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Your fitness journey officially kicks off.",
                      style: TextStyle(
                        color: AshColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Countdown
                    Text(
                      "Tomorrow",
                      style: AshTextStyles.h1.copyWith(fontSize: 48),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.schedule, color: AshColors.primary),
                        SizedBox(width: 8),
                        Text(
                          "7:00 AM",
                          style: TextStyle(
                            color: AshColors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // Glass Card with Workout Preview
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AshColors.primary.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        AshGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AshColors.primary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "STRENGTH",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.more_horiz,
                                    color: AshColors.textSecondary,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          "https://lh3.googleusercontent.com/aida-public/AB6AXuBfCDCV6OEsAaKDvyiO_ZwRvk0_Rmpmo3TRnLvA4YYW-QKxZ8p-S8h6ZIe_q6tsnrWfZMQsE8hm3qkqKTprgp9sXQHuTOgKpy84ViOeUW-MkcY7073MylCoFJpj7Hc8Jf8DT6FJg1veqpeLq2y5eYTDfZCMfptzMHm89FAzGCC2S_qlV8uSjBoGHyjGVF3p3lrnZYLaU-tQk1v3HT16mggP_X376BIbzYuL-mlBXyRmQ7QX02QJd4NA_SK64WePW24vqbbTQwXSkgI",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Upper Body Power",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Text(
                                          "Let's build that strength!",
                                          style: TextStyle(
                                            color: AshColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.timer,
                                                    size: 12,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "45 Min",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.local_fire_department,
                                                    size: 12,
                                                    color: Colors.orange,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "RPE 7",
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Ash Chat Bubble
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuAVJlwIp6StrPZUsvjFzEx-YiwdEAC8ItXCSeMdtUw5VFUYx-k5g4inw1KESFNhoK7kO2Y4uS018sNUX2aA5DHiEASybUmGl1t_0s8QryT-NeELDE_KJO75jlBEiWnud3h52HTZxCCC32z-TPtFy6neA9bGyF8NULWmqQyEC8aYmGViR2BThvEpcfCPR1dr9Evy_ZZFxViz43XJmijvy6r_DnQbDlP6mv7Q48HL4W6GDqsaH47lqU4pTzP_O7dDQ1TxYWnO0pjP4rk",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 4.0, bottom: 4),
                                child: Text(
                                  "Ash",
                                  style: TextStyle(
                                    color: AshColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  "I'm so pumped for this! 🤩 Sleep tight, I'll nudge you when it's time to shine 🌅",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  AshButton(
                    label: "Turn on notifications",
                    icon: Icons.notifications_active,
                    onPressed: onFinish,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Edit workout details",
                    style: TextStyle(
                      color: AshColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
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
