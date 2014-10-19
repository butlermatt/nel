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
    var cache = [];
    nodes.forEach((el) {
      add(el);
      el.parents.forEach((var parId) {
        var par = items[parId];
        if(par == null) {
          print('Adding to cache: ${el.toJson()}');
          cache.add(el);
        } else {
          par.children.add(el);
        }
      });
    });

    cache.forEach((var child) {
      child.parents.forEach((var parId) {
        var par = items[parId];
        if(par != null) {
          par.children.add(child);
          print('Cache Adding to parent: ParID: ${par.objId}, child: ${child.objId}');
        }
      });
    });
  }

}