import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBaseAPIService {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  FirebaseBaseAPIService(this.path) {
    ref = _db.collection(path);
  }

  // Get all documents
  Future<QuerySnapshot> getDataCollection() async => await ref.getDocuments();

  // Get stream of documents
  Stream<QuerySnapshot> streamDataCollection() => ref.snapshots();

  // Get particular document by id
  Future<DocumentSnapshot> getDocumentById(String id) async =>
      await ref.document(id).get();

  // Delete particular document by id
  Future<void> removeDocumentById(String id) async =>
      await ref.document(id).delete();

  // Add document to the collection
  Future<DocumentReference> addDocument(Map data) async => await ref.add(data);

  // Update particular document by id
  Future<void> updateDocument(Map data, String id) async =>
      await ref.document(id).updateData(data);
}
