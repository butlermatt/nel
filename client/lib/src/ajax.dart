library nel.ajax;

import 'dart:html';
import 'dart:async';
import 'dart:convert' show JSON;
import 'nel_object.dart';

class Ajax {
  final Map headers = {'Content-Type' : 'application/json' };

  Future send(String location, NelObject model) {
    var data = JSON.encode(model.toJson());
    return HttpRequest.request(location,
                method: 'POST',
                sendData: data,
                requestHeaders: headers)
      .then((HttpRequest req) {
        var result = JSON.decode(req.responseText);
        print('Send result: $result');

        if(result.containsKey('error')) {
          throw new NelException(result['error']);
        }

        return new NelObject.fromJson(result);
    });
  }

  Future getNode([String objId]) {
    var url = '/node';
    if(objId != null) url += '/$objId';
    return HttpRequest.request(url, method: 'GET').then((HttpRequest req) {
      var result = JSON.decode(req.responseText);
      print('getNode response: $result');

      if(result.containsKey('error')) {
        var up = new NelException(result['error']);
        throw up;
      }

      return new NelObject.fromJson(result);
    });
  }
}