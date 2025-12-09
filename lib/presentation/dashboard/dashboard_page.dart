import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_manger_dashboard/domain/entity/login_entity.dart';
import '../../core/flavor/flavor.dart';
import '../../core/filters/filter_enums.dart';
import '../../core/flavor/flavor_config.dart';
import '../comon/footer/footer_widget.dart';
import '../comon/header/dashboard_header_widget.dart';

class DashboardPage extends StatefulWidget {
  final List<LoginEntity> repositories;

  const DashboardPage({super.key, required this.repositories});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  PlatformFilter _selectedPlatformFilter = PlatformFilter.all;
  BuildFilter _selectedBuildFilter = BuildFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LoginEntity> get _filteredRepositories {
    return widget.repositories.where((repo) {
      // Search filter
      final searchQuery = _searchController.text.toLowerCase();
      final matchesSearch =
          searchQuery.isEmpty || repo.name.toLowerCase().contains(searchQuery);

      // Platform filter
      final matchesPlatform = _selectedPlatformFilter.matches(repo.name);

      // Build filter
      final matchesBuild = _selectedBuildFilter.matches(repo.name);

      return matchesSearch && matchesPlatform && matchesBuild;
    }).toList();
  }

  Future<void> _navigateToRepository(LoginEntity repository) async {
    if (repository.url.isNotEmpty) {
      final uri = Uri.parse(repository.url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open ${repository.url}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = flavorConfig;
    final filteredRepos = _filteredRepositories;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Dashboard Header with search
          DashboardHeaderWidget(
            searchController: _searchController,
            title: 'Repositories',
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Count
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w , vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${filteredRepos.length} / ${widget.repositories.length}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Filters
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w , vertical: 20.h),
                    child: Row(
                      children: [
                        // Platform Filter
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PlatformFilter>(
                                value: _selectedPlatformFilter,
                                isExpanded: true,
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.grey[600],
                                ),
                                items: PlatformFilter.values.map((filter) {
                                  return DropdownMenuItem<PlatformFilter>(
                                    value: filter,
                                    child: Text(
                                      filter.displayName,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedPlatformFilter = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 16.w),

                        // Build Filter
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<BuildFilter>(
                                value: _selectedBuildFilter,
                                isExpanded: true,
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.grey[600],
                                ),
                                items: BuildFilter.values.map((filter) {
                                  return DropdownMenuItem<BuildFilter>(
                                    value: filter,
                                    child: Text(
                                      filter.displayName,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedBuildFilter = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Repositories Grid
                  filteredRepos.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.h),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64.sp,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'No repositories found',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Try adjusting your search or filters',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            // Calculate crossAxisCount based on screen width
                            final crossAxisCount = constraints.maxWidth > 1200
                                ? 4
                                : constraints.maxWidth > 800
                                ? 3
                                : constraints.maxWidth > 600
                                ? 2
                                : 1;

                            return GridView.builder(
                              padding:EdgeInsets.symmetric(horizontal: 40.w),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 20.w,
                                    mainAxisSpacing: 20.h,
                                    childAspectRatio: 1.2,
                                  ),
                              itemCount: filteredRepos.length,
                              itemBuilder: (context, index) {
                                final repo = filteredRepos[index];
                                return _RepositoryCard(
                                  repository: repo,
                                  config: config,
                                  onTap: () => _navigateToRepository(repo),
                                );
                              },
                            );
                          },
                        ),

                  SizedBox(height: 40.h),

                  // Footer
                  const FooterWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RepositoryCard extends StatelessWidget {
  final LoginEntity repository;
  final FlavorConfig config;
  final VoidCallback onTap;

  const _RepositoryCard({
    required this.repository,
    required this.config,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        repository.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[900],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: config.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: config.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward,
                        size: 14.sp,
                        color: config.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
