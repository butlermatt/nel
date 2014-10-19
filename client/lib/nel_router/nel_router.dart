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

    loc = loc.replaceAll('/', '');
    var model = manager.getNodeById(loc);
    if(model != null) {
      fire('routeChange', detail: model);
    }
    // Do stuff.
  }
}