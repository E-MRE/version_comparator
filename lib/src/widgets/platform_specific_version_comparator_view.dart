import '../../version_comparator.dart';
import '../utils/constants/constants.dart';

class AppVersionComparatorView<TResult>
    extends CustomVersionComparatorView<TResult> {
  AppVersionComparatorView({
    super.key,
    required super.child,
    super.onStateChanged,
    String? androidId,
    String? iosId,
    String? huaweiId,
    RemoteDataService? dataService,
    super.onOutOfDateVersionError,
    super.versionDialogService,
    super.errorPageBuilder,
    super.outOfDateVersionPageBuilder,
    super.onAfterPopDialog,
    super.popVersionDialogResult,
    super.onCompareSuccess,
    super.onCompareError,
    super.invalidVersionDialogContentBuilder,
    super.outOfDateVersionDialogContentBuilder,
    super.loadingType = CheckVersionLoadingType.widget,
    super.loadingWidgetSize = kLoadingWidgetSize,
    super.isLoadingTextVisible = true,
    super.isChildExpandedInStack = false,
    super.isDismissibleWhenGetDataError = false,
    super.isUpdateRequired = false,
    super.isCancelActionVisible = true,
    super.spaceAroundChild = kMediumSpace,
    super.loadingWidget,
    super.loadingText,
  }) : super(
          onVersionCompareCallback: () async {
            return await VersionComparator.instance.versionCompare(
              iosId: iosId,
              huaweiId: huaweiId,
              androidId: androidId,
              dataService: dataService,
            );
          },
        );

  AppVersionComparatorView.alertDialog({
    super.key,
    required super.child,
    super.versionDialogService,
    super.onStateChanged,
    String? androidId,
    String? iosId,
    String? huaweiId,
    RemoteDataService? dataService,
    super.onOutOfDateVersionError,
    super.onAfterPopDialog,
    super.popVersionDialogResult,
    super.onCompareSuccess,
    super.onCompareError,
    super.invalidVersionDialogContentBuilder,
    super.loadingWidgetSize = kLoadingWidgetSize,
    super.isLoadingTextVisible = true,
    super.isChildExpandedInStack = false,
    super.isDismissibleWhenGetDataError = false,
    super.isUpdateRequired = false,
    super.isCancelActionVisible = true,
    super.spaceAroundChild = kMediumSpace,
    super.loadingWidget,
    super.loadingText,
  }) : super.alertDialog(
          onVersionCompareCallback: () async {
            return await VersionComparator.instance.versionCompare(
              iosId: iosId,
              huaweiId: huaweiId,
              androidId: androidId,
              dataService: dataService,
            );
          },
        );

  AppVersionComparatorView.widget({
    super.key,
    required super.errorPageBuilder,
    required super.outOfDateVersionPageBuilder,
    required super.child,
    super.onStateChanged,
    String? androidId,
    String? iosId,
    String? huaweiId,
    RemoteDataService? dataService,
    super.onOutOfDateVersionError,
    super.onCompareSuccess,
    super.onCompareError,
    super.loadingWidgetSize = kLoadingWidgetSize,
    super.isLoadingTextVisible = true,
    super.isChildExpandedInStack = false,
    super.isUpdateRequired = false,
    super.spaceAroundChild = kMediumSpace,
    super.loadingWidget,
    super.loadingText,
  }) : super.widget(
          onVersionCompareCallback: () async {
            return await VersionComparator.instance.versionCompare(
              iosId: iosId,
              huaweiId: huaweiId,
              androidId: androidId,
              dataService: dataService,
            );
          },
        );
}
