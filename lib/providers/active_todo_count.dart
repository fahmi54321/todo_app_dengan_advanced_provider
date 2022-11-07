import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState({
    required this.activeTodoCount,
  });

  //todo 1 remove initial ini
  // factory ActiveTodoCountState.initial() {
  //   return const ActiveTodoCountState(
  //     activeTodoCount: 0,
  //   );
  // }

  @override
  List<Object?> get props => [activeTodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCountState copyWith({
    required int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount with ChangeNotifier {
  //todo 2
  late ActiveTodoCountState _state;
  final int initialActiveTodoCount;

  //todo 3 (next filtered_todos) inital
  ActiveTodoCount({required this.initialActiveTodoCount}) {
    _state = ActiveTodoCountState(
      activeTodoCount: initialActiveTodoCount,
    );
  }
  ActiveTodoCountState get state => _state;

  void update(TodoList todoList) {
    print(todoList.state);
    final int newActiveTodoCount = todoList.state.todos
        .where((Todo todo) => !todo.completed)
        .toList()
        .length;

    _state = _state.copyWith(
      activeTodoCount: newActiveTodoCount,
    );
    print(state);
    notifyListeners();
  }
}
