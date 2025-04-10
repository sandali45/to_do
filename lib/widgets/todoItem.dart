import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function onclick;
  final Function onDelete;
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onclick,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 2, 40, 71),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: () {
          onclick();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.transparent, // Set tileColor to transparent
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.white,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            color: Colors.white,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            onDelete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
