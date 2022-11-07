import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_dengan_advanced_provider/models/todo_models.dart';
import 'package:todo_app_dengan_advanced_provider/providers/provider.dart';
import 'package:todo_app_dengan_advanced_provider/utils/debounce.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 40.0,
            ),
            child: Column(
              children: [
                TodoHeader(),
                CreateTodo(),
                const SizedBox(height: 20.0),
                SearchAndFilterTodo(),
                ShowTodos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          '${context.watch<ActiveTodoCount>().state.activeTodoCount} items left',
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoController,
      decoration: const InputDecoration(labelText: 'what to do ?'),
      onSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc.trim().isNotEmpty) {
          context.read<TodoList>().addTodo(todoDesc);
          newTodoController.clear();
        }
      },
    );
  }
}

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({Key? key}) : super(key: key);

  //todo 2
  final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              //todo 3 (finish)
              debounce.run(() {
                context.read<TodoSearch>().setSearchTerm(newSearchTerm);
              });
            }
          },
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButon(context, Filter.all),
            filterButon(context, Filter.active),
            filterButon(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  Widget filterButon(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilter>().changeFilter(filter);
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          fontSize: 18.0,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilter>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodos>().state.filteredTodos; //todo 1

    Widget showBackground(int direction) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.red,
        alignment:
            direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 30.0,
          color: Colors.white,
        ),
      );
    }

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          key: ValueKey(todos[index].id),
          onDismissed: (_) {
            context.read<TodoList>().removeTodo(
                  //todo 2
                  todos[index],
                );
          },
          confirmDismiss: (_) {
            return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure'),
                    content: const Text('Do you really want to delete'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('NO'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('YES'),
                      ),
                    ],
                  );
                });
          },
          child: TodoItem(
            todo: todos[index],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemCount: todos.length,
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool error = false;
              textEditingController.text = widget.todo.desc;

              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: const Text('Edit Todo'),
                    content: TextField(
                      controller: textEditingController,
                      autofocus: true,
                      decoration: InputDecoration(
                        errorText: error ? 'Value cannot be empty' : null,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            error = textEditingController.text.isEmpty
                                ? true
                                : false;

                            if (!error) {
                              //todo 3
                              context.read<TodoList>().editTodo(
                                    widget.todo.id,
                                    textEditingController.text,
                                  );
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: const Text('EDIT'),
                      ),
                    ],
                  );
                },
              );
            });
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          //todo 4 (finish)
          context.read<TodoList>().toggleTodo(
                widget.todo.id,
              );
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
