import 'package:flutter/material.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/widgets/todoItem.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todos = Todo.toDoList();
  List<Todo> _searchToDo = [];
  final todoTextInput = TextEditingController();

@override
void initState() {
  super.initState(); 
  setState(() {
    _searchToDo = todos;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 228, 228),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 3, 39, 68),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundImage: AssetImage("asserts/pf.jpg"),
          )
        ]),
      ),
      body: SafeArea(child: _body()),
    );
  }

  _body() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            _searchBox(),
            _list(),
            _input()
          ],
        ),
      ],
    );
  }

  _searchBox() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: TextField(
            onChanged: (value) => searchData(value),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: "Search",
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 25, minWidth: 20),
            ),
          ),
        ),
      ),
    );
  }

  _list() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "ALL TODOS",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ), // Adjust the height as needed
            Expanded(
              child: ListView(
                children: [
                  // Add more ListTiles as needed
                  for (Todo todo in _searchToDo.reversed)
                    TodoItem(
                      todo: todo,
                      onDelete: () {
                        setState(() {
                          todos.remove(todo);
                        });
                      },
                      onclick: () {
                        setState(() {
                          todo.isDone = !todo.isDone;
                        });
                      },
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: TextField(
                    controller: todoTextInput,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add New To Do",
                      prefixIconConstraints:
                          BoxConstraints(maxHeight: 25, minWidth: 20),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  print("sd");
                  // Handle button press
                  setState(() {
                    todos.add(Todo(
                      id: DateTime.now().microsecond.toString(),
                      title: todoTextInput.text,
                      isDone: false,
                    ));
                  });
                  todoTextInput.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchData(String text) {
    List<Todo> results = [];
    if (text.isEmpty) {
      results = todos;
    } else {
      results = todos
          .where((element) =>
              element.title.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchToDo = results;
    });
  }
}
