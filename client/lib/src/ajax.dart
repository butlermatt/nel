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

        if(result.containsKey('error')) {
          throw new NelException(result['error']);
        }

        return new NelObject.fromJson(result);
    });
  }
}