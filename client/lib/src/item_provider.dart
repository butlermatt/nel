library nel.item.provider;

import 'nel_object.dart';

class ItemProvider {
  static ItemProvider _cache;

  Map<String, NelNode> items;
  NelNode _root;

  factory ItemProvider() {
    if(_cache == null) {
      _cache = new ItemProvider._internal();
    }
    return _cache;
  }

  ItemProvider._internal() {
    items = new Map<String, NelNode>();
  }

  void set root(NelNode val) {
    _root = val;
    items[val.objId] = val;
  }

  NelNode get root => _root;

  NelNode getNodeById(String id) {
    var node = items[id];
    // if null, query server?
    return node;
  }

  void add(NelNode node) {
    items[node.objId] = node;
  }

  void addAll(List nodes) {
    nodes.forEach((el) { items[el.objId] = el; });
    // Need to associate nodes as well ?
  }

}