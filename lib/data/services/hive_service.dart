import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
  }

  void storeValue<T>(String boxName, String key, T value) {
    final box = Hive.box<T>(boxName);
    box.put(key, value);
  }

  T? retrieveValue<T>(String boxName, String key) {
    final box = Hive.box<T>(boxName);
    return box.get(key);
  }

  void deleteValue<T>(String boxName, String key) {
    final box = Hive.box<T>(boxName);
    box.delete(key);
  }

  void clearAllBoxes() {
    Hive.close();
    Hive.deleteFromDisk();
  }
}
