import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/filters/filter_enums.dart';

class DashboardFiltersWidget extends StatelessWidget {
  final int filteredCount;
  final int totalCount;
  final PlatformFilter selectedPlatformFilter;
  final BuildFilter selectedBuildFilter;
  final ValueChanged<PlatformFilter> onPlatformFilterChanged;
  final ValueChanged<BuildFilter> onBuildFilterChanged;

  const DashboardFiltersWidget({
    super.key,
    required this.filteredCount,
    required this.totalCount,
    required this.selectedPlatformFilter,
    required this.selectedBuildFilter,
    required this.onPlatformFilterChanged,
    required this.onBuildFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFiltered = filteredCount != totalCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Count Badge with enhanced styling
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Filter label
              Row(
                children: [
                  Icon(
                    Icons.tune,
                    size: 20.sp,
                    color: Colors.grey[700],
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),

              // Count badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isFiltered ? Colors.blue[50] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isFiltered ? Colors.blue[200]! : Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.list_alt,
                      size: 18.sp,
                      color: isFiltered ? Colors.blue[700] : Colors.grey[600],
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '$filteredCount',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isFiltered ? Colors.blue[700] : Colors.grey[800],
                      ),
                    ),
                    Text(
                      ' / $totalCount',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Filters Row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
          child: Row(
            children: [
              // Platform Filter
              Expanded(
                child: _buildFilterDropdown<PlatformFilter>(
                  context: context,
                  value: selectedPlatformFilter,
                  icon: selectedPlatformFilter.icon,
                  label: 'Platform',
                  items: PlatformFilter.values,
                  getDisplayName: (filter) => filter.displayName,
                  getIcon: (filter) => filter.icon,
                  onChanged: (value) {
                    if (value != null) {
                      onPlatformFilterChanged(value);
                    }
                  },
                ),
              ),

              SizedBox(width: 16.w),

              // Build Filter
              Expanded(
                child: _buildFilterDropdown<BuildFilter>(
                  context: context,
                  value: selectedBuildFilter,
                  icon: selectedBuildFilter.icon,
                  label: 'Build Type',
                  items: BuildFilter.values,
                  getDisplayName: (filter) => filter.displayName,
                  getIcon: (filter) => filter.icon,
                  onChanged: (value) {
                    if (value != null) {
                      onBuildFilterChanged(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown<T>({
    required BuildContext context,
    required T value,
    required IconData icon,
    required String label,
    required List<T> items,
    required String Function(T) getDisplayName,
    required IconData Function(T) getIcon,
    required ValueChanged<T?> onChanged,
  }) {
    final isSelected = value != items.first; // Check if not "all"

    return Container(
      padding: EdgeInsets.only(left: 8.w, top: 8.h, right: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? Colors.blue[300]! : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          Row(
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: isSelected ? Colors.blue[600] : Colors.grey[600],
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 20.sp,
                color: Colors.grey[600],
              ),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              items: items.map((item) {
                final isItemSelected = item == value;
                return DropdownMenuItem<T>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(
                        getIcon(item),
                        size: 18.sp,
                        color: isItemSelected
                            ? Colors.blue[600]
                            : Colors.grey[600],
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          getDisplayName(item),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: isItemSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isItemSelected
                                ? Colors.blue[700]
                                : Colors.grey[800],
                          ),
                        ),
                      ),
                      if (isItemSelected)
                        Icon(
                          Icons.check_circle,
                          size: 18.sp,
                          color: Colors.blue[600],
                        ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

