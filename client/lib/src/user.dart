import 'nel_object.dart';

class User extends NelObject {
  String type = 'user';
  String name;
  String email;
  String password;

  User(String objId, this.name, this.email) : super(objId);
  User.empty() : super('') {
    name = email = password = '';
  }

  Map toJson() {
    var ret = {
      'type' : type,
      'objId' : objId,
      'name' : name,
      'email' : email
    };

    if(password != null && password.isNotEmpty) {
      ret['password'] = password;
    }
    return ret;
  }
}