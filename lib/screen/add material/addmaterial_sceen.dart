import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../write_material/write_material_screen.dart';
import '../scan_notes/scan_notes_screen.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({super.key});
  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  int selectedOption = 0;
  final TextEditingController titleController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> continueAddingMaterial() async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the material title first.')),
      );
      return;
    }
    if (selectedOption == 0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WriteMaterialScreen(materialTitle: titleController.text.trim()),
        ),
      );
      if (result != null && mounted) {
        Navigator.pop(context, result);
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ScanNotesScreen(materialTitle: titleController.text.trim()),
        ),
      );
      if (result != null && mounted) {
        Navigator.pop(context, result);
      }
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
          'Add Material',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a new study material',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 15),
              ),
              const SizedBox(height: 28),
              const Text(
                'Material Title',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: titleController,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  hintText: 'e.g. Computer Networks',
                  hintStyle: const TextStyle(color: AppColors.secondaryText),
                  filled: true,
                  fillColor: AppColors.secondaryBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 17,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Choose how to add your material',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _OptionCard(
                icon: Icons.edit_note_rounded,
                title: 'Write Text',
                description: 'Write or paste your notes directly.',
                isSelected: selectedOption == 0,
                onTap: () {
                  setState(() {
                    selectedOption = 0;
                  });
                },
              ),
              const SizedBox(height: 14),
              _OptionCard(
                icon: Icons.document_scanner_rounded,
                title: 'Scan Notes',
                description: 'Scan your handwritten or printed notes.',
                isSelected: selectedOption == 1,
                onTap: () {
                  setState(() {
                    selectedOption = 1;
                  });
                },
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: continueAddingMaterial,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;
  const _OptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryBlue.withOpacity(0.18)
                    : AppColors.mainBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.cyanGlow
                    : AppColors.secondaryText,
                size: 27,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    description,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 23,
              ),
          ],
        ),
      ),
    );
  }
}
