import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/flavor/flavor.dart';
import '../../../core/storage/secure_storage_manager.dart';

class DashboardHeaderWidget extends StatefulWidget {
  final TextEditingController? searchController;

  const DashboardHeaderWidget({
    super.key,
    this.searchController,
  });

  @override
  State<DashboardHeaderWidget> createState() => _DashboardHeaderWidgetState();
}

class _DashboardHeaderWidgetState extends State<DashboardHeaderWidget> {
  String? _username;
  bool _isLoading = true;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final username = await SecureStorageManager.getUsername();
    setState(() {
      _username = username;
      _isLoading = false;
    });
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await SecureStorageManager.clearUsername();
      if (mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = flavorConfig;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo and Title
          Row(
            children: [
              // Logo
              config.logoPath.endsWith('.svg')
                  ? SvgPicture.asset(
                      config.logoPath,
                      height: 40.h,
                      width: 150.w,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) => Icon(
                        Icons.business,
                        size: 40.h,
                        color: config.primaryColor,
                      ),
                    )
                  : Image.asset(
                      config.logoPath,
                      height: 50.h,
                      width: 180.w,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.business,
                          size: 50.h,
                          color: config.primaryColor,
                        );
                      },
                    ),

              SizedBox(width: 16.w),

              // Title from flavor config
              Text(
                config.appTitle,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),

          // Search bar, Theme Toggle and Account
          Row(
            children: [
              // Search bar (smaller width)
              if (widget.searchController != null) ...[
                SizedBox(
                  width: 400.w,
                  height: 50.h,
                  child: TextField(
                    controller: widget.searchController,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search repositories...',
                      hintStyle: TextStyle(fontSize: 14.sp),
                      prefixIcon: Icon(Icons.search, size: 18.sp, color: Colors.grey[600]),
                      suffixIcon: widget.searchController!.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, size: 16.sp, color: Colors.grey[600]),
                              onPressed: () {
                                setState(() {
                                  widget.searchController!.clear();
                                });
                              },
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: config.primaryColor, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      isDense: true,
                    ),
                    onChanged: (_) {
                      // Update header state for clear button visibility
                      setState(() {});
                      // The listener in dashboard page will handle the rebuild
                    },
                  ),
                ),
                SizedBox(width: 12.w),
              ],
              
              // Theme Toggle
              IconButton(
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                    // TODO: Implement theme switching
                  });
                },
                icon: Icon(
                  _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: 24.sp,
                  color: Colors.grey[700],
                ),
                tooltip: _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              ),
              
              SizedBox(width: 8.w),
              
              // Account Icon with Menu
              PopupMenuButton<String>(
                icon: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: config.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_circle,
                    size: 28.sp,
                    color: config.primaryColor,
                  ),
                ),
                onSelected: (value) {
                  if (value == 'logout') {
                    _handleLogout();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _isLoading
                              ? 'Loading...'
                              : _username ?? 'Guest',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20.sp,
                          color: Colors.red[600],
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.red[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

