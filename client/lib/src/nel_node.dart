part of nel.object;

class NelNode extends NelObject {
  String type = 'node';
  String title;
  String notes;
  List parents;
  List children;
  bool isRoot = false;
  bool completed = false;

  NelNode(String objId, this.title, this.notes, this.parents, this.completed)
      : super(objId) {
    children = new List();
  }

  NelNode.empty() : super(null) {
    children = new List();
    parents = new List();
    title = notes = '';
  }

  // TODO: This should not be so verbose. Transfer only changes.
  Map toJson() => {
    'type' : type,
    'objId' : objId,
    'title' : title,
    'notes' : notes,
    'parents': parents,
    'completed': completed
//    'children': children
  };
}