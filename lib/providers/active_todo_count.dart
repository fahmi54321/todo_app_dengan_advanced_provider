import 'package:equatable/equatable.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';
import 'package:todo_app_dengan_advanced_provider/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState({
    required this.activeTodoCount,
  });

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

//todo 2 (hapus ini)

// class ActiveTodoCount with ChangeNotifier {
//   late ActiveTodoCountState _state;
//   final int initialActiveTodoCount;

//   ActiveTodoCount({required this.initialActiveTodoCount}) {
//     _state = ActiveTodoCountState(
//       activeTodoCount: initialActiveTodoCount,
//     );
//   }
//   ActiveTodoCountState get state => _state;

//   void update(TodoList todoList) {
//     print(todoList.state);
//     final int newActiveTodoCount = todoList.state.todos
//         .where((Todo todo) => !todo.completed)
//         .toList()
//         .length;

//     _state = _state.copyWith(
//       activeTodoCount: newActiveTodoCount,
//     );
//     print(state);
//     notifyListeners();
//   }
// }

//todo 3 ganti dengan (next filtered_todos)
class ActiveTodoCount {
  final TodoList todoList;
  ActiveTodoCount({
    required this.todoList,
  });

  ActiveTodoCountState get state => ActiveTodoCountState(
        activeTodoCount: todoList.state.todos
            .where((Todo todo) => !todo.completed)
            .toList()
            .length,
      );
}
