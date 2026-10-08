import 'dart:math';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Edukasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Belajar sambil bermain 🎮',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih game untuk mengasah kemampuan TIK kamu.',
              style: TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),

            _GameCard(
              icon: Icons.grid_view_rounded,
              title: 'Memory Match',
              description: 'Cocokkan kartu yang memiliki pasangan.',
              xp: '+30 XP',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MemoryMatchPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            _GameCard(
              icon: Icons.quiz_rounded,
              title: 'Tebak TIK',
              description: 'Uji pengetahuanmu tentang dunia TIK.',
              xp: '+20 XP',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Game Tebak TIK segera hadir!'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String xp;
  final VoidCallback onTap;

  const _GameCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.xp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 32,
                color: const Color(0xFF2563EB),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    xp,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================
// MEMORY MATCH
// =============================

class MemoryMatchPage extends StatefulWidget {
  const MemoryMatchPage({super.key});

  @override
  State<MemoryMatchPage> createState() => _MemoryMatchPageState();
}

class _MemoryMatchPageState extends State<MemoryMatchPage> {
  final List<String> _symbols = [
    '🖥️',
    '🖥️',
    '⌨️',
    '⌨️',
    '🖱️',
    '🖱️',
    '🌐',
    '🌐',
  ];

  late List<String> _cards;
  late List<bool> _revealed;
  late List<bool> _matched;

  int _firstIndex = -1;
  int _moves = 0;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _cards = List<String>.from(_symbols);
    _cards.shuffle(Random());

    _revealed = List<bool>.filled(_cards.length, false);
    _matched = List<bool>.filled(_cards.length, false);

    _firstIndex = -1;
    _moves = 0;
    _checking = false;
  }

  void _tapCard(int index) {
    if (_checking ||
        _revealed[index] ||
        _matched[index]) {
      return;
    }

    setState(() {
      _revealed[index] = true;
    });

    if (_firstIndex == -1) {
      _firstIndex = index;
      return;
    }

    final secondIndex = index;
    _moves++;

    if (_cards[_firstIndex] == _cards[secondIndex]) {
      setState(() {
        _matched[_firstIndex] = true;
        _matched[secondIndex] = true;
      });

      _firstIndex = -1;

      if (_matched.every((value) => value)) {
        Future.delayed(
          const Duration(milliseconds: 500),
          _showResult,
        );
      }
    } else {
      _checking = true;

      Future.delayed(
        const Duration(milliseconds: 700),
        () {
          if (!mounted) return;

          setState(() {
            _revealed[_firstIndex] = false;
            _revealed[secondIndex] = false;
          });

          _firstIndex = -1;
          _checking = false;
        },
      );
    }
  }

  void _showResult() {
    if (!mounted) return;

    final xp = max(10, 50 - (_moves * 3));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            '🎉 Berhasil!',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Semua pasangan berhasil ditemukan!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Percobaan: $_moves',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '+$xp XP',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  _resetGame();
                });
              },
              child: const Text('Main Lagi'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Selesai'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Memory Match',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: () {
              setState(() {
                _resetGame();
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temukan Semua Pasangan 🧠',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Buka dua kartu dan cari pasangan yang sama.',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                const Icon(
                  Icons.touch_app_rounded,
                  color: Color(0xFF2563EB),
                ),
                const SizedBox(width: 8),
                Text(
                  'Percobaan: $_moves',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Expanded(
              child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.1,
                ),
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  final visible =
                      _revealed[index] || _matched[index];

                  return GestureDetector(
                    onTap: () => _tapCard(index),
                    child: AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: visible
                            ? Colors.white
                            : const Color(0xFF2563EB),
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          visible ? _cards[index] : '?',
                          style: TextStyle(
                            fontSize: visible ? 42 : 36,
                            fontWeight: FontWeight.bold,
                            color: visible
                                ? const Color(0xFF111827)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}