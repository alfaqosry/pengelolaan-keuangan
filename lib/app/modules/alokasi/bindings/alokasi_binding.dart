import 'package:get/get.dart';

import '../controllers/alokasi_controller.dart';

class AlokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlokasiController>(() => AlokasiController());
  }
}
