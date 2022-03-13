import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultSpinCircleLoader extends StatefulWidget {
  final double size;
  final String type;
  final Color color;
  DefaultSpinCircleLoader({this.size = 50, this.type = 'ripple', this.color = Colors.redAccent});
  @override
  State<DefaultSpinCircleLoader> createState() => _DefaultSpinCircleLoaderState();
}

class _DefaultSpinCircleLoaderState extends State<DefaultSpinCircleLoader> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Widget loader = Center(child: SizedBox(
      child: CircularProgressIndicator(color: widget.color),
      height: 20,
      width: 20,
    ),);
    return Platform.isIOS ? const Center(child: CupertinoActivityIndicator()) : loader;
  }
}
