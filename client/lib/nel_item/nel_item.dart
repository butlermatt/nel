import 'dart:html';
import 'dart:convert';

import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_input.dart';
import 'package:crypto/crypto.dart';

import '../src/ajax.dart';
import '../src/nel_object.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-item')
class NelItem extends PolymerElement with Ajax {
  @published NelNode model;

  NelItem.created() : super.created();

}