import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/flavor/flavor.dart';
import '../comon/footer/footer_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    config.logoPath.endsWith('.svg')
                        ? SvgPicture.asset(
                            config.logoPath,
                            height: 100.h,
                            width: 250.w,
                            fit: BoxFit.contain,
                            placeholderBuilder: (context) => Icon(
                              Icons.business,
                              size: 100.h,
                              color: config.primaryColor,
                            ),
                          )
                        : Image.asset(
                            config.logoPath,
                            height: 100.h,
                            width: 250.w,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.business,
                                size: 100.h,
                                color: config.primaryColor,
                              );
                            },
                          ),
                    
                    SizedBox(height: 40.h),
                    
                    Text(
                      'Welcome to ${config.appTitle}',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    Text(
                      'Dashboard content goes here',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey[600],
                      ),
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

