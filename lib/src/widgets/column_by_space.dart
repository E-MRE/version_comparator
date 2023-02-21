import 'package:flutter/material.dart';

class ColumnBySpace extends StatelessWidget {
  const ColumnBySpace({
    Key? key,
    required this.children,
    required this.space,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  }) : super(key: key);

  final List<Widget> children;
  final Widget space;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    if (children.isEmpty) return [];
    final list = <Widget>[space];

    for (var item in children) {
      list.add(item);
      list.add(space);
    }

    return list;
  }
}
