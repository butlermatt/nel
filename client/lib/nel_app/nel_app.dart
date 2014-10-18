import 'package:polymer/polymer.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-app')
class NelApp extends PolymerElement {
  @published int count = 0;

  NelApp.created() : super.created() {
  }

  void increment() {
    count++;
  }
}

