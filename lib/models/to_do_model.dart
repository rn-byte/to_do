import 'package:cloud_firestore/cloud_firestore.dart';

class ToDos {
  String task;
  bool isDone;
  Timestamp createdOn;
  Timestamp updatedOn;

  ToDos({
    required this.task,
    required this.isDone,
    required this.createdOn,
    required this.updatedOn,
  });
  // Named constructor to create a ToDo instance from a JSON object
  ToDos.fromJson(Map<String, Object?> json)
      : this(
          task: json['task']! as String,
          isDone: json['isDone']! as bool,
          createdOn: json['createdOn']! as Timestamp,
          updatedOn: json['updatedOn']! as Timestamp,
        );

  ToDos copyWith({
    String? task,
    bool? isDone,
    Timestamp? createdOn,
    Timestamp? updatedOn,
  }) {
    return ToDos(
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'task': task,
      'isDone': isDone,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
    };
  }
}
