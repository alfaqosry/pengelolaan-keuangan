import 'package:get/get.dart';

import '../controllers/create_pengeluaran_controller.dart';

class CreatePengeluaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePengeluaranController>(
      () => CreatePengeluaranController(),
    );
  }
}
