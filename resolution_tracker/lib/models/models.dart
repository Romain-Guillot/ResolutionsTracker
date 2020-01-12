
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

///
///
class Resolution implements Comparable<Resolution> {

  String id;
  String title;
  String icon;
  DateTime dateCreated;
  Set<DaysEnum> frequency;
  DateTime lastDayVerified;
  List<bool> successHistory;

  int get success => successHistory.where((b) => b).length;
  int get failed => successHistory.length - success;

  Resolution.fromJson({@required this.id, Map<String, Object> data}) {
    title = data["title"];
    frequency = (data["frequency"] as List<dynamic>).cast<String>().map((f) => DaysEnum.fromValue(f)).toSet();
    successHistory = [true, true, true, false];

    if (dateCreated == null)
       dateCreated = DateTime(0);
  }
  
  Resolution.create(this.title, this.icon, this.frequency) {
    dateCreated = DateTime.now();
  }


  Map<String, Object> toJson() {
    return {
      "title" : title,
      "icon" : icon,
      "dateCreated" : dateCreated,
      "frequency" : frequency.map((f) => f.value).toList(),
      "lastDayVerified" : lastDayVerified,
      "successHistory" : successHistory
    };
  }

  @override
  int compareTo(Resolution other) {
    return dateCreated.compareTo(other.dateCreated);
  }

  @override
  String toString() => "Theme: $title - $icon ($dateCreated). Frequency: $frequency";
}



class User {
  FirebaseUser _fbUser;

  User(this._fbUser);

  String get uid => _fbUser.uid;
  String get name => _fbUser?.displayName??"";
  String get profileURL => _fbUser?.photoUrl;
}


/// Days of the week (enum)
/// 
/// Java-like enumeration (enums with value) 
/// Here, a value is the day textual respresentation in english
/// 
/// Note : the constructor is private, only the 7 following objetcs
/// can exists. The value cannot be modified.
class DaysEnum {
  static final DaysEnum MONDAY =  DaysEnum._("monday");
  static final DaysEnum TUESDAY =  DaysEnum._("tuesday");
  static final DaysEnum WEDNESDAY =  DaysEnum._("wednesday");
  static final DaysEnum THURSDAY =  DaysEnum._("thursday");
  static final DaysEnum FRIDAY =  DaysEnum._("friday");
  static final DaysEnum SATURDAY =  DaysEnum._("saturday");
  static final DaysEnum SUNDAY =  DaysEnum._("sunday");


  final String _value;
  String get value => _value;

  DaysEnum._(this._value);

  static DaysEnum fromValue(String value) {
    for (DaysEnum e in DaysEnum.values()) {
      if (e.value == value) return e;
    }
    return null;
  }

  static List<DaysEnum> values() => [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY];

  @override
  String toString() => value;

}