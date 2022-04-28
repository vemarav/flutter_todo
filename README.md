# Todos

This repo contains same UI and different state management techniques (without using StatefulWidget) to compare and prefer based on your coding style.

<br>

> I respect the authors third-party packages used to build this repo. Special thanks to authors of [flutter_bloc](https://pub.dev/packages/flutter_bloc) and [GetX](https://pub.dev/packages/get) from where I learn a lot of flutter stuff

<br>

👩‍💻 Keep Rocking, While Coding 👨‍💻

<br>

Todos | Edit Todo
---|---
![Todos](https://user-images.githubusercontent.com/17309962/165767376-00c32cab-f0de-4785-9756-3c42ce45b74a.png) | ![todo_edit](https://user-images.githubusercontent.com/17309962/165767492-95fadba2-1f3d-45e3-9765-b5ac9a0ca5cd.png)

Project Structure
--
```
lib
├── bloc
│   ├── todos_bloc.dart
│   └── todos_view.dart
├── getx
│   ├── todo_controller.dart
│   └── todos_view.dart
├── main.dart
├── streams
│   ├── todo_controller.dart
│   ├── todo_stream.dart
│   ├── todo_stream_flutter.dart
│   └── todo_view.dart
└── todo.dart
```

<br>

Usage
--

Import one of `todo_view.dart` to `main.dart` and it will just work.

```dart
// import 'package:todos/bloc/todos_view.dart';
// import 'package:todos/getx/todos_view.dart';
import 'package:todos/streams/todo_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

```

1. [State management using BLoC](https://github.com/vemarav/flutter_todo/tree/main/lib/bloc)
2. [State management using Get](https://github.com/vemarav/flutter_todo/tree/main/lib/getx)
2. [State management using dart:async#Stream](https://github.com/vemarav/flutter_todo/tree/main/lib/streams)