import 'dart:convert';

import "package:mobx/mobx.dart";
import "package:http/http.dart" as http;

part "controller.g.dart";

class Controller = _Controller with _$Controller;

abstract class _Controller with Store {
  @observable
  var json;

  @action
  requestData() async {
    var url = Uri.parse("https://swapi.dev/api/people/1");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      json = jsonDecode(response.body);
    }
  }
}
