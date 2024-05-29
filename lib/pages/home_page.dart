import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/to_do_model.dart';
import '../services/database_services.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final TextEditingController _textEditingController = TextEditingController();
  String taskName = '';
  final _formKey = GlobalKey<FormState>();

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayTextInputDialog,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.indigo,
      centerTitle: true,
      title: const Text(
        "Todo List",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Column(
      children: [
        _messagesListView(),
      ],
    ));
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _databaseService.getTodo(),
        builder: (context, snapshot) {
          List todos = snapshot.data?.docs ?? [];
          if (todos.isEmpty) {
            return const Center(
              child: Text("Add a todo!"),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              ToDos todo = todos[index].data();
              String todoId = todos[index].id;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Dismissible(
                  key: Key(todoId),
                  onDismissed: (direction) {
                    _databaseService.deleteTodo(todoId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          'Task "${todo.task.toString()}" deleted',
                        ),
                        backgroundColor: Colors.grey,
                      ),
                    );
                    // if (direction == DismissDirection.startToEnd ||
                    //     direction == DismissDirection.endToStart) {
                    //   _databaseService.deleteTodo(todoId);
                    // }
                  },
                  background: const Card(
                    color: Colors.red,
                    child: Center(child: Text('Delete')),
                  ),
                  secondaryBackground: const Card(
                    color: Colors.red,
                    child: Center(child: Text('Delete')),
                  ),
                  child: Card(
                    // color: Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      //tileColor: Theme.of(context).colorScheme.primaryContainer,
                      title: Text(
                        todo.task,
                        style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationThickness: 3),
                      ),
                      subtitle: Text(
                        'Created on: ${DateFormat("MMM d, y h:mm a").format(todo.createdOn.toDate())} Updated On : ${DateFormat("MMM d, y h:mm a").format(todo.updatedOn.toDate())}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          ToDos updatedTodo = todo.copyWith(
                              isDone: !todo.isDone, updatedOn: Timestamp.now());
                          _databaseService.updateTodo(todoId, updatedTodo);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _displayTextInputDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add a todo',
            //textAlign: TextAlign.center,
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: "Todo....",
              ),
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Field cannot be empty';
                } else {
                  return null;
                }
              },
              onSaved: (newValue) {
                taskName = newValue.toString();
              },
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.indigo,
              textColor: Colors.white,
              child: const Text('Ok'),
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  _formKey.currentState!.save();
                  ToDos todo = ToDos(
                      task: taskName.toString(),
                      isDone: false,
                      createdOn: Timestamp.now(),
                      updatedOn: Timestamp.now());
                  _databaseService.addTodo(todo);
                  Navigator.pop(context);
                  _textEditingController.clear();
                } else {
                  debugPrint('Error in provided value');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
