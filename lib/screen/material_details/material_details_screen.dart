import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../ai_summary/ai_summery_screen.dart';
import '../flashcards/flashcards_screen.dart';
import '../quiz/quiz_screen.dart';
class MaterialDetailsScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String content;
  final IconData icon;
  const MaterialDetailsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.content,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
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
          'Material Details',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color:
                              AppColors.primaryBlue.withOpacity(0.15),
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: Icon(
                          icon,
                          color: AppColors.cyanGlow,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
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
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Study Tools',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _ToolCard(
              icon: Icons.auto_awesome_rounded,
              title: 'AI Summary',
              subtitle: 'Get a quick summary of your material',
              iconColor: AppColors.cyanGlow,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AiSummaryScreen(
                      materialTitle: title,
                      materialContent: content,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            _ToolCard(
              icon: Icons.quiz_rounded,
              title: 'Take Quiz',
              subtitle: 'Test your knowledge with questions',
              iconColor: AppColors.success,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(
                      materialTitle: title,
                      materialContent: content,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            _ToolCard(
              icon: Icons.style_rounded,
              title: 'Flashcards',
              subtitle: 'Review important concepts quickly',
              iconColor: AppColors.action,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FlashcardsScreen(
                      materialTitle: title,
                      materialContent: content,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Notes',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                content.isEmpty
                    ? 'No notes have been added yet.'
                    : content,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 15,
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;
  const _ToolCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 27,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.secondaryText,
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}