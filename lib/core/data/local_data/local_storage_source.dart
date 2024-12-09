import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class LocalStorage extends GetxController {
  static GetStorage? storage;


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    storage ??= GetStorage();
    update();
  }

  //
  static Future<void> write(key, value) async {
    await storage != null
        ? await storage!.write(key, value)
        : await storage?.write(key, value);
  }

  static Future<dynamic> read(key) => storage!.read(key);

  static Future<void> remove(key) async {
      await storage!.remove(key);
  }

  static Future<void> eraseAll() async {
    storage!.erase();
  }
}
