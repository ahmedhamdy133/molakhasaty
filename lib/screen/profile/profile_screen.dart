import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
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
          'Profile',
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
            children: [
              const SizedBox(height: 10),
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue
                            .withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: AppColors.cyanGlow,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Ahmed Hamdy',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Student',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Update Profile will be added next.',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit_rounded,
                          size: 19,
                        ),
                        label: const Text(
                          'Update Profile',
                        ),
                        style:
                            OutlinedButton.styleFrom(
                          foregroundColor:
                              AppColors.cyanGlow,
                          side: const BorderSide(
                            color:
                                AppColors.primaryBlue,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Account Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Account',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: 'Change Password',
                subtitle:
                    'Update your account password',
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Change Password will be added next.',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _SettingsTile(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle:
                    'Choose your preferred language',
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Language settings will be added next.',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              // App Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'App',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'About Molakhasaty',
                subtitle:
                    'Learn more about the app',
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Molakhasaty',
                    applicationVersion: '1.0.0',
                    applicationIcon:
                        const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.primaryBlue,
                      size: 35,
                    ),
                    children: const [
                      Text(
                        'Molakhasaty is a smart study assistant that helps students organize their materials, summarize notes, and practice with quizzes and flashcards.',
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              _SettingsTile(
                icon: Icons.delete_outline_rounded,
                title: 'Reset Study Data',
                subtitle:
                    'Clear your saved study materials',
                iconColor: AppColors.action,
                onTap: () {
                  _showResetDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              AppColors.secondaryBackground,
          title: const Text(
            'Reset Study Data?',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'This will remove your saved study materials.',
            style: TextStyle(
              color: AppColors.secondaryText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Study data reset.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                  color: AppColors.action,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? iconColor;
  final VoidCallback onTap;
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (iconColor ??
                        AppColors.primaryBlue)
                    .withOpacity(0.15),
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: iconColor ??
                    AppColors.cyanGlow,
                size: 24,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color:
                          AppColors.secondaryText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.secondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}