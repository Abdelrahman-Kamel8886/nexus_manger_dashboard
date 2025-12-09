import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/flavor/flavor.dart';
import '../../../core/storage/secure_storage_manager.dart';

class DashboardHeaderWidget extends StatefulWidget {
  final TextEditingController? searchController;
  final String title;

  const DashboardHeaderWidget({
    super.key,
    this.searchController,
    this.title = 'Repositories',
  });

  @override
  State<DashboardHeaderWidget> createState() => _DashboardHeaderWidgetState();
}

class _DashboardHeaderWidgetState extends State<DashboardHeaderWidget> {
  String? _username;
  bool _isLoading = true;

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
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
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
      child: Column(
        children: [
          // Top row: Logo, Title, Account
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              config.logoPath.endsWith('.svg')
                  ? SvgPicture.asset(
                      config.logoPath,
                      height: 50.h,
                      width: 180.w,
                      fit: BoxFit.contain,
                      placeholderBuilder: (context) => Icon(
                        Icons.business,
                        size: 50.h,
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

              // Title
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ),

              // Account Icon with Menu
              PopupMenuButton<String>(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: config.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_circle,
                    size: 32.sp,
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

          SizedBox(height: 20.h),

          // Search Bar
          if (widget.searchController != null)
            TextField(
              controller: widget.searchController,
              decoration: InputDecoration(
                hintText: 'Search repositories...',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: widget.searchController!.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[600]),
                        onPressed: () {
                          setState(() {
                            widget.searchController!.clear();
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: config.primaryColor, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
        ],
      ),
    );
  }
}

