import 'package:get/get.dart';
import 'package:todos/todo.dart';

export 'package:todos/todo.dart';

class TodoController extends GetxController {
  List<Todo> todos = List<Todo>.from([]).obs;

  add(Todo todo) => todos.add(todo);
  remove(Todo todo) => todos.remove(todo);
  modity(Todo todo) {
    int index = todos.indexOf(todo);
    todos[index] = todo;
  }
}
