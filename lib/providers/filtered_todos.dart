import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_filter.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_list.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;

  FilteredTodosState({
    required this.filteredTodos,
  });

  //todo 4 remove initial ini
  // factory FilteredTodosState.initial() {
  //   return FilteredTodosState(
  //     filteredTodos: const [],
  //   );
  // }

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({required List<Todo>? filteredTodos}) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos with ChangeNotifier {
  //todo 5
  late FilteredTodosState _state;
  final List<Todo> initialTodoList;

  //todo 6 (next main.dart)
  FilteredTodos({
    required this.initialTodoList,
  }) {
    _state = FilteredTodosState(
      filteredTodos: initialTodoList,
    );
  }
  FilteredTodosState get state => _state;

  void update({
    required TodoFilter todoFilter,
    required TodoSearch todoSearch,
    required TodoList todoList,
  }) {
    List<Todo> _filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        {
          _filteredTodos = todoList.state.todos
              .where((Todo todo) => !todo.completed)
              .toList();
        }
        break;
      case Filter.completed:
        {
          _filteredTodos = todoList.state.todos
              .where((Todo todo) => todo.completed)
              .toList();
        }
        break;
      default:
        {
          _filteredTodos = todoList.state.todos;
        }

        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where(
            (Todo todo) => todo.desc.toLowerCase().contains(
                  todoSearch.state.searchTerm,
                ),
          )
          .toList();
    }

    _state = _state.copyWith(filteredTodos: _filteredTodos);
    notifyListeners();
  }
}
