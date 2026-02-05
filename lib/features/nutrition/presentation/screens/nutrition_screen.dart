import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';

/// Screen 4: Nutrition & Health Hub
/// Grid of nutrition cards with toggle tabs
class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Header
          Text(
            'Саломатӣ ва Ғизо',
            style: Theme.of(context).textTheme.headlineLarge,
          ),

          const SizedBox(height: 20),

          // Toggle tabs
          _buildTabs(),

          const SizedBox(height: 24),

          // Content grid
          Expanded(
            child: _selectedTab == 0
                ? _buildNutritionGrid()
                : _buildExercisesGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return GlassCard(
      padding: const EdgeInsets.all(6),
      borderRadius: 20,
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              text: 'Ғизо',
              isSelected: _selectedTab == 0,
              onTap: () => setState(() => _selectedTab = 0),
            ),
          ),
          Expanded(
            child: _TabButton(
              text: 'Машқҳо',
              isSelected: _selectedTab == 1,
              onTap: () => setState(() => _selectedTab = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionGrid() {
    final items = [
      _NutritionItem(
        emoji: '🍎🍇',
        title: 'Меваҳои фоиданок',
        subtitle: 'Витаминҳо ва маъданҳо',
        color: AppColors.success,
      ),
      _NutritionItem(
        emoji: '💧',
        title: 'Реҷаи обнӯшӣ',
        subtitle: 'Нӯшидани об',
        color: Colors.lightBlue,
      ),
      _NutritionItem(
        emoji: '🚫🍔',
        title: 'Маҳсулоти зараровар',
        subtitle: 'Аз чӣ парҳез кунед',
        color: AppColors.danger,
      ),
      _NutritionItem(
        emoji: '🥗',
        title: 'Ғизоҳои солим',
        subtitle: 'Рецептҳои осон',
        color: AppColors.success,
      ),
      _NutritionItem(
        emoji: '🥛',
        title: 'Кальсий',
        subtitle: 'Устухонҳои қавӣ',
        color: AppColors.peach,
      ),
      _NutritionItem(
        emoji: '🥬',
        title: 'Фолат аситӣ',
        subtitle: 'Барои инкишоф',
        color: Colors.green,
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.only(bottom: 120),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: items.map((item) => _buildNutritionCard(item)).toList(),
    );
  }

  Widget _buildExercisesGrid() {
    final items = [
      _NutritionItem(
        emoji: '🧘‍♀️',
        title: 'Йога',
        subtitle: 'Машқҳои осон',
        color: AppColors.dustyPink,
      ),
      _NutritionItem(
        emoji: '🚶‍♀️',
        title: 'Пиёдаравӣ',
        subtitle: 'Ҳар рӯз 30 дақиқа',
        color: AppColors.success,
      ),
      _NutritionItem(
        emoji: '💆‍♀️',
        title: 'Релаксатсия',
        subtitle: 'Истироҳат',
        color: Colors.purple.shade300,
      ),
      _NutritionItem(
        emoji: '🏊‍♀️',
        title: 'Шинокунӣ',
        subtitle: 'Бехатар ва муфид',
        color: Colors.lightBlue,
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.only(bottom: 120),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: items.map((item) => _buildNutritionCard(item)).toList(),
    );
  }

  Widget _buildNutritionCard(_NutritionItem item) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item.emoji,
              style: const TextStyle(fontSize: 26),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textLight,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.coral : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textMedium,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _NutritionItem {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;

  _NutritionItem({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
