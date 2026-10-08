import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;
  bool answered = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Apa kepanjangan dari TIK?',
      'answers': [
        'Teknologi Informasi dan Komunikasi',
        'Teknologi Internet Komputer',
        'Teknik Informasi Komputer',
        'Teknologi Industri Komunikasi',
      ],
      'correct': 0,
    },
    {
      'question': 'Manakah yang termasuk perangkat keras?',
      'answers': [
        'Microsoft Word',
        'Keyboard',
        'Google Chrome',
        'Windows',
      ],
      'correct': 1,
    },
    {
      'question': 'Perangkat yang digunakan untuk menampilkan gambar dari komputer adalah...',
      'answers': [
        'Keyboard',
        'Mouse',
        'Monitor',
        'Scanner',
      ],
      'correct': 2,
    },
    {
      'question': 'Contoh perangkat lunak adalah...',
      'answers': [
        'Monitor',
        'Printer',
        'Keyboard',
        'Microsoft Word',
      ],
      'correct': 3,
    },
    {
      'question': 'Internet dapat digunakan untuk...',
      'answers': [
        'Mencari informasi',
        'Mengirim pesan',
        'Belajar secara online',
        'Semua benar',
      ],
      'correct': 3,
    },
  ];

  void selectAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == questions[currentQuestion]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        answered = false;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    final int xp = score * 20;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Kuis Selesai 🎉',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  size: 45,
                  color: Color(0xFF2563EB),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                '$score / ${questions.length}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Jawaban benar',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                '+$xp XP',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Selesai'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final answers = question['answers'] as List<String>;
    final correctAnswer = question['correct'] as int;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Kuis TIK',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProgress(),

              const SizedBox(height: 28),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pertanyaan ${currentQuestion + 1}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2563EB),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        question['question'] as String,
                        style: const TextStyle(
                          fontSize: 23,
                          height: 1.35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),

                      const SizedBox(height: 28),

                      ...List.generate(
                        answers.length,
                        (index) => _buildAnswer(
                          index: index,
                          answer: answers[index],
                          correctAnswer: correctAnswer,
                        ),
                      ),

                      if (answered) ...[
                        const SizedBox(height: 10),
                        _buildExplanation(
                          correct: selectedAnswer == correctAnswer,
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              if (answered)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    child: Text(
                      currentQuestion == questions.length - 1
                          ? 'Lihat Hasil'
                          : 'Pertanyaan Berikutnya',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() {
    final progress = (currentQuestion + 1) / questions.length;

    return Column(
      children: [
        Row(
          children: [
            Text(
              '${currentQuestion + 1}/${questions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            Text(
              'Score: $score',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2563EB),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF2563EB),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswer({
    required int index,
    required String answer,
    required int correctAnswer,
  }) {
    final bool isSelected = selectedAnswer == index;
    final bool isCorrect = index == correctAnswer;

    Color borderColor = const Color(0xFFE5E7EB);
    Color backgroundColor = Colors.white;
    Color iconColor = const Color(0xFF6B7280);

    if (answered && isCorrect) {
      borderColor = const Color(0xFF16A34A);
      backgroundColor = const Color(0xFFF0FDF4);
      iconColor = const Color(0xFF16A34A);
    } else if (answered && isSelected && !isCorrect) {
      borderColor = const Color(0xFFDC2626);
      backgroundColor = const Color(0xFFFEF2F2);
      iconColor = const Color(0xFFDC2626);
    } else if (isSelected) {
      borderColor = const Color(0xFF2563EB);
      backgroundColor = const Color(0xFFEFF6FF);
      iconColor = const Color(0xFF2563EB);
    }

    return GestureDetector(
      onTap: () => selectAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
              ),
            ),

            if (answered && isCorrect)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF16A34A),
              )
            else if (answered && isSelected)
              const Icon(
                Icons.cancel_rounded,
                color: Color(0xFFDC2626),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExplanation({
    required bool correct,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: correct
            ? const Color(0xFFF0FDF4)
            : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: correct
              ? const Color(0xFFBBF7D0)
              : const Color(0xFFFECACA),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            correct
                ? Icons.check_circle_rounded
                : Icons.info_rounded,
            color: correct
                ? const Color(0xFF16A34A)
                : const Color(0xFFDC2626),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              correct
                  ? 'Jawaban kamu benar! Kamu mendapatkan 20 XP.'
                  : 'Jawaban kamu belum tepat. Tetap semangat belajar!',
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: correct
                    ? const Color(0xFF166534)
                    : const Color(0xFF991B1B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}