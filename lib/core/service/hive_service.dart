import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as syspath;

class HiveService {
  static final _boxKey = 'LOCAL_STORAGE';

  static final storage = Hive.box(_boxKey);

  static Future init() async {
    final dir = await syspath.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox(_boxKey);
  }

  static Future write(String keyName, dynamic values) async {
    return await storage.put(keyName, values);
  }

  static dynamic read(String keyName) {
    return storage.get(keyName);
  }

  static Future deleteAll() async {
    return await storage.clear();
  }
}
