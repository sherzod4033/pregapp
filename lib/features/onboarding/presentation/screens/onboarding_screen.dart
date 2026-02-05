import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../../main.dart';

/// Screen 1: Onboarding / Welcome Screen
/// Features date input for last period calculation
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  DateTime? _selectedDate;
  bool _showCalendar = false;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  // Welcome header
                  Text(
                    'Хуш омадед,',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'модари оянда! 💕',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.coral,
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'Барои оғоз кардан, лутфан рӯзи аввали ҳайзи охиринро интихоб кунед.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 40),

                  // Date input card
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Рӯзи аввали ҳайзи охирин',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),

                        // Date selector button
                        GestureDetector(
                          onTap: () => setState(() => _showCalendar = !_showCalendar),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warmWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _showCalendar
                                    ? AppColors.coral
                                    : AppColors.glassBorder,
                                width: _showCalendar ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  color: AppColors.coral,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _selectedDate != null
                                      ? '${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}'
                                      : 'Санаро интихоб кунед',
                                  style: TextStyle(
                                    color: _selectedDate != null
                                        ? AppColors.textDark
                                        : AppColors.textLight,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  _showCalendar
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: AppColors.textLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Calendar widget
                  if (_showCalendar) ...[
                    const SizedBox(height: 16),
                    GlassCard(
                      padding: const EdgeInsets.all(8),
                      child: CalendarDatePicker(
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 280),
                        ),
                        lastDate: DateTime.now(),
                        onDateChanged: (date) {
                          setState(() {
                            _selectedDate = date;
                            _showCalendar = false;
                          });
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),

                  // Calculate button
                  GradientButton(
                    text: 'Ҳисоб кардан',
                    onPressed: _selectedDate != null
                        ? () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const MainAppShell(),
                              ),
                            );
                          }
                        : () {},
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
