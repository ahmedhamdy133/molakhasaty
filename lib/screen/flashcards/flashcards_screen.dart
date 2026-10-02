import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
class FlashcardsScreen extends StatefulWidget {
  final String materialTitle;
  final String materialContent;
  const FlashcardsScreen({
    super.key,
    required this.materialTitle,
    required this.materialContent,
  });
  @override
  State<FlashcardsScreen> createState() =>
      _FlashcardsScreenState();
}
class _FlashcardsScreenState
    extends State<FlashcardsScreen> {
  int currentIndex = 0;
  bool showAnswer = false;
  late final List<Map<String, String>> cards;
  @override
  void initState() {
    super.initState();
    cards = [
      {
        'question': 'What is this material about?',
        'answer': widget.materialTitle,
      },
      {
        'question': 'What is the main idea?',
        'answer': getShortContent(),
      },
      {
        'question': 'What should you remember?',
        'answer':
            'Review the important concepts and key points from this material.',
      },
      {
        'question': 'How can you study this material?',
        'answer':
            'Read the notes, review the summary, and test yourself with quizzes.',
      },
    ];
  }
  String getShortContent() {
    if (widget.materialContent.trim().isEmpty) {
      return 'No content is available yet.';
    }
    final words =
        widget.materialContent.trim().split(RegExp(r'\s+'));
    if (words.length <= 30) {
      return widget.materialContent.trim();
    }
    return '${words.take(30).join(' ')}...';
  }
  void flipCard() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }
  void nextCard() {
    if (currentIndex < cards.length - 1) {
      setState(() {
        currentIndex++;
        showAnswer = false;
      });
    }
  }
  void previousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        showAnswer = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final card = cards[currentIndex];
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
          'Flashcards',
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
          children: [
            Text(
              widget.materialTitle,
              style: const TextStyle(
                color: AppColors.cyanGlow,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GestureDetector(
                onTap: flipCard,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: AppColors.primaryBlue
                          .withOpacity(0.35),
                    ),
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration:
                          const Duration(milliseconds: 250),
                      child: Column(
                        key: ValueKey(showAnswer),
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            showAnswer
                                ? Icons.lightbulb_rounded
                                : Icons.help_outline_rounded,
                            color: showAnswer
                                ? AppColors.success
                                : AppColors.cyanGlow,
                            size: 55,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            showAnswer
                                ? 'Answer'
                                : 'Question',
                            style: const TextStyle(
                              color:
                                  AppColors.secondaryText,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            showAnswer
                                ? card['answer']!
                                : card['question']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Tap to flip',
                            style: TextStyle(
                              color:
                                  AppColors.secondaryText,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${currentIndex + 1} / ${cards.length}',
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: previousCard,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primaryBlue,
                      ),
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton(
                    onPressed: nextCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primaryBlue,
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}