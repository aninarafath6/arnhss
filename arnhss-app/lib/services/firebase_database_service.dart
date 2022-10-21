import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseDatabaseService {
  //* collection reference
  final CollectionReference noticesCollection =
      FirebaseFirestore.instance.collection('notices');

//* get stream
  Stream<QuerySnapshot?> get notices {
    return noticesCollection.snapshots();
  }
}
