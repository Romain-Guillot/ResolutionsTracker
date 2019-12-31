import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resolution_tracker/models/models.dart';


/// Repository to handle communication with the Firestore database.
/// 
/// The singleton pattern is achieved with the classic method with a 
/// factory constructor.
///
class CloudFirestoreRepository {

  static final CloudFirestoreRepository _instance = CloudFirestoreRepository._();

  factory CloudFirestoreRepository() {
    return _instance;
  }

  Firestore _firestore;

  CloudFirestoreRepository._() {
    _firestore = Firestore.instance;
  }


  Stream<List<Resolution>> allResolutions() {
    StreamTransformer<QuerySnapshot, List<Resolution>> streamTransformer = StreamTransformer.fromHandlers(
      handleData: (snap, sink) {
        List resolutions = [];
        for (DocumentSnapshot docSnap in snap.documents) {
          resolutions.add(Resolution.fromJson(docSnap.data));
        }
        sink.add(resolutions);
      } 
    );
    _firestore.collection("path").snapshots().transform(streamTransformer);
  }


  Future<String> addResolution(Resolution resolution) {
    _firestore.collection("path").document("").setData(resolution.toJson());
  }


  Future<void> deleteResolution(String resolutionID) {
    _firestore.collection("path").document("").delete();
  }
  

  Future<void> updateResolution(Resolution resolution) {
    addResolution(resolution);
  }


}