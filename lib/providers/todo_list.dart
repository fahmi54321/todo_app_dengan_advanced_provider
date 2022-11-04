import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';

class TodoListState extends Equatable {
  final List<Todo> todos; //todo 1

  //todo 2
  TodoListState({
    required this.todos,
  });

  // todo 6 init awal
  factory TodoListState.initial() {
    return TodoListState(
      todos: [
        Todo(id: '1', desc: 'Clean the room'),
        Todo(id: '2', desc: 'Wash the dish'),
        Todo(id: '3', desc: 'Do homework'),
      ],
    );
  }

  // todo 3 equatable
  @override
  List<Object?> get props => [todos];

  // todo 4 toString
  @override
  bool get stringify => true;

  // todo 5 copyWith
  TodoListState copyWith({List<Todo>? todos}) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

//todo 7
class TodoList with ChangeNotifier {
  //todo 8
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;

  // todo 9
  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  //todo 10 (finish)
  void editTodo(String id, String todoDesc) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
