import 'dart:html';
import 'dart:convert';

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_input.dart';
import 'package:crypto/crypto.dart';

import '../src/user.dart';
import '../src/ajax.dart';
import '../src/nel_object.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-sign-in')
class NelSignIn extends PolymerElement with Ajax {
  @observable bool createNew = false;
  @published User user;

  @observable String pass1 = '';
  @observable String pass2 = '';
  @observable String statusMessage = '';

  User tmpUser;

  NelSignIn.created() : super.created() {
    tmpUser = new User.empty();
  }

  // Existing user sign-in
  void signIn() {
    statusMessage = '';
    var header = { 'Content-Type': 'application/json'};
    var data = JSON.encode(tmpUser.toJson());

    send('/signin', tmpUser).then((res) {
      print('signin/new received response: $res');
      if(res is User) {
        user = res;
      }
    }).catchError((e) {
      statusMessage = e.message;
    }, test: (e) => e is NelException)
    .catchError((e) {
      print(e);
    });
  }

  // Toggle to create new user screen
  void makeNew() {
    statusMessage = '';
    createNew = true;
  }

  // Create new user button.
  void newUser() {
    statusMessage = '';
    bool warn = false;
    if(tmpUser.name.isEmpty) {
      warn = true;
      statusMessage += 'You must provide a username\n';
    }

    if(tmpUser.email.isEmpty) {
      warn = true;
      statusMessage += 'You must provide an email address';
    }

    if(pass1.isEmpty || pass1 != pass2) {
      warn = true;
      statusMessage += 'Passwords do not match';
    } else {
      var sha = new SHA256()
          ..add(pass1.codeUnits)
          ..add("MARCATOSALT".codeUnits);
      tmpUser.password = CryptoUtils.bytesToBase64(sha.close(), urlSafe: true);
    }

    if(!warn) {
      send('/signin/new', tmpUser).then((res) {
        print('signin/new received response: $res');
        if(res is User) {
          user = res;
        }
      }).catchError((e) {
        statusMessage = e.message;
      }, test: (e) => e is NelException)
      .catchError((e) {
        print(e);
      });
    }

  }

  void passChange(Event e, var detail, Node node) {
    statusMessage = '';
    var tmpPass = (node as PaperInput).value;
    var sha = new SHA256();
    sha..add(tmpPass.codeUnits)
      ..add("MARCATOSALT".codeUnits);
    tmpUser.password = CryptoUtils.bytesToBase64(sha.close(), urlSafe: true);
  }

}

