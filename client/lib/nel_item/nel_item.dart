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
  @observable List<NelNode> subItems;

  NelItem.created() : super.created() {
    subItems = toObservable([]);
  }

  // TODO: on changes fire event to trigger app to update on intervals
  void addNode() {
    subItems.add(new NelNode.empty());
    // TODO: Not here, but holy crapy, recursive polymer elements work!
  }

  ready() {
    super.ready();
    DivElement titleDiv = $['title'];
    titleDiv.onKeyDown.listen(onTitleKeyDown);
    titleDiv.onBlur.listen(onDivBlur);

    DivElement notesDiv = $['notes'];
    notesDiv.onKeyDown.listen(onNotesKeyDown);
    notesDiv.onBlur.listen(onDivBlur);
  }


  void onTitleKeyDown(KeyboardEvent event) {
    if(event.keyCode == KeyCode.ENTER) { // TODO: Enter to create a new, same level bullet.
      event.preventDefault();
      $['title'].blur();
      model.title = $['title'].text;
      if(event.ctrlKey == true) {
        // Ctrl+Enter focus on notes.
        print('Ctrl-enter hit!');
        $['notes'].focus();
      }
      if(event.shiftKey == true) {
        subItems.add(new NelNode.empty());
        // Shift+Enter create a subnode
      }
    }

  }

  void onNotesKeyDown(KeyboardEvent event) {
    if(event.keyCode == KeyCode.ENTER && event.ctrlKey == true) {
      event.preventDefault();
      $['notes'].blur();
      model.notes = $['notes'].text;
    }
  }

  void onDivBlur(Event event) {
    var targ = event.target;
    if(targ.id == 'notes') {
      model.notes = targ.text.trim(); // TODO: need to replace new lines
    } else if(targ.id == 'title') {
      model.title = targ.text.trim();
    }
    print('Model updated: ${model.toJson()}');
  }
}