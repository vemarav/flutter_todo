import 'package:todos/streams/todo_stream_flutter.dart';
import 'package:todos/todo.dart';

export 'package:todos/todo.dart';
export 'package:todos/streams/todo_stream_flutter.dart';

class TodoController extends StateController<List<Todo>> {
  TodoController() : super(List<Todo>.from([]));

  add(Todo todo) => emit([todo, ...state]);

  remove(Todo todo) {
    final todos = state;
    if (todos.remove(todo)) {
      emit(todos);
    }
  }

  update(Todo todo) {
    final index = state.indexOf(todo);
    state[index] = todo;
    emit(state);
  }
}
