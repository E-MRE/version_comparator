import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import 'column_by_space.dart';

class CheckVersionProgressDialog extends StatelessWidget {
  const CheckVersionProgressDialog({
    Key? key,
    this.backgroundColor,
    this.customLoading,
    this.loadingText,
    this.isTextVisible = true,
    this.loadingWidgetSize = kLoadingWidgetSize,
    this.spaceAroundChildren = kMediumSpace,
  }) : super(key: key);

  final Color? backgroundColor;
  final Widget? customLoading;

  final String? loadingText;
  final bool isTextVisible;
  final double loadingWidgetSize;
  final double spaceAroundChildren;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.zero,
      color: backgroundColor ?? Colors.black.withOpacity(kTransparentBlack),
      child: AlertDialog(
        alignment: Alignment.center,
        content: ColumnBySpace(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          space: SizedBox(height: spaceAroundChildren),
          children: [
            SizedBox(
              height: loadingWidgetSize,
              width: loadingWidgetSize,
              child: customLoading ?? const CircularProgressIndicator(),
            ),
            if (isTextVisible) Text(loadingText ?? kInfoMessage.checkVersionLoadingMessage)
          ],
        ),
      ),
    );
  }
}
