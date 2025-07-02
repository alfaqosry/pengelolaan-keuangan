import 'package:get/get.dart';

import '../controllers/create_pendapatan_controller.dart';

class CreatePendapatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePendapatanController>(
      () => CreatePendapatanController(),
    );
  }
}
