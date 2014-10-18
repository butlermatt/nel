class User {
  String objId;
  String name;
  String email;
  String password;

  User(this.objId, this.name, this.email);
  User.empty() {
    objId = name = email = password = '';
  }

  Map toJson() {
    var ret = {
      'objId' : objId,
      'name' : name,
      'email' : email
    };

    if(password != null || password.isNotEmpty) {
      ret['password'] = password;
    }
    return ret;
  }
}