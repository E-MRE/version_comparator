import 'package:flutter/material.dart';

import '../../../version_comparator.dart';
import '../../utils/constants/constants.dart';

typedef VoidCompareErrorCallback = void Function(String message);
typedef VoidOutOfDateVersionErrorCallback = void Function(String message, VersionResponseModel data);
typedef VoidVersionComparatorSuccessCallback = void Function(VersionResponseModel data);
typedef FutureVersionResponseCallback = Future<DataResult<VersionResponseModel>> Function();
typedef VersionCompareErrorViewBuilder = Widget Function(BuildContext context, String message);
typedef VersionOutOfDateViewBuilder = Widget Function(BuildContext context, String message, VersionResponseModel data);

///Version comparator widget. It's a [StatefulWidget]. It basically manages all version compare process.
///There are three options for comparator widget. First one full custom mode, second one is widget mode and last of them is
///alertDialog mode.
abstract class VersionComparatorView<TResult> extends StatefulWidget {
  VersionComparatorView({
    Key? key,

    ///Version compare callback. When call this function it returns Future version model.
    required this.onVersionCompareCallback,

    ///App version control page. It needs for display page after version compare operation.
    required this.child,

    ///When state changed this function calls.
    this.onStateChanged,

    ///When app is out of date, this function calls.
    this.onOutOfDateVersionError,

    ///Custom version dialog service.
    VersionDialogService? versionDialogService,

    /// In the widget mode and any error happens than this builder shows widget.
    this.errorPageBuilder,

    ///In the widget mode and app is out of date than this builder shows widget.
    this.outOfDateVersionPageBuilder,

    ///In the dialog mode and user pop the alert dialog this function calls.
    this.onAfterPopDialog,

    ///Pop dialog result
    this.popVersionDialogResult,

    ///When version compare success than function triggers.
    this.onCompareSuccess,

    ///When any error happens in the compare process than function triggers.
    this.onCompareError,

    ///In the alertDialog mode and any error happens than this builder triggers.
    this.invalidVersionDialogContentBuilder,

    ///Comparator widget mode. Default value is widget.
    this.loadingType = CheckVersionLoadingType.widget,

    ///In the alertDialog mode and app version is out of date than this builder triggers.
    this.outOfDateVersionDialogContentBuilder,

    ///Loading widget size.
    this.loadingWidgetSize = kLoadingWidgetSize,

    ///Set loading text visibility. Default value is true
    this.isLoadingTextVisible = true,

    ///Set child expand. Default value is false.
    this.isChildExpandedInStack = false,

    ///Set alert dialog dismissible. Default value is false.
    this.isDismissibleWhenGetDataError = false,

    ///Set app version update is required. Default value is false.
    this.isUpdateRequired = false,

    ///Set alert dialog cancel button visibility. Default value is false.
    this.isCancelActionVisible = true,

    ///Empty space between widgets.
    this.spaceAroundChild = kMediumSpace,

    ///Custom loading widget
    this.loadingWidget,

    ///Custom loading text
    this.loadingText,
  })  : dialogService = versionDialogService ?? VersionComparator.instance.dialogService,
        super(key: key);

  VersionComparatorView.alertDialog({
    Key? key,

    ///Version compare callback. When call this function it returns Future version model.
    required this.onVersionCompareCallback,

    ///App version control page. It needs for display page after version compare operation.
    required this.child,

    ///When state changed this function calls.
    this.onStateChanged,

    ///When app is out of date, this function calls.
    this.onOutOfDateVersionError,

    ///Custom version dialog service.
    VersionDialogService? versionDialogService,

    ///In the dialog mode and user pop the alert dialog this function calls.
    this.onAfterPopDialog,

    ///Pop dialog result
    this.popVersionDialogResult,

    ///When version compare success than function triggers.
    this.onCompareSuccess,

    ///When any error happens in the compare process than function triggers.
    this.onCompareError,

    ///In the alertDialog mode and any error happens than this builder triggers.
    this.invalidVersionDialogContentBuilder,

    ///In the alertDialog mode and app version is out of date than this builder triggers.
    this.outOfDateVersionDialogContentBuilder,

    ///Loading widget size.
    this.loadingWidgetSize = kLoadingWidgetSize,

    ///Set loading text visibility. Default value is true
    this.isLoadingTextVisible = true,

    ///Set child expand. Default value is false.
    this.isChildExpandedInStack = false,

    ///Set alert dialog dismissible. Default value is false.
    this.isDismissibleWhenGetDataError = false,

    ///Set app version update is required. Default value is false.
    this.isUpdateRequired = false,

    ///Set alert dialog cancel button visibility. Default value is false.
    this.isCancelActionVisible = true,

    ///Empty space between widgets.
    this.spaceAroundChild = kMediumSpace,

    ///Custom loading widget
    this.loadingWidget,

    ///Custom loading text
    this.loadingText,
  })  : errorPageBuilder = null,
        outOfDateVersionPageBuilder = null,
        loadingType = CheckVersionLoadingType.alertDialog,
        dialogService = versionDialogService ?? VersionComparator.instance.dialogService,
        super(key: key);

  const VersionComparatorView.widget({
    Key? key,

    /// In the widget mode and any error happens than this builder shows widget.
    this.errorPageBuilder,

    ///In the widget mode and app is out of date than this builder shows widget.
    this.outOfDateVersionPageBuilder,

    ///Version compare callback. When call this function it returns Future version model.
    required this.onVersionCompareCallback,

    ///App version control page. It needs for display page after version compare operation.
    required this.child,

    ///When state changed this function calls.
    this.onStateChanged,

    ///When app is out of date, this function calls.
    this.onOutOfDateVersionError,

    ///When version compare success than function triggers.
    this.onCompareSuccess,

    ///When any error happens in the compare process than function triggers.
    this.onCompareError,

    ///Loading widget size.
    this.loadingWidgetSize = kLoadingWidgetSize,

    ///Set loading text visibility. Default value is true
    this.isLoadingTextVisible = true,

    ///Set child expand. Default value is false.
    this.isChildExpandedInStack = false,

    ///Set app version update is required. Default value is false.
    this.isUpdateRequired = false,

    ///Empty space between widgets.
    this.spaceAroundChild = kMediumSpace,

    ///Custom loading widget
    this.loadingWidget,

    ///Custom loading text
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
