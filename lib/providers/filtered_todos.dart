import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_filter.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_list.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos; //todo 1

  //todo 2
  FilteredTodosState({
    required this.filteredTodos,
  });

  //todo 6
  factory FilteredTodosState.initial() {
    return FilteredTodosState(
      filteredTodos: const [],
    );
  }

  //todo 3 equatable
  @override
  List<Object?> get props => [];

  //todo 4 toString
  @override
  bool get stringify => true;

  //todo 5 copyWith
  FilteredTodosState copyWith({required List<Todo>? filteredTodos}) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

//todo 7
class FilteredTodos with ChangeNotifier {
  //todo 8
  FilteredTodosState _state = FilteredTodosState.initial();
  FilteredTodosState get state => _state;

  //todo 9 (finish)
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
