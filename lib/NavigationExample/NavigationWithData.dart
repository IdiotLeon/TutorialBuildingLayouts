import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TodoItem {
  final String title;
  final String description;

  TodoItem(this.title, this.description);
}

class AppNavigatingWithData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passing Data',
      home: TodoItemsScreen(
        todoItems: List.generate(
          20,
          (i) => TodoItem('TodoItem $i',
              'A description of what needs to be done for Todo $i'),
        ),
      ),
    );
  }
}

class TodoItemsScreen extends StatelessWidget {
  final List<TodoItem> todoItems;

  TodoItemsScreen({Key key, @required this.todoItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(todoItems[index].title),
              // When a user taps on the ListTile, navigate to the DetailScreen.
              // Notice that we're not only creating a DetailScreen, we're
              // also passing the current todos through to it!
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(todoItem: todoItems[index]),
                  ),
                );
              });
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // To declare a field that holds the todoItem
  final TodoItem todoItem;

  // In the constructor, require a TodoItem
  DetailScreen({Key key, @required this.todoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${todoItem.title}"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('${todoItem.description}'),
        ));
  }
}
