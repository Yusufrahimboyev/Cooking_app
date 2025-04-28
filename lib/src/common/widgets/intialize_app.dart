import 'package:flutter/material.dart';

import '../dependency/dependency.dart';

class MyAppScope extends StatefulWidget {
  const MyAppScope({super.key, required this.child, required this.dependency});

  final Widget child;

  final AppDepenency dependency;

  @override
  State<MyAppScope> createState() => _MyAppScopeState();
}

class _MyAppScopeState extends State<MyAppScope> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
