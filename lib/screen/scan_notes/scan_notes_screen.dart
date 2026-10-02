import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/app_colors.dart';
import '../extracted_text/extracted_text_screen.dart';

class ScanNotesScreen extends StatefulWidget {
  final String materialTitle;
  const ScanNotesScreen({super.key, required this.materialTitle});
  @override
  State<ScanNotesScreen> createState() => _ScanNotesScreenState();
}

class _ScanNotesScreenState extends State<ScanNotesScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;
  bool isProcessing = false;
  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await picker.pickImage(source: source, imageQuality: 85);
      if (image == null) {
        return;
      }
      setState(() {
        selectedImage = image;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not select image: $e')));
    }
  }

  void showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose Image Source',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.cyanGlow,
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(color: AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: AppColors.cyanGlow,
                  ),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(color: AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> extractText() async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose an image first.')),
      );
      return;
    }
    setState(() {
      isProcessing = true;
    });
    try {
      final String extractedText = await FlutterTesseractOcr.extractText(
        selectedImage!.path,
        language: 'eng',
        args: {'preserve_interword_spaces': '1'},
      );
      if (!mounted) return;
      setState(() {
        isProcessing = false;
      });
      final text = extractedText.trim();
      if (text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No text was detected in this image.')),
        );
        return;
      }
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExtractedTextScreen(
            materialTitle: widget.materialTitle,
            extractedText: text,
          ),
        ),
      );
      if (result != null && mounted) {
        Navigator.pop(context, result);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isProcessing = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not extract text: $e')));
    }
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
          'Scan Notes',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Scan Your Notes',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Take a photo of your notes and extract the text automatically.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.4),
                      width: 1.2,
                    ),
                  ),
                  child: selectedImage == null
                      ? _EmptyScanView(onTap: showImageOptions)
                      : _SelectedImageView(
                          image: selectedImage!,
                          onChange: showImageOptions,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Material: ${widget.materialTitle}',
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: isProcessing ? null : extractText,
                  icon: isProcessing
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.white,
                          ),
                        )
                      : const Icon(Icons.auto_awesome_rounded),
                  label: Text(
                    isProcessing ? 'Extracting Text...' : 'Extract Text',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.secondaryBackground,
                    disabledForegroundColor: AppColors.secondaryText,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
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

class _EmptyScanView extends StatelessWidget {
  final VoidCallback onTap;
  const _EmptyScanView({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.document_scanner_rounded,
              color: AppColors.cyanGlow,
              size: 42,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ready to scan',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Capture or choose a clear photo of your handwritten or printed notes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedImageView extends StatelessWidget {
  final XFile image;
  final VoidCallback onChange;
  const _SelectedImageView({required this.image, required this.onChange});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: FutureBuilder(
              future: image.readAsBytes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                    ),
                  );
                }
                return Image.memory(
                  snapshot.data!,
                  width: double.infinity,
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton.icon(
            onPressed: onChange,
            icon: const Icon(Icons.change_circle_outlined),
            label: const Text('Choose Another Image'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.cyanGlow,
              side: const BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
