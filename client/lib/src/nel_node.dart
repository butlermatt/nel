part of nel.object;

class NelNode extends NelObject {
  String type = 'node';
  String title;
  String notes;
  List parents;
  List children;

  NelNode(String objId, this.title, this.notes, this.parents, this.children)
      : super(objId);

  NelNode.empty() : super(null) {
    children = new List();
    title = notes = '';
  }

  // TODO: This should not be so verbose. Transfer only changes.
  Map toJson() => {
    'type' : type,
    'objId' : objId,
    'title' : title,
    'notes' : notes,
    'parents': parents,
    'children': children
  };
}