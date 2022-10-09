import 'package:injectable/injectable.dart';

@LazySingleton()
class TestDi {
  sayHello() {
    print('Hello world!');
  }
}
