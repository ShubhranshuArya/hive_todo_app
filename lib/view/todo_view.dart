import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db_learning/view/add_todo_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_db_learning/adapter/todo_adapter.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Todo_Hive'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todos').listenable(),
        builder: (BuildContext context, Box<Todo> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No todo data'),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              Todo todo = box.getAt(index)!;
              return ListTile(
                // TODO: delete data on sliding right.
                onLongPress: () async => await box.delete(index),
                title: Text(todo.title),
                subtitle: Text(todo.description),
              );
            },
          );
        },
      ),
    );
  }
}
