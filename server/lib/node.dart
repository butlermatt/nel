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
      return nodeCol.insert(doc).then((_) {
        log.info('Saved data: $doc');
        var res = {
                    'objId' : id.toHexString(),
                    'type' : 'save'
                  };
        return close(res);
      });
    });
  }

  @Route('/list', method: 'GET')
  Future getNodes() {
    var docs = [];
    log.info('Query request for user: "${session['objId']}" (${session['username']})');
    var usrId = session['objId'];
    if(usrId == null) {
      var ret = { 'error' : 'Session Timed Out',
                  'code' : 401 };

      return close(docs..add(ret));
    }

    return mongodb.then((db) {
      var nodeCol = db.collection('nodes');
      return nodeCol.find(where.eq('user',usrId)).forEach((Map doc) {
        doc['objId'] = doc.remove('_id').toHexString();
        docs.add(doc);
      });
    }).then((_) => close(docs));
  }

  @Route('/{nodeId}', method: 'GET')
  Future getNode(String nodeId) {
    if(session['objId'] == null) {
      var ret = {'error' : 'Session Timed Out',
                 'code' : 401 };
      return close(ret);
    }

    return mongodb.then((db) {
      var nodeCol = db.collection('nodes');
      var id = ObjectId.parse(nodeId);
      return nodeCol.findOne(where.eq('_id', id)).then((res) {
        if(res == null) {
          // no result found
          var ret = { 'error' : 'Node not found',
                    'code' : 404 };
          return close(ret);
        }

        ObjectId objId = res.remove('_id');
        res['objId'] = objId.toHexString();
        return close(res);
      });
    });
  }

  @Route('/{nodeId}', method: 'POST')
  Future updateNode(String nodeId) {
    if(session['objId'] == null) {
      var ret = { 'error' : 'Session Timed Out',
                  'code' : 401 };
      return close(ret);
    }

    return mongodb.then((db) {
      var nodeCol = db.collection('nodes');
      var id = ObjectId.parse(nodeId);

      var doc = json;
      doc['_id'] = id;
      return nodeCol.update(where.eq('_id', id),
          modify.set('title', json['title'])
          .set('notes', json['notes'])
          .set('parents', json['parents'])
          .set('completed', json['completed']));
    }).then((_) {
      var ret = { 'objId' : nodeId,
              'type' : 'save'
      };

      return close(ret);
    });
  }
}