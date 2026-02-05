import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/gradient_background.dart';

class KickCounterScreen extends StatefulWidget {
  const KickCounterScreen({super.key});

  @override
  State<KickCounterScreen> createState() => _KickCounterScreenState();
}

class _KickCounterScreenState extends State<KickCounterScreen> {
  // Session State
  bool _isSessionActive = false;
  int _kickCount = 0;
  DateTime? _startTime;
  Duration _elapsed = Duration.zero;
  Timer? _timer;
  DateTime? _lastKickTime;

  // Settings
  final int _targetKicks = 10;
  final Duration _maxDuration = const Duration(hours: 2);
  bool _isFreeMode = false;

  // History
  final List<KickSession> _history = [];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSession() {
    setState(() {
      _isSessionActive = true;
      _kickCount = 0;
      _startTime = DateTime.now();
      _elapsed = Duration.zero;
      _lastKickTime = null;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = Duration(seconds: timer.tick);
      });

      // Auto-finish checks for "Count to 10" mode
      if (!_isFreeMode) {
        if (_kickCount >= _targetKicks) {
          _finishSession();
        } else if (_elapsed >= _maxDuration) {
          _finishSession(timedOut: true);
        }
      }
    });
  }

  void _addKick() {
    if (!_isSessionActive) return;

    final now = DateTime.now();
    // Debounce: Ignore kicks within 5 seconds
    if (_lastKickTime != null && now.difference(_lastKickTime!) < const Duration(seconds: 5)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ҳаракатҳои пайдарпай ҳамчун як ҳисоб карда мешаванд'),
          duration: Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _kickCount++;
      _lastKickTime = now;
    });

    if (!_isFreeMode && _kickCount >= _targetKicks) {
      _finishSession();
    }
  }

  void _finishSession({bool timedOut = false}) {
    _timer?.cancel();
    _isSessionActive = false;

    final session = KickSession(
      startTime: _startTime!,
      duration: _elapsed,
      totalKicks: _kickCount,
      isFreeMode: _isFreeMode,
      completed: _kickCount >= _targetKicks,
    );

    setState(() {
      _history.insert(0, session);
    });

    _showSummaryDialog(session, timedOut);
  }

  void _showSummaryDialog(KickSession session, bool timedOut) {
    String title;
    String message;
    Color color;

    if (timedOut) {
      title = 'Диққат!';
      message = 'Дар муддати 2 соат камтар аз 10 ҳаракат мушоҳида шуд. Лутфан, чизе ширин нӯшед, ба паҳлӯи чап хобед ва дубора санҷед. Агар ҳаракатҳо кам боқӣ монанд, ба духтур муроҷиат кунед.';
      color = AppColors.danger;
    } else if (session.completed) {
      title = 'Аъло!';
      message = 'Шумо 10 ҳаракатро дар муддати ${_formatDuration(session.duration)} сабт кардед. Ин натиҷаи хуб аст!';
      color = AppColors.success;
    } else {
      title = 'Сессия ба анҷом расид';
      message = 'Шумо ${session.totalKicks} ҳаракатро сабт кардед.';
      color = AppColors.salmonPink;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: color)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Фаҳмо'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Ҳисобкунаки ҳаракат'),
          centerTitle: true,
          leading: const BackButton(color: AppColors.textDark),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              
              // Mode Toggle
              GlassCard(
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: _ModeButton(
                        text: 'То 10',
                        isSelected: !_isFreeMode,
                        onTap: () {
                          if (!_isSessionActive) setState(() => _isFreeMode = false);
                        },
                      ),
                    ),
                    Expanded(
                      child: _ModeButton(
                        text: 'Озод',
                        isSelected: _isFreeMode,
                        onTap: () {
                          if (!_isSessionActive) setState(() => _isFreeMode = true);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Timer Display
              Text(
                _isSessionActive ? _formatDuration(_elapsed) : '00:00',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const Text(
                'Вақт',
                style: TextStyle(color: AppColors.textLight, fontSize: 16),
              ),

              const SizedBox(height: 40),

              // Kick Button
              GestureDetector(
                onTap: _isSessionActive ? _addKick : _startSession,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: _isSessionActive
                          ? [AppColors.salmonPink, Colors.blue.shade300]
                          : [AppColors.coral, Colors.orange.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (_isSessionActive ? AppColors.salmonPink : AppColors.coral)
                            .withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isSessionActive ? Icons.touch_app_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _isSessionActive ? 'ГУЗОШТАН' : 'ОҒОЗ', // "TAP" vs "START" logic
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_isSessionActive)
                          Text(
                            '$_kickCount / ${_isFreeMode ? "∞" : _targetKicks}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              
              if (_isSessionActive)
                TextButton(
                  onPressed: () => _finishSession(timedOut: false),
                  child: const Text(
                    'Анҷом додан',
                    style: TextStyle(color: AppColors.textLight, fontSize: 16),
                  ),
                ),

              const Spacer(),

              // History
               if (_history.isNotEmpty) ...[
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Text(
                     'Таърих',
                     style: Theme.of(context).textTheme.titleMedium,
                   ),
                 ),
                 const SizedBox(height: 10),
                 SizedBox(
                   height: 150,
                   child: ListView.builder(
                     itemCount: _history.length,
                     itemBuilder: (context, index) {
                       final session = _history[index];
                       return Padding(
                         padding: const EdgeInsets.only(bottom: 8),
                         child: GlassCard(
                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 '${session.totalKicks} ҳаракат',
                                 style: const TextStyle(fontWeight: FontWeight.bold),
                               ),
                               Text(
                                 _formatDuration(session.duration),
                                 style: const TextStyle(color: AppColors.textLight),
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 ),
               ],
               const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.textDark : AppColors.textLight,
            ),
          ),
        ),
      ),
    );
  }
}

class KickSession {
  final DateTime startTime;
  final Duration duration;
  final int totalKicks;
  final bool isFreeMode;
  final bool completed;

  KickSession({
    required this.startTime,
    required this.duration,
    required this.totalKicks,
    required this.isFreeMode,
    required this.completed,
  });
}
