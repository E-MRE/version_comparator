part of '../../widgets/custom_version_comparator_view.dart';

mixin _CustomVersionComparatorViewStateMixin<TResult> on State<CustomVersionComparatorView<TResult>>
    implements VersionResultValidatorMixin {
  late VersionComparatorState _state;

  @override
  void initState() {
    super.initState();
    _state = const VersionComparatorInitialState();
    Future.microtask(() async => await _startVersionComparator());
  }

  Future<void> _startVersionComparator() async {
    final result = await _getVersionByValidation();

    if (result.isNotSuccess || result.data == null) {
      _setState(VersionComparatorErrorState(message: result.message, isOldVersionError: false));
      if (widget.errorPageBuilder == null) await _showInvalidVersionAlert(result);
      widget.onCompareError?.call(result.message);
    } else if (result.data?.isAppVersionOld ?? false) {
      if (!mounted) return;
      _setState(VersionComparatorErrorState(
        message: _getOutOfDateMessage(result.data!),
        data: result.data,
        isOldVersionError: true,
      ));
      widget.onOutOfDateVersionError?.call(_getOutOfDateMessage(result.data!), result.data!);
      await _showOldVersionAlert(result);
    } else {
      widget.onCompareSuccess?.call(result.data!);
      _setState(VersionComparatorSuccessState(result.data!));
    }
  }

  Future<DataResult<VersionResponseModel>> _getVersionByValidation() async {
    _setState(const VersionComparatorLoadingState());
    final result = await widget.onVersionCompareCallback.call();
    final versionValidationResult = isVersionResultValid(result);

    return DataResult<VersionResponseModel>(
      isSuccess: versionValidationResult.isSuccess,
      message: versionValidationResult.message,
      data: result.data,
    );
  }

  Future<void> _showInvalidVersionAlert(DataResult<VersionResponseModel> result) async {
    if (!mounted) return;
    final alertResult = await widget.dialogService?.showCustomVersionDialog<TResult>(
      context: context,
      isDismissible: false,
      dialog: widget.invalidVersionDialogContentBuilder?.call(context, result.message) ??
          VersionResultErrorDialogContent(
            content: result.message,
            onPressed: () {
              widget.onCompareError?.call(result.message);
              Navigator.of(context).pop<TResult>(widget.popVersionDialogResult);
            },
          ),
    );

    widget.onAfterPopDialog?.call(alertResult);
  }

  Future<void> _showOldVersionAlert(DataResult<VersionResponseModel> result) async {
    if (!mounted) return;
    final alertResult = await widget.dialogService?.showVersionDialog<TResult>(
      context: context,
      versionModel: result.data!,
      isUpdateRequired: widget.isUpdateRequired,
      isCancelActionVisible: widget.isCancelActionVisible,
      popResult: widget.popVersionDialogResult,
    );

    widget.onAfterPopDialog?.call(alertResult);
  }

  void _setState(VersionComparatorState state) {
    setState(() {
      _state = state;
    });

    widget.onStateChanged?.call(state);
  }

  String _getOutOfDateMessage(VersionResponseModel versionModel) => widget.isUpdateRequired
      ? kInfoMessage.requiredVersionDialogContent(versionModel.localVersion, versionModel.storeVersion)
      : kInfoMessage.versionDialogContent(versionModel.localVersion, versionModel.storeVersion);
}
