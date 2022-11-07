import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_dengan_advanced_provider/pages/todos_page.dart';
import 'package:todo_app_dengan_advanced_provider/providers/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (_) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (_) => TodoList(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (_) => TodoSearch(),
        ),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(
            initialActiveTodoCount:
                context.read<TodoList>().state.todos.length, //todo 7
          ),
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? activeTodoCount,
          ) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          create: (context) => FilteredTodos(
            initialTodoList:
                context.read<TodoList>().state.todos, //todo 8 (finish)
          ),
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? filteredTodos,
          ) =>
              filteredTodos!
                ..update(
                  todoFilter: todoFilter,
                  todoSearch: todoSearch,
                  todoList: todoList,
                ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodosPage(),
      ),
    );
  }
}
