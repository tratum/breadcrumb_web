library breadcrumbs_web;

import 'package:flutter/material.dart';

import 'mouse_transforms/scale_on_hover.dart';

class BreadcrumbTrail {
  static Widget getCrumbsForWeb({
    required List<String> crumbs,
    required List<Future<dynamic> Function()> callbacks,
    String crumbFontFamily = 'Roboto',
    FontWeight crumbFontWeight = FontWeight.w600,
    Color crumbFontColor = const Color(0xff121212),
    double crumbSpacing = 8.0,
    double scaleOnHover = 12.0,
    double crumbFontSize = 16,
    IconData crumbIcon = Icons.arrow_forward_ios_sharp,
    double crumbIconSize = 14,
    Color crumbIconColor = const Color(0xff121212),
  }) {
    assert(crumbs.length == callbacks.length,
        'list of Crumbs and callbacks must be of the same length.');
    return Wrap(
      spacing: crumbSpacing,
      children: crumbs.asMap().map((index, item) {
        final isEnabled = index < callbacks.length;

        return MapEntry(
          index,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index != 0)
                Icon(
                  crumbIcon,
                  size: crumbIconSize,
                  color: isEnabled ? crumbIconColor : Colors.grey, // Disable color
                ),
              SizedBox(width: crumbSpacing),
              GestureDetector(
                onTap: isEnabled ? () async => callbacks[index]() : null,
                child: ScaleOnHover(
                  scale: scaleOnHover,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isEnabled ? crumbFontColor : Colors.grey, // Disable color
                      fontFamily: crumbFontFamily,
                      fontWeight: crumbFontWeight,
                      fontSize: crumbFontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).values.toList(),
    );
  }
}
