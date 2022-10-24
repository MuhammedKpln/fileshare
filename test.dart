import 'dart:convert';

void main(List<String> args) {
  final selam = {'selam': 'as'};

  final jsoncoded = jsonEncode(selam);

  print(jsoncoded);

  print(jsonEncode(jsoncoded));
  print(jsonDecode(jsoncoded)['selam']);
}
