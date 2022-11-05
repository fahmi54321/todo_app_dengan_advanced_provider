import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount; //todo 1

  //todo 2
  const ActiveTodoCountState({
    required this.activeTodoCount,
  });

  //todo 6 init awal
  factory ActiveTodoCountState.initial() {
    return const ActiveTodoCountState(
      activeTodoCount: 0,
    );
  }

  //todo 3 equatable
  @override
  List<Object?> get props => [activeTodoCount];

  // todo 4 toString
  @override
  bool get stringify => true;

  //todo 5 copyWith
  ActiveTodoCountState copyWith({
    required int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

//todo 7
class ActiveTodoCount with ChangeNotifier {
  //todo 8
  ActiveTodoCountState _state = ActiveTodoCountState.initial();
  ActiveTodoCountState get state => _state;

  //todo 9 (finish)
  void update(TodoList todoList) {
    final int newActiveTodoCount = todoList.state.todos
        .where((Todo todo) => !todo.completed)
        .toList()
        .length;

    _state = _state.copyWith(
      activeTodoCount: newActiveTodoCount,
    );
    notifyListeners();
  }
}
