library nel.object;

import 'user.dart';

abstract class NelObject {
  String objId;
  String type;

  NelObject(this.objId);

  factory NelObject.fromJson(Map json) {
    var ty = json['type'];
    NelObject obj;
    switch(ty) {
      case 'user':
        obj = new User(json['objId'], json['name'], json['email']);
        break;
      default:
        throw new ArgumentError('Invalid NelObject type: $ty');
    }

    return obj;
  }

  Map<String, dynamic> toJson();
}

class NelException implements Exception {
  String message;

  NelException([this.message]);

  String toString() => 'NelException: $message';
}