import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
class AiSummaryScreen extends StatelessWidget {
  final String materialTitle;
  final String materialContent;
  const AiSummaryScreen({
    super.key,
    required this.materialTitle,
    required this.materialContent,
  });
  String createSummary() {
    if (materialContent.trim().isEmpty) {
      return 'There is not enough content to create a summary yet.';
    }
    final words = materialContent.trim().split(RegExp(r'\s+'));
    if (words.length <= 80) {
      return materialContent.trim();
    }
    return '${words.take(80).join(' ')}...';
  }
  @override
  Widget build(BuildContext context) {
    final summary = createSummary();
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
          'AI Summary',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color:
                          AppColors.cyanGlow.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.cyanGlow,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Material Summary',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          materialTitle,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Summary',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                summary,
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