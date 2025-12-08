import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/flavor/flavor.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final config = flavorConfig;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: config.footerColor,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 800;
          final textColor = config.footerTextColor ?? Colors.white;
          
          return Column(
            children: [
              // Footer Content
              isWideScreen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company Info
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                config.appTitle,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Copyright © 2025 Fawry. All rights reserved.',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: textColor.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Quick Links
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quick Links',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _FooterLink(
                                textColor: textColor,
                                text: 'Support',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Support page coming soon'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 8.h),
                              _FooterLink(
                                textColor: textColor,
                                text: 'FAQ',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('FAQ page coming soon'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 8.h),
                              _FooterLink(
                                textColor: textColor,
                                text: 'Privacy Policy',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Privacy Policy page coming soon'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 8.h),
                              _FooterLink(
                                textColor: textColor,
                                text: 'Terms of Service',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Terms of Service page coming soon'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Social Media
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Follow Us',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Wrap(
                                spacing: 12.w,
                                children: [
                                  _SocialIcon(
                                    textColor: textColor,
                                    icon: Icons.facebook,
                                    onTap: () {
                                      // TODO: Open Facebook
                                    },
                                  ),
                                  _SocialIcon(
                                    textColor: textColor,
                                    icon: Icons.camera_alt,
                                    onTap: () {
                                      // TODO: Open Instagram
                                    },
                                  ),
                                  _SocialIcon(
                                    textColor: textColor,
                                    icon: Icons.music_note,
                                    onTap: () {
                                      // TODO: Open TikTok
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              config.appTitle,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '© ${DateTime.now().year} ${config.name.toUpperCase()}. All rights reserved.',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: textColor.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        // Quick Links
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Links',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _FooterLink(
                              textColor: textColor,
                              text: 'Support',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Support page coming soon'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 8.h),
                            _FooterLink(
                              textColor: textColor,
                              text: 'FAQ',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('FAQ page coming soon'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 8.h),
                            _FooterLink(
                              textColor: textColor,
                              text: 'Privacy Policy',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Privacy Policy page coming soon'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 8.h),
                            _FooterLink(
                              textColor: textColor,
                              text: 'Terms of Service',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Terms of Service page coming soon'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        // Social Media
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Follow Us',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 12.w,
                              children: [
                                _SocialIcon(
                                  textColor: textColor,
                                  icon: Icons.facebook,
                                  onTap: () {
                                    // TODO: Open Facebook
                                  },
                                ),
                                _SocialIcon(
                                  textColor: textColor,
                                  icon: Icons.business,
                                  onTap: () {
                                    // TODO: Open LinkedIn
                                  },
                                ),
                                _SocialIcon(
                                  textColor: textColor,
                                  icon: Icons.camera_alt,
                                  onTap: () {
                                    // TODO: Open Instagram
                                  },
                                ),
                                _SocialIcon(
                                  textColor: textColor,
                                  icon: Icons.music_note,
                                  onTap: () {
                                    // TODO: Open TikTok
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onTap;

  const _FooterLink({
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          color: textColor.withOpacity(0.9),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color textColor;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(
            color: textColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 26.sp,
          color: textColor,
        ),
      ),
    );
  }
}

