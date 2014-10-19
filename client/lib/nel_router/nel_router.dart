import 'dart:html';

import 'package:polymer/polymer.dart';

import '../src/item_provider.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-router')
class NelRouter extends PolymerElement {
  ItemProvider manager;

  NelRouter.created() : super.created();

  void ready() {
    manager = new ItemProvider();
    window.onHashChange.listen(omgRoute);
  }

  void omgRoute(Event event) {
    var loc = window.location.hash;
    print('Hashchange event. Location: $loc');

    loc = loc.substring(1).replaceAll('/', '');

    var model;
    if(loc.isEmpty) {
      model = manager.root;
    } else {
      model = manager.getNodeById(loc);
    }

    if(model != null) {
      print('Model found: ${model.objId}');
      fire('routechange', detail: model);
    } else {
      print("Couldn't find model: $loc");
    }
    // Do stuff.
  }
}