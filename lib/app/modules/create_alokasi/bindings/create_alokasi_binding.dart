import 'package:get/get.dart';

import '../controllers/create_alokasi_controller.dart';

class CreateAlokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAlokasiController>(
      () => CreateAlokasiController(),
    );
  }
}
