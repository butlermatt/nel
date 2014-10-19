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
    var tmpNode = new NelNode(user.objId, 'Life of ${user.name}',
        'The root of everything', [])
      ..isRoot = true;

    manager.root = tmpNode;

    getAllNodes().then((list) {
      manager.addAll(list);
    }).then((_) => this.node = tmpNode);
  }

  void routeChanged(Event e, var detail, Node node) {
    print('Route change received. Detail: ${detail.objId}');
    this.node = detail;
  }

}

