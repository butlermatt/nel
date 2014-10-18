library nel.server;

import 'dart:async';
import 'package:vane/vane.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'lib/signin.dart';

@Route("/hello")
class HelloWorld extends Vane {
  var pipeline = [Log, This];

  @Route("")
  @Route("/{message}")
  Future hello(String message) {
    return close("Hello ${message != "" ? message : "World"}!");
  }
}

void main() => serve();

