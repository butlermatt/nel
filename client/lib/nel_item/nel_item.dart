import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';

import '../src/ajax.dart';
import '../src/nel_object.dart';
import '../src/item_provider.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('nel-item')
class NelItem extends PolymerElement with Ajax {
  @published NelNode model;
  @observable List<NelNode> subItems;
  @observable bool collapse = false;

  @observable
  String get subIcon => collapse ? 'remove-circle' : 'add-circle';

  @ComputedProperty('model.completed')
  bool get completed => readValue(#completed);

  @ComputedProperty('subItems.isNotEmpty')
  bool get hasChildren => readValue(#hasChildren);

  Timer updateTimer;

  ItemProvider _manager;

  NelItem.created() : super.created() {
    subItems = toObservable([]);
    _manager = new ItemProvider();
  }

  void modelChanged(oldVal) {
    subItems..clear()
        ..addAll(model.children);
  }

  // TODO: on changes fire event to trigger app to update on intervals
  void addNode() {
    if(model.title.isNotEmpty) {
      var newNode = new NelNode.empty()
          ..parents.add(model.objId);
      subItems.add(newNode);
    }
    // TODO: Not here, but holy crapy, recursive polymer elements work!
  }

  void removeNode() {
    if(model.title.isNotEmpty) {
      model = null;
    }
    this.parent.remove();
  }

  void completeNode() {
    model.completed = true;
    $['title'].classes.toggle('completed', true);
    $['notes'].classes.toggle('completed', true);
  }

  void toggleSublist() {
    collapse = !collapse;
  }

  void saveUpdate() {
    if(model.objId == null || model.objId.isEmpty) {
      send('/node/new', model).then((res) {
        model.objId = res;
        print('model id updated to: $res');
      });
    } else {
      send('/node/${model.objId}', model).then((res) {
        print('Update successful');
      });
    }
  }

  ready() {
    super.ready();
    DivElement titleDiv = $['title'];
    titleDiv..onKeyDown.listen(onTitleKeyDown)
        ..onBlur.listen(onDivBlur)
        ..onFocus.listen(onDivFocus);

    DivElement notesDiv = $['notes'];
    notesDiv..onKeyDown.listen(onNotesKeyDown)
        ..onBlur.listen(onDivBlur)
        ..onFocus.listen(onDivFocus);

    DivElement block = $['block'];
    block..onMouseEnter.listen(onContainerEnter)
        ..onMouseLeave.listen(onContainerLeave);

  }

  void onTitleKeyDown(KeyboardEvent event) {
    if(event.keyCode == KeyCode.ENTER) { // TODO: Enter to create a new, same level bullet.
      event.preventDefault();
      $['title'].blur();
      model.title = $['title'].text;
      if(event.ctrlKey == true) {
        // Ctrl+Enter focus on notes.
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
      model.notes = targ.innerHtml.toString().replaceAll(r'<br>', '\n');
    } else if(targ.id == 'title') {
      model.title = targ.text.trim();
    }
    print('Model updated: ${model.toJson()}');

    if(model.title.isNotEmpty)
      updateTimer = new Timer(new Duration(seconds: 3), saveUpdate);
  }

  void onContainerEnter(MouseEvent event) {
    $['block'].classes.toggle('highlight');
    $['buttonControl'].classes.toggle('hideme');
  }

  void onContainerLeave(MouseEvent event) {
    $['buttonControl'].classes.toggle('hideme');
  }

  void onDivFocus(Event event) {
    if(updateTimer != null && updateTimer.isActive)
      updateTimer.cancel();

    var target = event.target as DivElement;
    if(target.id == 'notes' && model.title.isEmpty) {
      $['title'].focus();
    }
    if((target.id == 'notes' && model.notes.isEmpty) ||
        (target.id == 'title' && model.title.isEmpty)) {
      target.children.clear();
      target.focus();
    }
  }
}