library nel.app;

import 'dart:html';

import 'package:polymer/polymer.dart';
import '../src/user.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-app')
class NelApp extends PolymerElement {
  @observable User user;

  NelApp.created() : super.created() {
  }

  void signedIn(Event e, var detail, Node node) {
    user = detail;
  }

}

