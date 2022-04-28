import 'package:flutter/material.dart';
import 'package:todos/streams/todo_controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Todos(),
    );
  }
}

class Todos extends StatelessWidget {
  final todoController = Injector<TodoController>().put(TodoController());
  final textEditingController = TextEditingController();

  Todos({Key? key}) : super(key: key);

  void addTodo() {
    final text = textEditingController.text;
    if (text.isEmpty) return;
    todoController.add(Todo.initialize(text: text));
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: null,
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextButton(
                onPressed: addTodo,
                child: const Text('Save'),
              ),
            ],
          ),
          const Divider(height: 2, color: Colors.deepPurple),
          Expanded(
            child: StateBuilder<TodoController, List<Todo>>(
              controller: todoController,
              builder: (context, todos) {
                return ListView(
                  children: todos.map((todo) => TodoCard(todo: todo)).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Todo todo;
  final todoController = Injector<TodoController>().put(TodoController());
  final textController = TextEditingController();
  TodoCard({required this.todo, Key? key}) : super(key: key);

  void markComplete(bool? isChecked) {
    todoController.update(todo.copyWith(isCompleted: !todo.isCompleted));
  }

  void removeTodo() {
    todoController.remove(todo);
  }

  void updateTodo(BuildContext context) {
    final text = textController.text;
    if (text.isEmpty) return;
    todoController.update(todo.copyWith(text: text));
    Navigator.of(context).pop();
  }

  void editTodo(BuildContext context) {
    textController.text = todo.text;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit'),
        content: TextField(controller: textController, maxLines: null),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => updateTodo(context),
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hexCode = int.parse('0xff${todo.id.substring(0, 6)}');
    return Container(
      color: Color(hexCode).withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Checkbox(value: todo.isCompleted, onChanged: markComplete),
          Expanded(
            child: Text(
              todo.text,
              style: TextStyle(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () => editTodo(context),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: removeTodo,
            icon: const Icon(Icons.delete_outlined),
          ),
        ],
      ),
    );
  }
}
