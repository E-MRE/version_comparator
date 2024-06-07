import 'package:flutter/material.dart';

import '../../models/version_response_model.dart';
import '../../utils/constants/constants.dart';
import '../abstracts/version_dialog_service.dart';

class VersionDialogManager extends VersionDialogService {
  @override
  Future<T?> showCustomVersionDialog<T>({
    required BuildContext context,
    required Widget dialog,
    bool isDismissible = true,
  }) async {
    return await showDialog<T>(
        context: context,
        barrierDismissible: isDismissible,
        builder: (_) => dialog);
  }

  @override
  Future<T?> showCustomContentVersionDialog<T>({
    required BuildContext context,
    required VersionResponseModel versionModel,
    required Widget content,
    T? popResult,
    bool isUpdateRequired = false,
    bool isCancelActionVisible = true,
    VoidCallback? onAfterPopDialog,
  }) async {
    return await showVersionDialog<T>(
      context: context,
      content: content,
      popResult: popResult,
      versionModel: versionModel,
      title: const SizedBox.shrink(),
      isUpdateRequired: isUpdateRequired,
      onAfterPopDialog: onAfterPopDialog,
      isCancelActionVisible: isCancelActionVisible,
    );
  }

  @override
  Future<T?> showVersionDialog<T>({
    required BuildContext context,
    required VersionResponseModel versionModel,
    bool isUpdateRequired = false,
    bool isCancelActionVisible = true,
    VoidCallback? onAfterPopDialog,
    T? popResult,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
  }) async {
    return await showDialog<T>(
      context: context,
      barrierDismissible: !isUpdateRequired,
      builder: (_) {
        return AlertDialog(
          title: title ?? _buildTitle(isUpdateRequired),
          content: content ?? _buildContent(isUpdateRequired, versionModel),
          actions: actions ??
              _buildActions<T>(
                context: context,
                versionModel: versionModel,
                isUpdateRequired: isUpdateRequired,
                isCancelActionVisible: isCancelActionVisible,
                onAfterPopDialog: onAfterPopDialog,
                popResult: popResult,
              ),
        );
      },
    );
  }

  Widget _buildTitle(bool isUpdateRequired) {
    return Text(isUpdateRequired
        ? kInfoMessage.requiredVersionDialogTitle
        : kInfoMessage.versionDialogTitle);
  }

  Widget _buildContent(
      bool isUpdateRequired, VersionResponseModel versionModel) {
    return Text(
      isUpdateRequired
          ? kInfoMessage.requiredVersionDialogContent(
              versionModel.localVersion, versionModel.storeVersion)
          : kInfoMessage.versionDialogContent(
              versionModel.localVersion, versionModel.storeVersion),
    );
  }

  List<Widget> _buildActions<T>({
    required BuildContext context,
    required VersionResponseModel versionModel,
    required bool isUpdateRequired,
    required bool isCancelActionVisible,
    VoidCallback? onAfterPopDialog,
    T? popResult,
  }) {
    return [
      if (!isUpdateRequired && isCancelActionVisible)
        _buildCancelButton<T>(context, onAfterPopDialog, popResult),
      _buildUpdateButton<T>(
          context, versionModel, onAfterPopDialog, isUpdateRequired, popResult),
    ];
  }

  Widget _buildCancelButton<T>(
      BuildContext context, VoidCallback? onAfterPopDialog, T? popResult) {
    return TextButton(
      onPressed: () => _onCancelTap<T>(context, onAfterPopDialog, popResult),
      child: Text(kInfoMessage.versionDialogCancelAction),
    );
  }

  Widget _buildUpdateButton<T>(
    BuildContext context,
    VersionResponseModel versionModel,
    VoidCallback? onAfterPopDialog,
    bool isUpdateRequired,
    T? popResult,
  ) {
    return TextButton(
      child: Text(kInfoMessage.versionDialogUpdateAction),
      onPressed: () async => await _onUpdateTap<T>(
        context: context,
        updateLink: versionModel.updateLink,
        isUpdateRequired: isUpdateRequired,
        popResult: popResult,
        onAfterPopDialog: onAfterPopDialog,
      ),
    );
  }

  Future<void> _onUpdateTap<T>({
    required BuildContext context,
    required String updateLink,
    required bool isUpdateRequired,
    VoidCallback? onAfterPopDialog,
    T? popResult,
  }) async {
    await launchStoreLink(updateLink);
    if (context.mounted && !isUpdateRequired) {
      Navigator.of(context).pop<T>(popResult);
      onAfterPopDialog?.call();
    }
  }

  void _onCancelTap<T>(
      BuildContext context, VoidCallback? onAfterPopDialog, T? popResult) {
    Navigator.of(context).pop<T>(popResult);
    onAfterPopDialog?.call();
  }
}
