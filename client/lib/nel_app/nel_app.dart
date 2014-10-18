import 'package:polymer/polymer.dart';
import '../src/user.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-app')
class NelApp extends PolymerElement {
  User user;

  NelApp.created() : super.created() {
  }

}

