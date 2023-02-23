// import 'package:flutter/material.dart';

// import '../models/version_response_model.dart';
// import '../services/abstracts/version_dialog_service.dart';
// import '../utils/constants/constants.dart';
// import '../utils/enums/check_version_loading_type.dart';
// import '../utils/mixins/version_result_validator_mixin.dart';
// import '../utils/results/data_result.dart';
// import 'check_version_progress_dialog.dart';
// import 'default_check_version_progress.dart';
// import 'version_result_error_dialog_content.dart';

// typedef FutureVersionResponseCallback = Future<DataResult<VersionResponseModel>> Function();

// class VersionCompareWrapper<TResult> extends StatefulWidget {
//   const VersionCompareWrapper({
//     Key? key,
//     required this.child,
//     required this.futureCallback,
//     required this.dialogService,
//     this.errorPage,
//     this.outOfDateVersionPage,
//     this.onAfterPopDialog,
//     this.popVersionDialogResult,
//     this.onResultFound,
//     this.onVersionInvalid,
//     this.getVersionErrorDialogContent,
//     this.loadingType = CheckVersionLoadingType.widget,
//     this.loadingWidgetSize = kLoadingWidgetSize,
//     this.isLoadingTextVisible = true,
//     this.isChildExpandedInStack = false,
//     this.isDismissibleWhenGetDataError = false,
//     this.isUpdateRequired = false,
//     this.isCancelActionVisible = true,
//     this.spaceAroundChild = kMediumSpace,
//     this.loadingText,
//     this.loadingWidget,
//   }) : super(key: key);

//   final FutureVersionResponseCallback futureCallback;
//   final void Function(TResult? result)? onAfterPopDialog;
//   final void Function(String message)? onVersionInvalid;
//   final void Function(DataResult<VersionResponseModel> versionModel)? onResultFound;
//   final VersionDialogService dialogService;
//   final TResult? popVersionDialogResult;

//   final Widget child;
//   final Widget? errorPage;
//   final Widget? outOfDateVersionPage;
//   final Widget? getVersionErrorDialogContent;
//   final Widget? loadingWidget;
//   final CheckVersionLoadingType loadingType;
//   final bool isChildExpandedInStack;
//   final bool isLoadingTextVisible;
//   final bool isDismissibleWhenGetDataError;
//   final bool isUpdateRequired;
//   final bool isCancelActionVisible;
//   final double loadingWidgetSize;
//   final double spaceAroundChild;
//   final String? loadingText;

//   @override
//   State<VersionCompareWrapper<TResult>> createState() => _VersionCompareWrapperState<TResult>();
// }

// class _VersionCompareWrapperState<TResult> extends State<VersionCompareWrapper<TResult>>
//     with _VersionCompareWrapperStateMixin<TResult>, VersionResultValidatorMixin {
//   @override
//   Widget build(BuildContext context) {
//     if (_isOutOfDate && widget.outOfDateVersionPage != null) {
//       return widget.outOfDateVersionPage!;
//     } else if (_isError && widget.errorPage != null) {
//       return widget.errorPage!;
//     }

//     return _isLoading ? _buildLoadingBodyByType() : widget.child;
//   }

//   Widget _buildLoadingBodyByType() {
//     return widget.loadingType == CheckVersionLoadingType.alertDialog ? _buildAlertLoading() : _buildLoading();
//   }

//   Widget _buildAlertLoading() {
//     return Stack(
//       children: [
//         widget.isChildExpandedInStack ? Expanded(child: widget.child) : widget.child,
//         CheckVersionProgressDialog(
//           customLoading: widget.loadingWidget,
//           loadingWidgetSize: widget.loadingWidgetSize,
//           loadingText: widget.loadingText,
//           isTextVisible: widget.isLoadingTextVisible,
//         ),
//       ],
//     );
//   }

//   Widget _buildLoading() {
//     return widget.loadingWidget ??
//         DefaultCheckVersionProgress(
//           isLoadingTextVisible: widget.isLoadingTextVisible,
//           loadingWidgetSize: widget.loadingWidgetSize,
//           spaceAroundChild: widget.spaceAroundChild,
//           loadingText: widget.loadingText,
//           loadingWidget: widget.loadingWidget,
//         );
//   }
// }

// mixin _VersionCompareWrapperStateMixin<TResult> on State<VersionCompareWrapper<TResult>>
//     implements VersionResultValidatorMixin {
//   bool _isLoading = true;
//   bool _isError = false;
//   bool _isOutOfDate = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() async => await _startVersionComparator());
//   }

//   Future<void> _startVersionComparator() async {
//     final result = await _getVersionByValidation();

//     if (result.isNotSuccess) {
//       widget.errorPage == null ? await _showInvalidVersionAlert(result) : _setError(true);
//       widget.onVersionInvalid?.call(result.message);
//     } else if (result.data?.isAppVersionOld ?? false) {
//       if (!mounted) return;
//       _setOutOfDateVersion(true);
//       widget.onResultFound?.call(result);
//       await _showOldVersionAlert(result);
//     } else {
//       widget.onResultFound?.call(result);
//     }
//   }

//   Future<DataResult<VersionResponseModel>> _getVersionByValidation() async {
//     _setLoading(true);
//     final result = await widget.futureCallback.call();
//     final versionValidationResult = isVersionResultValid(result);
//     _setLoading(false);

//     return DataResult<VersionResponseModel>(
//       isSuccess: versionValidationResult.isSuccess,
//       message: versionValidationResult.message,
//       data: result.data,
//     );
//   }

//   Future<void> _showInvalidVersionAlert(DataResult<VersionResponseModel> result) async {
//     if (!mounted) return;
//     final alertResult = await widget.dialogService.showCustomVersionDialog<TResult>(
//       context: context,
//       isDismissible: false,
//       dialog: widget.getVersionErrorDialogContent ??
//           VersionResultErrorDialogContent(
//             content: result.message,
//             onPressed: () {
//               widget.onVersionInvalid?.call(result.message);
//               Navigator.of(context).pop<TResult>(widget.popVersionDialogResult);
//             },
//           ),
//     );

//     widget.onAfterPopDialog?.call(alertResult);
//   }

//   Future<void> _showOldVersionAlert(DataResult<VersionResponseModel> result) async {
//     if (!mounted) return;
//     final alertResult = await widget.dialogService.showVersionDialog<TResult>(
//       context: context,
//       versionModel: result.data!,
//       isUpdateRequired: widget.isUpdateRequired,
//       isCancelActionVisible: widget.isCancelActionVisible,
//       popResult: widget.popVersionDialogResult,
//     );

//     widget.onAfterPopDialog?.call(alertResult);
//   }

//   void _setLoading(bool value) {
//     setState(() {
//       _isLoading = value;
//     });
//   }

//   void _setError(bool isError) {
//     setState(() {
//       _isError = isError;
//     });
//   }

//   void _setOutOfDateVersion(bool value) {
//     setState(() {
//       _isOutOfDate = value;
//     });
//   }
// }
