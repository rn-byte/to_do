import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var addController = TextEditingController();
  bool isVal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List '),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('todo').snapshots(),
          builder: (context, todoSnapshots) {
            final toDo = todoSnapshots.data!.docs;

            if (todoSnapshots.data == null) {
              return const Center(child: Text("Add Todo "));
            } else if (todoSnapshots.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dismissible(
                    key: Key(toDo[index]['task']),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd ||
                          direction == DismissDirection.endToStart) {
                        FirebaseFirestore.instance
                            .collection('todo')
                            .doc(toDo[index].id)
                            .delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 3),
                            content: Text('${toDo[index]['task']} deleted'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Center(child: Text('Delete')),
                    ),
                    secondaryBackground: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text('Delete'),
                      ),
                    ),
                    child: Card(
                      elevation: 10,
                      child: ListTile(
                        title: Text(toDo[index]['task']),
                        subtitle: Text(
                            "Created on :${DateFormat('yMMMd').format(toDo[index]['createdOn'].toDate())} : ${DateFormat('jm').format(toDo[index]['createdOn'].toDate())} \nUpdated on :${DateFormat('yMMMd').format(toDo[index]['updatedOn'].toDate())} : ${DateFormat('jm').format(toDo[index]['updatedOn'].toDate())} "),
                        trailing: Checkbox(
                          value: toDo[index]['isDone'],
                          onChanged: (value) {
                            debugPrint(toDo[index].id);

                            FirebaseFirestore.instance
                                .collection('todo')
                                .doc(toDo[index].id)
                                .update({
                              'isDone': value,
                              'updatedOn': DateTime.now(),
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: toDo.length,
              );
            }
            return Container();
          }),
      floatingActionButton: _floatingActioButonSection(context),
    );
  }

  FloatingActionButton _floatingActioButonSection(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.indigo,
      elevation: 30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            alignment: Alignment.center,
            title: const Text(
              'Add a Todo',
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: 250,
              child: TextField(
                controller: addController,
                decoration: const InputDecoration(hintText: 'To Do ........'),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () async {
                      Navigator.pop(context);
                      await FirebaseFirestore.instance
                          .collection('todo')
                          .doc()
                          .set({
                        'createdOn': DateTime.now(),
                        'isDone': false,
                        'task': addController.text.toString().trim(),
                        'updatedOn': DateTime.now(),
                      });

                      addController.clear();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
