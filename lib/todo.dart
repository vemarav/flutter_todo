import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo extends Equatable {
  final String id;
  final String text;
  final bool isCompleted;

  const Todo({required this.id, required this.text, required this.isCompleted});

  factory Todo.initialize({required String text}) {
    return Todo(id: uuid.v1(), text: text, isCompleted: false);
  }

  @override
  List<Object?> get props => [id];

  Todo copyWith({String? id, String? text, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
