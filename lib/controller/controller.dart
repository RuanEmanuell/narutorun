import 'dart:convert';

import "package:mobx/mobx.dart";
import "package:http/http.dart" as http;

part "controller.g.dart";

class Controller = _Controller with _$Controller;

abstract class _Controller with Store {
  @observable
  bool died = false;

  @observable
  var score=0;
}
