import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/task.dart';

class FirebaseUnits {
  static CollectionReference<Task> getTasksCollection() {
    return (FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore()));
  }

  static Future<void> addTaskToFireStor(Task task) {
    var taskCollection = getTasksCollection();
    DocumentReference<Task> taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deletTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }
}
