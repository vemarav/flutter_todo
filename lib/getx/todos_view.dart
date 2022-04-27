import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/getx/todo_controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todos',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: Todos(),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Color? color;
  final Todo todo;

  TodoCard({required this.todo, this.color, key}) : super(key: key);
  final todoController = Get.put(TodoController());
  final TextEditingController controller = TextEditingController();

  deleteTodo() {
    todoController.todos.remove(todo);
  }

  editTodo() {
    controller.text = todo.text;
    Get.dialog(
      AlertDialog(
        title: const Text('Edit'),
        content: TextField(controller: controller, maxLines: null),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => updateTodo(),
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  updateTodo() {
    if (controller.text.isEmpty) return;
    todoController.modity(todo.copyWith(text: controller.text));
    Get.back();
  }

  completeTodo(_) {
    todoController.modity(todo.copyWith(isCompleted: !todo.isCompleted));
  }

  @override
  Widget build(BuildContext context) {
    final hexCode = int.parse('0xff${todo.id.substring(0, 6)}');
    return Container(
      color: Color(hexCode).withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: todo.isCompleted,
            onChanged: completeTodo,
          ),
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
            onPressed: editTodo,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: deleteTodo,
            icon: const Icon(Icons.delete_outlined),
          ),
        ],
      ),
    );
  }
}

class Todos extends StatelessWidget {
  Todos({Key? key}) : super(key: key);

  final todoController = Get.put(TodoController());
  final textEditingController = TextEditingController();

  void addTodo() {
    if (textEditingController.text.isEmpty) return;
    final todo = Todo.initialize(text: textEditingController.text);
    todoController.add(todo);
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
              )
            ],
          ),
          const Divider(height: 2, color: Colors.deepPurple),
          Expanded(
            child: Obx(
              () => ListView(
                children: todoController.todos
                    .map((todo) => TodoCard(todo: todo))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
