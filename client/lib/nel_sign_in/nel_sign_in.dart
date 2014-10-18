import 'package:polymer/polymer.dart';
import '../src/user.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-sign-in')
class NelSignIn extends PolymerElement {
  @observable bool createNew = false;
  @published User user;

  User tmpUser;

  NelSignIn.created() : super.created() {
    tmpUser = new User.empty();
  }

  void signIn() {

  }

  void makeNew() {
    createNew = true;
  }

}

