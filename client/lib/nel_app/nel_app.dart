library nel.app;

import 'dart:html';

import 'package:polymer/polymer.dart';
import '../src/nel_object.dart';
import '../src/ajax.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-app')
class NelApp extends PolymerElement with Ajax {
  @observable User user;
  @observable NelNode node;

  @observable List<NelNode> nelNodes;

  NelApp.created() : super.created() {
    // Temp
////    user = new User('1', 'mbutler', 'mbutler@seaside.ns.ca');
//    this.node = new NelNode(user.objId, 'Life of ${user.name}',
//        "You're at the top", null, null);
//    this.node.isRoot = true;
  }

  void signedIn(Event e, var detail, Node node) {
    user = detail;

  }

}

