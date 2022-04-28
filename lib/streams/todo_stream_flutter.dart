import 'package:flutter/material.dart';
import 'todo_stream.dart';

export 'todo_stream.dart';

/* ------------- StateBuilder ----------- */
class StateBuilder<T extends StateController, S> extends StatelessWidget {
  final T controller;
  final Widget Function(BuildContext context, S controller) builder;

  const StateBuilder({
    required this.controller,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          builder(context, controller.state),
    );
  }
}
