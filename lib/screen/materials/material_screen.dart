import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/screen/add%20material/addmaterial_sceen.dart';
import 'package:flutter_application_4/screen/material_details/material_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_colors.dart';
class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});
  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}
class _MaterialsScreenState extends State<MaterialsScreen> {
  static const String materialsKey = 'saved_materials';
  List<Map<String, dynamic>> materials = [
    {
      'title': 'Computer Networks',
      'subtitle': '12 Notes',
      'progress': 0.70,
      'icon': Icons.lan_rounded.codePoint,
      'content':
          'Computer Networks is the study of how computers and devices communicate with each other through different types of networks. Networks allow devices to share data, resources, and services efficiently.',
    },
    {
      'title': 'Database Systems',
      'subtitle': '8 Notes',
      'progress': 0.45,
      'icon': Icons.storage_rounded.codePoint,
      'content':
          'Database systems are used to store, organize, manage, and retrieve data efficiently. A database management system helps users create and maintain structured data.',
    },
    {
      'title': 'Operating Systems',
      'subtitle': '10 Notes',
      'progress': 0.60,
      'icon': Icons.computer_rounded.codePoint,
      'content':
          'An operating system is system software that manages computer hardware and software resources and provides common services for computer programs.',
    },
    {
      'title': 'Data Structures',
      'subtitle': '6 Notes',
      'progress': 0.30,
      'icon': Icons.account_tree_rounded.codePoint,
      'content':
          'Data structures are ways of organizing and storing data so that it can be accessed and modified efficiently. Examples include arrays, stacks, queues, trees, and graphs.',
    },
  ];
  @override
  void initState() {
    super.initState();
    loadMaterials();
  }
  Future<void> loadMaterials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(materialsKey);
    if (savedData == null) {
      return;
    }
    try {
      final List<dynamic> decodedData = jsonDecode(savedData);
      final loadedMaterials = decodedData.map<Map<String, dynamic>>((item) {
        return {
          'title': item['title'] ?? 'Untitled Material',
          'subtitle': item['subtitle'] ?? '1 Note',
          'progress': (item['progress'] ?? 0.0).toDouble(),
          'icon': item['icon'] ?? Icons.menu_book_rounded.codePoint,
          'content': item['content'] ?? '',
        };
      }).toList();
      setState(() {
        materials = loadedMaterials;
      });
    } catch (e) {
      debugPrint('Error loading materials: $e');
    }
  }
  Future<void> saveMaterials() async {
    final prefs = await SharedPreferences.getInstance();
    final dataToSave = materials.map((material) {
      return {
        'title': material['title'],
        'subtitle': material['subtitle'],
        'progress': material['progress'],
        'icon': material['icon'],
        'content': material['content'],
      };
    }).toList();
    await prefs.setString(
      materialsKey,
      jsonEncode(dataToSave),
    );
  }
  Future<void> openAddMaterial() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMaterialScreen(),
      ),
    );
    if (result != null && result is Map) {
      final title = result['title']?.toString() ?? 'New Material';
      final content = result['content']?.toString() ?? '';
      setState(() {
        materials.add({
          'title': title,
          'subtitle': '1 Note',
          'progress': 0.0,
          'icon': Icons.menu_book_rounded.codePoint,
          'content': content,
        });
      });
      await saveMaterials();
    }
  }
  void openMaterial(Map<String, dynamic> material) {
    final iconCode = material['icon'] ?? Icons.menu_book_rounded.codePoint;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MaterialDetailsScreen(
          title: material['title'] ?? 'Untitled Material',
          subtitle: material['subtitle'] ?? '1 Note',
          progress: (material['progress'] ?? 0.0).toDouble(),
          content: material['content'] ?? '',
          icon: IconData(
            iconCode,
            fontFamily: 'Material Icons',
          ),
        ),
      ),
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
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
        title: const Text(
          'My Materials',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: openAddMaterial,
            icon: const Icon(
              Icons.add_rounded,
              color: AppColors.cyanGlow,
              size: 30,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final material = materials[index];
          final iconCode =
              material['icon'] ?? Icons.menu_book_rounded.codePoint;
          final icon = IconData(
            iconCode,
            fontFamily: 'Material Icons',
          );
          final progress =
              (material['progress'] ?? 0.0).toDouble();
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: GestureDetector(
              onTap: () => openMaterial(material),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color:
                            AppColors.primaryBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        icon,
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
                          Text(
                            material['title'] ?? '',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            material['subtitle'] ?? '',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 7,
                              backgroundColor:
                                  const Color(0xFF315268),
                              valueColor:
                                  const AlwaysStoppedAnimation(
                                AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue,
        onPressed: openAddMaterial,
        child: const Icon(
          Icons.add_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }
}