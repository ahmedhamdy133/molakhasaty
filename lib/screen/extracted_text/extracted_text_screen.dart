import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
class ExtractedTextScreen extends StatefulWidget {
  final String materialTitle;
  final String extractedText;
  const ExtractedTextScreen({
    super.key,
    required this.materialTitle,
    required this.extractedText,
  });
  @override
  State<ExtractedTextScreen> createState() =>
      _ExtractedTextScreenState();
}
class _ExtractedTextScreenState
    extends State<ExtractedTextScreen> {
  late TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: widget.extractedText,
    );
  }
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  void saveMaterial() {
    final text = textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter some text first.',
          ),
        ),
      );
      return;
    }
    Navigator.pop(
      context,
      {
        'title': widget.materialTitle,
        'content': text,
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor: AppColors.mainBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
        title: const Text(
          'Extracted Text',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            10,
            24,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Review Your Notes',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Review and edit the extracted text before saving your material.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Material Title',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.materialTitle,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Extracted Content',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textController,
                minLines: 12,
                maxLines: 18,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  hintText:
                      'Extracted text will appear here...',
                  hintStyle: const TextStyle(
                    color: AppColors.secondaryText,
                  ),
                  filled: true,
                  fillColor: AppColors.secondaryBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(18),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: saveMaterial,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Save Material',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}