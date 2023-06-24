import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  late Box box;
  Future<void> init(String boxName) async {
    await Hive.initFlutter();
    box = await Hive.openBox(boxName);
  }

  void storeValue(String key, dynamic value) {
    box.put(key, value);
  }

  retrieveValue(String key) {
    return box.get(key);
  }

  void deleteValue(String key) {
    box.delete(key);
  }

  void clearAllBoxes() {
    Hive.close();
    Hive.deleteFromDisk();
  }
}
