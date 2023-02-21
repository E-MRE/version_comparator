import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class VersionResultErrorDialogContent extends StatelessWidget {
  const VersionResultErrorDialogContent({super.key, required this.content, required this.onPressed});

  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(kInfoMessage.checkVersionErrorDialogTitle),
      content: Text(content),
      actions: [TextButton(onPressed: onPressed, child: Text(kInfoMessage.checkVersionOkAction))],
    );
  }
}
