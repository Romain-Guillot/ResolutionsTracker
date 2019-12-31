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

  List<Resolution> _userResolutions = [];

  List<Resolution> get resolutions => _userResolutions;
  int get length => _userResolutions?.length??0;

  ResolutionsNotifier._() {
    _firestore = Firestore.instance;
    _authProvider = AuthenticationNotifier();
    initUserResolutions();
  }


  initUserResolutions() {
    String userUID = _authProvider.user.uid;
    StreamTransformer<QuerySnapshot, List<Resolution>> streamTransformer = StreamTransformer.fromHandlers(
      handleData: (snap, sink) {
        print(snap.documents.length);
        List<Resolution> resolutions = [];
        for (DocumentSnapshot docSnap in snap.documents) {
          resolutions.add(Resolution.fromJson(docSnap.data));
        }
        sink.add(resolutions);
      } 
    );
    _firestore.collection(userUID).orderBy("dateCreated", descending: true).snapshots().transform(streamTransformer).listen((data) {
      _userResolutions = data;
      notifyListeners();
    });
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
