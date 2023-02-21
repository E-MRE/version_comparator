import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import 'column_by_space.dart';

class DefaultCheckVersionProgress extends StatelessWidget {
  const DefaultCheckVersionProgress({
    Key? key,
    this.loadingWidget,
    required this.isLoadingTextVisible,
    required this.loadingWidgetSize,
    required this.spaceAroundChild,
    this.loadingText,
  }) : super(key: key);

  final Widget? loadingWidget;
  final bool isLoadingTextVisible;
  final double loadingWidgetSize;
  final double spaceAroundChild;
  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColumnBySpace(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        space: SizedBox(height: spaceAroundChild),
        children: [
          SizedBox(
            height: loadingWidgetSize,
            width: loadingWidgetSize,
            child: loadingWidget ?? const CircularProgressIndicator(),
          ),
          if (isLoadingTextVisible) Text(loadingText ?? kInfoMessage.checkVersionLoadingMessage)
        ],
      ),
    );
  }
}
