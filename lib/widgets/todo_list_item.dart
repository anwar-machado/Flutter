import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, required this.todo, required this.onDelete, required this.onEdit});

  final Todo todo;
  final Function(Todo) onDelete;
  final Function(Todo) onEdit;

  @override
  Widget build(BuildContext context) {
    // Main Layout
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),

      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          // How much space the Slidable Icons will occupy
          extentRatio: 0.5,
          // Each Icon of the slidable
          children: [
            SlidableAction(
              // The (context) was necessary because without it, the todo_list_item would run the function
              // Not letting every widget setup, causing an error
              onPressed: (context) => onDelete(todo),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) => onEdit(todo),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          alignment: AlignmentDirectional.bottomStart,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue[50],
            border: BoxBorder.all(color: Colors.blue),
          ),
          margin: const EdgeInsets.all(1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy - HH:mm').format(todo.dateTime),
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  todo.title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),

              ],
            ),
          ),
          
        ),
      ),
    );
  }
}
