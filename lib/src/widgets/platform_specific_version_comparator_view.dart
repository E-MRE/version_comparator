import '../../version_comparator.dart';
import '../utils/constants/constants.dart';

class PlatformSpecificVersionComparatorView<TResult> extends CustomVersionComparatorView<TResult> {
  PlatformSpecificVersionComparatorView({
    super.key,
    required super.child,
    super.onStateChanged,
    String? customAppId,
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
            return await VersionComparator.instance.platformSpecificCompareByAppId(
              customAppId: customAppId,
              dataService: dataService,
            );
          },
        );

  PlatformSpecificVersionComparatorView.alertDialog({
    super.key,
    required super.child,
    super.versionDialogService,
    super.onStateChanged,
    String? customAppId,
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
            return await VersionComparator.instance.platformSpecificCompareByAppId(
              customAppId: customAppId,
              dataService: dataService,
            );
          },
        );

  PlatformSpecificVersionComparatorView.widget({
    super.key,
    required super.errorPageBuilder,
    required super.outOfDateVersionPageBuilder,
    required super.child,
    super.onStateChanged,
    String? customAppId,
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
            return await VersionComparator.instance.platformSpecificCompareByAppId(
              customAppId: customAppId,
              dataService: dataService,
            );
          },
        );
}
