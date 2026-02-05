import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/gradient_background.dart';

/// Screen 3: Contraction Timer
/// Large pulsing button to track contractions with history log
class ContractionScreen extends StatefulWidget {
  const ContractionScreen({super.key});

  @override
  State<ContractionScreen> createState() => _ContractionScreenState();
}

class _ContractionScreenState extends State<ContractionScreen>
    with SingleTickerProviderStateMixin {
  bool _isRunning = false;
  int _seconds = 0;
  Timer? _timer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<_ContractionLog> _logs = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      // Stop timer
      _timer?.cancel();
      _pulseController.stop();

      // Log contraction
      setState(() {
        _logs.insert(
          0,
          _ContractionLog(
            time: TimeOfDay.now(),
            durationSeconds: _seconds,
          ),
        );
        _isRunning = false;
        _seconds = 0;
      });
    } else {
      // Start timer
      setState(() => _isRunning = true);
      _pulseController.repeat(reverse: true);

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _seconds++);
      });
    }
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              
              // Custom Header with Back Button and Centered Title
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_rounded, color: AppColors.textDark),
                      ),
                    ),
                  ),
                  Text(
                    'Ҳисобкунаки дард',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const Spacer(),

              // Timer display
              Text(
                _formatTime(_seconds),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: _isRunning ? AppColors.coral : AppColors.textDark,
                ),
              ),

            const SizedBox(height: 32),

            // Large pulsing button
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isRunning ? _pulseAnimation.value : 1.0,
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: _toggleTimer,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _isRunning
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.coral,
                              AppColors.danger,
                            ],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.success,
                              AppColors.success.withGreen(200),
                            ],
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: (_isRunning ? AppColors.coral : AppColors.success)
                            .withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 64,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isRunning ? 'МАНЪ КУНЕД' : 'ОҒОЗ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // History logs
            if (_logs.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Таърихи дардҳо',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 12),
              GlassCard(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: _logs.take(5).map((log) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.coral.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.timer_outlined,
                              color: AppColors.coral,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Дарди охирин: ${log.time.format(context)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          Text(
                            'Давомнокӣ: ${log.durationSeconds}с',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    ));
  }
}

class _ContractionLog {
  final TimeOfDay time;
  final int durationSeconds;

  _ContractionLog({required this.time, required this.durationSeconds});
}
