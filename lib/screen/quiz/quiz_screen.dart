import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
class QuizScreen extends StatefulWidget {
  final String materialTitle;
  final String materialContent;
  const QuizScreen({
    super.key,
    required this.materialTitle,
    required this.materialContent,
  });
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}
class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;
  late final List<Map<String, dynamic>> questions;
  @override
  void initState() {
    super.initState();
    questions = [
      {
        'question': 'What is the main topic of this material?',
        'answers': [
          widget.materialTitle,
          'Cooking',
          'Sports',
          'Travel',
        ],
        'correct': 0,
      },
      {
        'question': 'What is the purpose of studying this material?',
        'answers': [
          'To understand the subject',
          'To play games',
          'To watch movies',
          'To edit photos',
        ],
        'correct': 0,
      },
      {
        'question': 'Where does the quiz information come from?',
        'answers': [
          'The selected material',
          'A random movie',
          'A music file',
          'A weather report',
        ],
        'correct': 0,
      },
    ];
  }
  void selectAnswer(int index) {
    setState(() {
      selectedAnswer = index;
    });
  }
  void nextQuestion() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer first.'),
        ),
      );
      return;
    }
    if (selectedAnswer ==
        questions[currentQuestion]['correct']) {
      score++;
    }
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      showResult();
    }
  }
  void showResult() {
    final percentage =
        ((score / questions.length) * 100).round();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Quiz Complete',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: AppColors.success,
                size: 55,
              ),
              const SizedBox(height: 15),
              Text(
                '$score / ${questions.length}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Done',
                style: TextStyle(
                  color: AppColors.cyanGlow,
                ),
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
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mainBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
        title: const Text(
          'Quiz',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.materialTitle,
              style: const TextStyle(
                color: AppColors.cyanGlow,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value:
                          (currentQuestion + 1) /
                              questions.length,
                      minHeight: 8,
                      backgroundColor:
                          const Color(0xFF315268),
                      valueColor:
                          const AlwaysStoppedAnimation(
                        AppColors.success,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${currentQuestion + 1}/${questions.length}',
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Text(
              question['question'],
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount:
                    (question['answers'] as List).length,
                itemBuilder: (context, index) {
                  final answer =
                      question['answers'][index];
                  final isSelected =
                      selectedAnswer == index;
                  return GestureDetector(
                    onTap: () => selectAnswer(index),
                    child: Container(
                      margin:
                          const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryBlue
                                .withOpacity(0.25)
                            : AppColors.secondaryBackground,
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.cyanGlow
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? AppColors.cyanGlow
                                  : AppColors.mainBackground,
                            ),
                            child: Text(
                              String.fromCharCode(
                                65 + index,
                              ),
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.mainBackground
                                    : AppColors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              answer,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  currentQuestion ==
                          questions.length - 1
                      ? 'Finish Quiz'
                      : 'Next Question',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}