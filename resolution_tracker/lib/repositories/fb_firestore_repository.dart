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

  CloudFirestoreRepository._();


  addResolution(Resolution resolution) {

  }

  deleteResolution(String resolutionID) {

  }

  updateResolution(Resolution resolution) {

  }


}