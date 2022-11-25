import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_bloc/base/bloc.dart';

class BaseBlocProvider<T extends BaseBloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BaseBlocProvider({super.key, required this.bloc, required this.child});

  static T of<T extends BaseBloc>(BuildContext context) {
    final BaseBlocProvider<T> provider =
        context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }

  @override
  State<BaseBlocProvider> createState() => _BaseBlocProviderState();
}

class _BaseBlocProviderState extends State<BaseBlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
