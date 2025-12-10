import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_manger_dashboard/domain/entity/login_entity.dart';
import '../../core/flavor/flavor.dart';
import '../../core/filters/filter_enums.dart';
import '../../core/flavor/flavor_config.dart';
import '../comon/footer/footer_widget.dart';
import 'widgets/dashboard_header_widget.dart';
import 'widgets/dashboard_filters_widget.dart';
import 'widgets/repository_card_widget.dart';

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
  void initState() {
    super.initState();
    // Listen to search controller changes to trigger rebuild
    _searchController.addListener(() {
      setState(() {});
    });
  }

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
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filters and Count Widget
                  DashboardFiltersWidget(
                    filteredCount: filteredRepos.length,
                    totalCount: widget.repositories.length,
                    selectedPlatformFilter: _selectedPlatformFilter,
                    selectedBuildFilter: _selectedBuildFilter,
                    onPlatformFilterChanged: (value) {
                      setState(() {
                        _selectedPlatformFilter = value;
                      });
                    },
                    onBuildFilterChanged: (value) {
                      setState(() {
                        _selectedBuildFilter = value;
                      });
                    },
                  ),

                  SizedBox(height: 30.h),

                  // Repositories Grid
                  filteredRepos.isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(40.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              ),
                            ),
                            // Footer
                            const FooterWidget(),
                          ],
                        )
                      : Column(
                          children: [
                            LayoutBuilder(
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
                                  padding: EdgeInsets.symmetric(horizontal: 40.w),
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
                                    return RepositoryCardWidget(
                                      repository: repo,
                                      config: config,
                                      onTap: () => {},
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
