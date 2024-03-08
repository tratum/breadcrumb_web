library breadcrumbs_web;

import 'package:flutter/material.dart';

import 'mouse_transforms/scale_on_hover.dart';

enum BreadcrumbState {
  active,
  completed,
  disabled,
}

class BreadcrumbTrail {
  static Widget getCrumbsForWeb({
    required List<String> crumbs,
    required List<Future<dynamic> Function()> callbacks,
    required List<BreadcrumbState> breadcrumbStates,
    String crumbFontFamily = 'Roboto',
    FontWeight crumbFontWeight = FontWeight.w600,
    Color crumbFontColor = const Color(0xff121212),
    double crumbFontSize = 16,
    double crumbSpacing = 8.0,
    double scaleOnHover = 12.0,
    Widget? crumbSeparator,
    IconData crumbIcon = Icons.arrow_forward_ios_sharp,
    double crumbIconSize = 14,
    Color crumbIconColor = const Color(0xff121212),
    Color activeStateColor = const Color(0XFF2196F3),
    Color completedStateColor = const Color(0XFF4CAF50),
    Color disabledStateColor = const Color(0XFF9E9E9E),
  }) {
    assert(
      crumbs.length == callbacks.length &&
          crumbs.length == breadcrumbStates.length,
      'Lists of crumbs, callbacks, and breadcrumb states must be of the same length.',
    );
    final bool crumbSeperatorUsage = crumbSeparator != null;  // checks if crumbSeperator is used or not
    return Wrap(
      spacing: crumbSpacing,
      children: List.generate(crumbs.length, (index) {
        final isEnabled = index < callbacks.length;
        final state = breadcrumbStates[index];

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index != 0 && !crumbSeperatorUsage)
              Icon(
                crumbIcon,
                size: crumbIconSize,
                color: crumbIconColor,
              ),
            if (index != 0 && crumbSeperatorUsage)
              crumbSeparator,
            SizedBox(width: crumbSpacing),
            GestureDetector(
              onTap: isEnabled ? () async => callbacks[index]() : null,
              child: ScaleOnHover(
                scale: scaleOnHover,
                child: Text(
                  crumbs[index],
                  style: TextStyle(
                    color: _getCrumbColorState(state, activeStateColor,
                        completedStateColor, disabledStateColor),
                    fontFamily: crumbFontFamily,
                    fontWeight: crumbFontWeight,
                    fontSize: crumbFontSize,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      // crumbs.asMap().map((index, item) {
      //   final isEnabled = index < callbacks.length;
      //
      //   return MapEntry(
      //     index,
      //     Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         if (index != 0)
      //           Icon(
      //             crumbIcon,
      //             size: crumbIconSize,
      //             color: isEnabled ? crumbIconColor : Colors.grey, // Disable color
      //           ),
      //         SizedBox(width: crumbSpacing),
      //         GestureDetector(
      //           onTap: isEnabled ? () async => callbacks[index]() : null,
      //           child: ScaleOnHover(
      //             scale: scaleOnHover,
      //             child: Text(
      //               item,
      //               style: TextStyle(
      //                 color: isEnabled ? crumbFontColor : Colors.grey, // Disable color
      //                 fontFamily: crumbFontFamily,
      //                 fontWeight: crumbFontWeight,
      //                 fontSize: crumbFontSize,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      // }).values.toList(),
    );
  }

  static Color _getCrumbColorState(BreadcrumbState state, Color activeColor,
      Color completedColor, Color disabledColor) {
    switch (state) {
      case BreadcrumbState.active:
        return activeColor;
      case BreadcrumbState.completed:
        return completedColor;
      case BreadcrumbState.disabled:
        return disabledColor;
    }
  }
}
