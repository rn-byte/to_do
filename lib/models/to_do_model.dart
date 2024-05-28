import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String task;
  bool isDone;
  Timestamp createdOn;
  Timestamp updatedOn;

  ToDo({
    required this.task,
    required this.isDone,
    required this.createdOn,
    required this.updatedOn,
  });
}
