import 'package:flutter/material.dart';

import '../../../version_comparator.dart';
import '../../utils/constants/constants.dart';

typedef VoidCompareErrorCallback = void Function(String message);
typedef VoidOutOfDateVersionErrorCallback = void Function(String message, VersionResponseModel data);
typedef VoidVersionComparatorSuccessCallback = void Function(VersionResponseModel data);
typedef FutureVersionResponseCallback = Future<DataResult<VersionResponseModel>> Function();
typedef VersionCompareErrorViewBuilder = Widget Function(BuildContext context, String message);
typedef VersionOutOfDateViewBuilder = Widget Function(BuildContext context, String message, VersionResponseModel data);

abstract class VersionComparatorView<TResult> extends StatefulWidget {
  VersionComparatorView({
    Key? key,
    required this.onVersionCompareCallback,
    required this.child,
    this.onStateChanged,
    this.onOutOfDateVersionError,
    VersionDialogService? versionDialogService,
    this.errorPageBuilder,
    this.outOfDateVersionPageBuilder,
    this.onAfterPopDialog,
    this.popVersionDialogResult,
    this.onCompareSuccess,
    this.onCompareError,
    this.invalidVersionDialogContentBuilder,
    this.loadingType = CheckVersionLoadingType.widget,
    this.outOfDateVersionDialogContentBuilder,
    this.loadingWidgetSize = kLoadingWidgetSize,
    this.isLoadingTextVisible = true,
    this.isChildExpandedInStack = false,
    this.isDismissibleWhenGetDataError = false,
    this.isUpdateRequired = false,
    this.isCancelActionVisible = true,
    this.spaceAroundChild = kMediumSpace,
    this.loadingWidget,
    this.loadingText,
  })  : dialogService = versionDialogService ?? VersionComparator.instance.dialogService,
        super(key: key);

  VersionComparatorView.alertDialog({
    Key? key,
    required this.onVersionCompareCallback,
    required this.child,
    VersionDialogService? versionDialogService,
    this.onStateChanged,
    this.onOutOfDateVersionError,
    this.onAfterPopDialog,
    this.popVersionDialogResult,
    this.onCompareSuccess,
    this.onCompareError,
    this.invalidVersionDialogContentBuilder,
    this.outOfDateVersionDialogContentBuilder,
    this.loadingWidgetSize = kLoadingWidgetSize,
    this.isLoadingTextVisible = true,
    this.isChildExpandedInStack = false,
    this.isDismissibleWhenGetDataError = false,
    this.isUpdateRequired = false,
    this.isCancelActionVisible = true,
    this.spaceAroundChild = kMediumSpace,
    this.loadingWidget,
    this.loadingText,
  })  : errorPageBuilder = null,
        outOfDateVersionPageBuilder = null,
        loadingType = CheckVersionLoadingType.alertDialog,
        dialogService = versionDialogService ?? VersionComparator.instance.dialogService,
        super(key: key);

  const VersionComparatorView.widget({
    Key? key,
    required this.errorPageBuilder,
    required this.onVersionCompareCallback,
    required this.outOfDateVersionPageBuilder,
    required this.child,
    this.onStateChanged,
    this.onOutOfDateVersionError,
    this.onCompareSuccess,
    this.onCompareError,
    this.loadingWidgetSize = kLoadingWidgetSize,
    this.isLoadingTextVisible = true,
    this.isChildExpandedInStack = false,
    this.isUpdateRequired = false,
    this.spaceAroundChild = kMediumSpace,
    this.loadingWidget,
    this.loadingText,
  })  : loadingType = CheckVersionLoadingType.widget,
        dialogService = null,
        isCancelActionVisible = false,
        isDismissibleWhenGetDataError = false,
        invalidVersionDialogContentBuilder = null,
        outOfDateVersionDialogContentBuilder = null,
        popVersionDialogResult = null,
        onAfterPopDialog = null,
        super(key: key);

  final VersionCompareErrorViewBuilder? errorPageBuilder;
  final VersionCompareErrorViewBuilder? invalidVersionDialogContentBuilder;
  final VersionOutOfDateViewBuilder? outOfDateVersionPageBuilder;
  final VersionOutOfDateViewBuilder? outOfDateVersionDialogContentBuilder;

  final FutureVersionResponseCallback onVersionCompareCallback;
  final VoidCompareErrorCallback? onCompareError;
  final VoidOutOfDateVersionErrorCallback? onOutOfDateVersionError;
  final VoidVersionComparatorSuccessCallback? onCompareSuccess;

  final void Function(TResult? result)? onAfterPopDialog;
  final void Function(VersionComparatorState state)? onStateChanged;

  final Widget child;
  final Widget? loadingWidget;

  final VersionDialogService? dialogService;
  final CheckVersionLoadingType loadingType;
  final TResult? popVersionDialogResult;

  final bool isChildExpandedInStack;
  final bool isLoadingTextVisible;
  final bool isDismissibleWhenGetDataError;
  final bool isUpdateRequired;
  final bool isCancelActionVisible;

  final double loadingWidgetSize;
  final double spaceAroundChild;

  final String? loadingText;
}
