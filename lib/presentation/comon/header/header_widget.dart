import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/flavor/flavor.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final config = flavorConfig;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo on the left
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

          // Theme Toggle Icon on the right
          IconButton(
            onPressed: () {
              // TODO: Implement theme switching
            },
            icon: Icon(
              Icons.light_mode,
              size: 28.sp,
              color: Colors.grey[700],
            ),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
    );
  }
}

