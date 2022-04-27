import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/bloc/todos_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(),
      child: MaterialApp(
        title: 'Todos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: TodosPage(),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Color? color;
  final Todo todo;

  TodoCard({required this.todo, this.color, key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  deleteTodo(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    bloc.add(TodoEvent(Type.remove, todo));
  }

  editTodo(BuildContext context) {
    controller.text = todo.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit'),
          content: TextField(controller: controller, maxLines: null),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => updateTodo(context),
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  updateTodo(BuildContext context) {
    if (controller.text.isEmpty) return;
    final bloc = context.read<TodoBloc>();
    bloc.add(TodoEvent(Type.update, todo.copyWith(text: controller.text)));
    Navigator.pop(context);
  }

  completeTodo(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    bloc.add(
      TodoEvent(Type.update, todo.copyWith(isCompleted: !todo.isCompleted)),
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
          Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => completeTodo(context),
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
            onPressed: () => editTodo(context),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () => deleteTodo(context),
            icon: const Icon(Icons.delete_outlined),
          ),
        ],
      ),
    );
  }
}

class TodosPage extends StatelessWidget {
  static const routeName = '/todos';
  TodosPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  void addTodo(BuildContext context) {
    if (controller.text.isEmpty) return;
    final TodoBloc bloc = context.read<TodoBloc>();
    final Todo todo = Todo.initialize(text: controller.text);
    bloc.add(TodoEvent(Type.add, todo));
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, todos) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      controller: controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => addTodo(context),
                    child: const Text('Save'),
                  )
                ],
              ),
              const Divider(height: 2, color: Colors.deepPurple),
              Expanded(
                child: ListView(
                  children: todos.map((todo) => TodoCard(todo: todo)).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
