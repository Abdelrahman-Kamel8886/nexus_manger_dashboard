import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus_manger_dashboard/domain/entity/repos_entity.dart';
import '../../core/flavor/flavor.dart';
import '../comon/footer/footer_widget.dart';

class DashboardPage extends StatelessWidget {
  final List<RepoEntity> repositories;

  const DashboardPage({
    super.key,
    required this.repositories,
  });

  @override
  Widget build(BuildContext context) {
    final config = flavorConfig;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main Content
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    config.logoPath.endsWith('.svg')
                        ? SvgPicture.asset(
                            config.logoPath,
                            height: 60.h,
                            width: 200.w,
                            fit: BoxFit.contain,
                            placeholderBuilder: (context) => Icon(
                              Icons.business,
                              size: 60.h,
                              color: config.primaryColor,
                            ),
                          )
                        : Image.asset(
                            config.logoPath,
                            height: 60.h,
                            width: 200.w,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.business,
                                size: 60.h,
                                color: config.primaryColor,
                              );
                            },
                          ),
                    
                    SizedBox(height: 40.h),
                    
                    Text(
                      'Repositories',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                      ),
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    Text(
                      'Total: ${repositories.length} repositories',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    
                    SizedBox(height: 30.h),
                    
                    // Repositories List
                    repositories.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(40.h),
                              child: Text(
                                'No repositories found',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: repositories.length,
                            separatorBuilder: (context, index) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final repo = repositories[index];
                              return Container(
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      repo.name,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[900],
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    if (repo.url.isNotEmpty)
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.link,
                                            size: 16.sp,
                                            color: Colors.grey[600],
                                          ),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              repo.url,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.blue[600],
                                                decoration: TextDecoration.underline,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
            
            // Footer at the end of scrollable content
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

}

