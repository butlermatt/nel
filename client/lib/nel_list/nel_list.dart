library nel.list;

import 'dart:html';

import 'package:polymer/polymer.dart';
import '../src/nel_object.dart';
import '../src/ajax.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-list')
class NelList extends PolymerElement with Ajax {
  @published NelNode model;

  NelList.created() : super.created();

  void addNode() {
    var contain = $['sublists'];

  }
}