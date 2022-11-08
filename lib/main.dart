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
        //todo 6
        ProxyProvider<TodoList, ActiveTodoCount>(
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? _,
          ) =>
              ActiveTodoCount(todoList: todoList),
        ),
        //todo 7 (finish)
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? _,
          ) =>
              FilteredTodos(
            todoFilter: todoFilter,
            todoList: todoList,
            todoSearch: todoSearch,
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
