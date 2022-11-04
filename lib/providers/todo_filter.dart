import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';

class TodoFilterState extends Equatable {
  final Filter filter; //todo 1

  //todo 2
  TodoFilterState({
    required this.filter,
  });

  // todo 6 init awal
  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  // todo 3 equatable
  @override
  List<Object?> get props => [filter];

  // todo 4 toString
  @override
  bool get stringify => true;

  // todo 5 copyWith
  TodoFilterState copyWith({Filter? filter}) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

//todo 7
class TodoFilter with ChangeNotifier {
  //todo 8
  TodoFilterState _state = TodoFilterState.initial();
  TodoFilterState get state => _state;

  // todo 9 (finish)
  void changeFilter(Filter newFilter) {
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}
