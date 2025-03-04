import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalDatabase {
  void writeData(String key, dynamic data);
  dynamic readData(String key);
  void deleteData(String key);
}

class HiveLocalDatabase implements ILocalDatabase {
  final _myBox = Hive.box('data');

  @override
  void deleteData(String key) {
    _myBox.delete(key);
    try {
      print(
        _myBox.get(key),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  dynamic readData(String key) {
    try {
      print(
        _myBox.get(key),
      );
      return _myBox.get(key);
    } catch (e) {
      print(e);
    }
  }

  @override
  void writeData(String key, data) {
    _myBox.put(key, data);
    print(
      _myBox.get(key),
    );
  }
}
//keys:
// 'categoryURL' gets the image url for each category LIst<STRING>
