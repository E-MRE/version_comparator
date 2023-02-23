import 'package:flutter/material.dart';

import '../../version_comparator.dart';
import '../utils/constants/constants.dart';
import '../utils/mixins/version_result_validator_mixin.dart';
import 'version_result_error_dialog_content.dart';

part '../utils/mixins/custom_version_comparator_view_state_mixin.dart';

class CustomVersionComparatorView<TResult> extends VersionComparatorView<TResult> {
  CustomVersionComparatorView({
    super.key,
    required super.onVersionCompareCallback,
    required super.child,
    super.onStateChanged,
    super.onOutOfDateVersionError,
    super.versionDialogService,
    super.errorPageBuilder,
    super.outOfDateVersionPageBuilder,
    super.onAfterPopDialog,
    super.popVersionDialogResult,
    super.onCompareSuccess,
    super.onCompareError,
    super.invalidVersionDialogContentBuilder,
    super.loadingType = CheckVersionLoadingType.widget,
    super.outOfDateVersionDialogContentBuilder,
    super.loadingWidgetSize = kLoadingWidgetSize,
    super.isLoadingTextVisible = true,
    super.isChildExpandedInStack = false,
    super.isDismissibleWhenGetDataError = false,
    super.isUpdateRequired = false,
    super.isCancelActionVisible = true,
    super.spaceAroundChild = kMediumSpace,
    super.loadingWidget,
    super.loadingText,
  });

  CustomVersionComparatorView.alertDialog({
    super.key,
    required super.onVersionCompareCallback,
    required super.child,
    super.onStateChanged,
    super.versionDialogService,
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
  }) : super.alertDialog();

  const CustomVersionComparatorView.widget({
    super.key,
    required super.errorPageBuilder,
    required super.onVersionCompareCallback,
    required super.outOfDateVersionPageBuilder,
    required super.child,
    super.onStateChanged,
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
  }) : super.widget();

  @override
  State<CustomVersionComparatorView<TResult>> createState() => _CustomVersionComparatorViewState<TResult>();
}

class _CustomVersionComparatorViewState<TResult> extends State<CustomVersionComparatorView<TResult>>
    with _CustomVersionComparatorViewStateMixin<TResult>, VersionResultValidatorMixin {
  @override
  Widget build(BuildContext context) {
    if (_state is VersionComparatorErrorState) {
      final errorState = (_state as VersionComparatorErrorState);
      return errorState.isOldVersionError && errorState.data != null
          ? (widget.outOfDateVersionPageBuilder?.call(context, errorState.message, errorState.data!) ?? widget.child)
          : (widget.errorPageBuilder?.call(context, errorState.message) ?? widget.child);
    } else if (_state is VersionComparatorLoadingState) {
      return _buildLoadingBodyByType();
    }

    return widget.child;
  }

  Widget _buildLoadingBodyByType() {
    return widget.loadingType == CheckVersionLoadingType.alertDialog ? _buildAlertLoading() : _buildLoading();
  }

  Widget _buildChild() {
    return widget.isChildExpandedInStack ? Expanded(child: widget.child) : widget.child;
  }

  Widget _buildAlertLoading() {
    return Stack(
      children: [
        _buildChild(),
        CheckVersionProgressDialog(
          customLoading: widget.loadingWidget,
          loadingWidgetSize: widget.loadingWidgetSize,
          loadingText: widget.loadingText,
          isTextVisible: widget.isLoadingTextVisible,
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return widget.loadingWidget ??
        DefaultCheckVersionProgress(
          isLoadingTextVisible: widget.isLoadingTextVisible,
          loadingWidgetSize: widget.loadingWidgetSize,
          spaceAroundChild: widget.spaceAroundChild,
          loadingText: widget.loadingText,
          loadingWidget: widget.loadingWidget,
        );
  }
}
