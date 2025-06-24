import 'package:get/get.dart';

import '../controllers/isi_profile_controller.dart';

class IsiProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IsiProfileController>(
      () => IsiProfileController(),
    );
  }
}
