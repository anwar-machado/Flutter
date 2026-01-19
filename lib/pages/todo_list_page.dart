import 'package:flutter/material.dart';
import 'package:projects/repositories/todo_repository.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoListPage(), debugShowCheckedModeBanner: false);
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  // Stores the Task Content so it can be added to the list of tasks
  final TextEditingController taskController = TextEditingController();

  final TodoRepository todoRepository = TodoRepository();

  List<Todo> tasks = [];

  Todo? deletedTodo;
  int? deletedTodoIndex;

  String? errorText;

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Add a Task',
                          hintText: 'Ex: Feed the cat',
                          errorText: errorText,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = taskController.text;


                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        backgroundColor: Colors.blue,
                        elevation: 3,
                      ),
                      child: IconButton(
                        onPressed: () {
                          String text = taskController.text;

                          setState(() {
                            if(text.isEmpty) {
                              setState(() {
                                errorText = 'Task Description Cannot be Null!';
                              });
                              return;
                            }
                            Todo newTodo = Todo(
                              title: text,
                              dateTime: DateTime.now(),
                            );
                              tasks.add(newTodo);
                              todoRepository.saveTodoList(tasks);
                              errorText = null;
                          });

                          // Cleans the TextField once it's pressed
                          taskController.clear();
                        },
                        icon: Icon(Icons.add, size: 27, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in tasks)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                          onEdit: onEdit,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('You have ${tasks.length} tasks pending'),
                    ),
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        backgroundColor: Colors.blue,
                        elevation: 3
                      ),
                      child: Text(
                        'Clean Tasks',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoIndex = tasks.indexOf(todo);

    setState(() {
      // It removes the todo sent by the parameter
      tasks.remove(todo);
    });
    todoRepository.saveTodoList(tasks);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[400],
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              tasks.insert(deletedTodoIndex!, deletedTodo!);
            });
          },
        ),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clean Everything?'),
        content: Text('Are you sure that you want to delete all the tasks?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Clear Everything'),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      tasks.clear();
    });
    todoRepository.saveTodoList(tasks);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cleared!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[400],
      ),
    );
  }

  void onEdit(Todo todo) {
    final todoTitleController = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        actions: [
          TextField(controller: todoTitleController),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (todoTitleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'The new content cannot be empty',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),

                      );
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      todo.title = todoTitleController.text;
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Edited Successfully!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: Colors.blue[400],
                        ),
                      );
                    }
                  });
                },
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
