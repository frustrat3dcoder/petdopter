import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  late Box box;
  Future<void> init(String boxName) async {
    await Hive.initFlutter();
    box = await Hive.openBox(boxName);
  }

  void storeValue(String boxName, String key, String value) {
    box.put(key, value);
  }

  retrieveValue(String boxName, String key) {
    return box.get(key);
  }

  void deleteValue(String boxName, String key) {
    box.delete(key);
  }

  void clearAllBoxes() {
    Hive.close();
    Hive.deleteFromDisk();
  }
}
