import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/models/models.dart';



/// Repository to handle communication with the Firestore database.
/// 
/// The singleton pattern is achieved with the classic method with a 
/// factory constructor.
///
class ResolutionsNotifier extends ChangeNotifier {

  static final ResolutionsNotifier _instance = ResolutionsNotifier._();

  factory ResolutionsNotifier() {
    return _instance;
  }

  AuthenticationNotifier _authProvider;
  Firestore _firestore;

  ResolutionsNotifier._() {
    _firestore = Firestore.instance;
    _authProvider = AuthenticationNotifier();
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
    return _firestore.collection("path").snapshots().transform(streamTransformer);
  }


  Future<void> addResolution(Resolution resolution) {
    String userUID = _authProvider.user.uid;
    return _firestore.collection(userUID).add(resolution.toJson());
  }


  Future<void> deleteResolution(String resolutionID) {
    String userUID = _authProvider.user.uid;
    return _firestore.collection(userUID).document(resolutionID).delete();
  }
  

  Future<void> updateResolution(Resolution resolution) {
    String userUID = _authProvider.user.uid;
    return _firestore.collection(userUID).document().updateData(resolution.toJson());
  }

}
