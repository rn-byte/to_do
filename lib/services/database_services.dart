import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/models/to_do_model.dart';

const String toDoCollRef = "todo";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _toDoRef;
  DatabaseService() {
    _toDoRef = _firestore.collection(toDoCollRef).withConverter<ToDos>(
        fromFirestore: (snapshots, _) => ToDos.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (todo, _) => todo.toJson());
  }

  Stream<QuerySnapshot> getTodo() {
    return _toDoRef.snapshots();
  }

  void addTodo(ToDos todo) async {
    await _toDoRef.add(todo);
  }

  void updateTodo(String todoId, ToDos todo) {
    _toDoRef.doc(todoId).update(todo.toJson());
  }

  void deleteTodo(String todoId) {
    _toDoRef.doc(todoId).delete();
  }
}
