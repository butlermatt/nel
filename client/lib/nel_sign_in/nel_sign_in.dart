import 'dart:html';
import 'dart:convert';

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_input.dart';
import 'package:crypto/crypto.dart';

import '../src/user.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-sign-in')
class NelSignIn extends PolymerElement {
  @observable bool createNew = false;
  @published User user;

  @observable String pass1 = '';
  @observable String pass2 = '';

  User tmpUser;

  NelSignIn.created() : super.created() {
    tmpUser = new User.empty();
  }

  // Existing user sign-in
  void signIn() {
    var header = { 'Content-Type': 'application/json'};
    var data = JSON.encode(tmpUser.toJson());
    HttpRequest.request('/signin', method: 'POST', sendData: data, requestHeaders: header)
      .then((HttpRequest req) {
        var map = JSON.decode(req.responseText);
        print(map);
    });
  }

  // Toggle to create new user screen
  void makeNew() {
    createNew = true;
  }

  // Create new user button.
  void newUser() {
    bool warn = false;
    if(tmpUser.name.isEmpty) {
      warn = true;
      // TODO: Warning on username
    }

    if(tmpUser.email.isEmpty) {
      warn = true;
      // TODO: Warn on email
    }

    if(pass1.isEmpty || pass1 != pass2) {
      warn = true;
      // TODO: Warn on password.
    } else {
      var sha = new SHA256()
          ..add(pass1.codeUnits)
          ..add("MARCATOSALT".codeUnits);
      tmpUser.password = CryptoUtils.bytesToBase64(sha.close(), urlSafe: true);
    }

    if(!warn) {
      print(tmpUser.toJson());
    }

  }

  void passChange(Event e, var detail, Node node) {
    var tmpPass = (node as PaperInput).value;
    var sha = new SHA256();
    sha..add(tmpPass.codeUnits)
      ..add("MARCATOSALT".codeUnits);
    tmpUser.password = CryptoUtils.bytesToBase64(sha.close(), urlSafe: true);
  }

}

