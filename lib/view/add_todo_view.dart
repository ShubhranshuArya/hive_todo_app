import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db_learning/adapter/todo_adapter.dart';

class AddTodoView extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  AddTodoView({Key? key}) : super(key: key);

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  late String title, description;

  void submitData() {
    if (widget.formKey.currentState!.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todos');
      todoBox.add(
        Todo(
          title: title,
          description: description,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a todo'),
      ),
      body: Form(
        key: widget.formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Add title',
              ),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Add description',
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: submitData,
              child: const Text('Submit Data'),
            )
          ],
        ),
      ),
    );
  }
}
