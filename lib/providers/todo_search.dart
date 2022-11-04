import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';

class TodoSearchState extends Equatable {
  final String searchTerm; //todo 1

  //todo 2
  TodoSearchState({
    required this.searchTerm,
  });

  // todo 6 init awal
  factory TodoSearchState.initial() {
    return TodoSearchState(searchTerm: '');
  }

  // todo 3 equatable
  @override
  List<Object?> get props => [searchTerm];

  // todo 4 toString
  @override
  bool get stringify => true;

  // todo 5 copyWith
  TodoSearchState copyWith({String? searchTerm}) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

//todo 7
class TodoSearch with ChangeNotifier {
  //todo 8
  TodoSearchState _state = TodoSearchState.initial();
  TodoSearchState get state => _state;

  // todo 9 (finish)
  void setSearchTerm(String newSearchTerm) {
    _state = _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners();
  }
}
