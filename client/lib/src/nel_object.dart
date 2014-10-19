library nel.object;

part 'user.dart';
part 'nel_node.dart';

abstract class NelObject {
  String objId;
  String type;

  NelObject(this.objId);

  factory NelObject.fromJson(Map json) {
    var ty = json['type'];
    NelObject obj;
    switch(ty) {
      case 'user':
        obj = new User(json['objId'], json['username'], json['name'], json['email']);
        break;
      case 'node':
        obj = new NelNode(json['objId'],
            json['title'],
            json['notes'],
            json['parents']);
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