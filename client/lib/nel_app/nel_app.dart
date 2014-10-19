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

  NelApp.created() : super.created();

  void signedIn(Event e, var detail, Node node) {
    user = detail;
    this.node = new NelNode(user.objId, 'Life of ${user.name}',
        'The root of everything', null, null)
      ..isRoot = true;
    // Get all nodes for this user.
  }

}

