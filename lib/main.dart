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
        //todo 2
        ChangeNotifierProvider<TodoFilter>(
          create: (_) => TodoFilter(),
        ),
        //todo 3
        ChangeNotifierProvider<TodoList>(
          create: (_) => TodoList(),
        ),
        //todo 4
        ChangeNotifierProvider<TodoSearch>(
          create: (_) => TodoSearch(),
        ),
        //todo 5
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(),
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? activeTodoCount,
          ) =>
              activeTodoCount!..update(todoList),
        ),
        //todo 6 (finish)
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          create: (context) => FilteredTodos(),
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
