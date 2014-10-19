library nel.app;

import 'dart:html';

import 'package:polymer/polymer.dart';
import '../src/nel_object.dart';
import '../src/ajax.dart';
import '../src/item_provider.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-app')
class NelApp extends PolymerElement with Ajax {
  @observable User user;
  @observable NelNode node;

  @observable List<NelNode> nelNodes;

  ItemProvider manager;

  NelApp.created() : super.created() {
    manager = new ItemProvider();
  }

  void signedIn(Event e, var detail, Node node) {
    user = detail;
    this.node = new NelNode(user.objId, 'Life of ${user.name}',
        'The root of everything', [])
      ..isRoot = true;

    manager.root = this.node;

    getAllNodes().then((list) {
      manager.addAll(list);
      print('Added nodes: $list');
    });
  }

}

