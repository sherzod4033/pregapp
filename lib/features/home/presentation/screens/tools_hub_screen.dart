import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../contraction_timer/presentation/screens/contraction_screen.dart';
import '../../../kick_counter/presentation/screens/kick_counter_screen.dart';

class ToolsHubScreen extends StatelessWidget {
  const ToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Асбобҳо',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 30),
            _buildToolCard(
              context,
              title: 'Ҳисобкунаки дард',
              subtitle: 'Вақти дардҳоро чен кунед',
              icon: Icons.timer_outlined,
              color: AppColors.coral,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContractionScreen()),
              ),
            ),
            const SizedBox(height: 20),
            _buildToolCard(
              context,
              title: 'Ҳисобкунаки ҳаракат',
              subtitle: 'Мониторинги ҳаракати тифл',
              icon: Icons.child_care_rounded,
              color: AppColors.salmonPink,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const KickCounterScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textLight,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}
