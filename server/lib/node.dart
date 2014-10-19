part of nel.server;

@Route('/node')
class NelNode extends Vane {

  @Route('/new', method: 'POST')
  Future newNode() {
    if(session['objId'] == null) {
      var res = {'error' : 'Session Timed Out',
                 'code' : 401 };
      return close(res);
    }

    return mongodb.then((db) {
      var id = new ObjectId();
      var doc = json;
      doc['_id'] = id;
      doc['user'] = session['objId'];

      var nodeCol = db.collection('nodes');
      nodeCol.save(doc);

      var res = {
                  'objId' : id.toHexString(),
                  'type' : 'save'
                };
      return close(res);
    });
  }
}