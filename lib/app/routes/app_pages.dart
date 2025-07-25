import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';
import '../modules/alokasi/bindings/alokasi_binding.dart';
import '../modules/alokasi/views/alokasi_view.dart';
import '../modules/create_alokasi/bindings/create_alokasi_binding.dart';
import '../modules/create_alokasi/views/create_alokasi_view.dart';
import '../modules/create_pendapatan/bindings/create_pendapatan_binding.dart';
import '../modules/create_pendapatan/views/create_pendapatan_view.dart';
import '../modules/create_pengeluaran/bindings/create_pengeluaran_binding.dart';
import '../modules/create_pengeluaran/views/create_pengeluaran_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/views/home_view.dart';
import '../modules/isi-profile/bindings/isi_profile_binding.dart';
import '../modules/isi-profile/views/isi_profile_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../widgets/main_navigation.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => MainNavigation(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NavigationController());
        Get.lazyPut(() => HomeController()); // jika kamu butuh juga
      }),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.ISI_PROFILE,
      page: () => IsiProfileView(),
      binding: IsiProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      page: () => const LaporanView(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PENGELUARAN,
      page: () => const CreatePengeluaranView(),
      binding: CreatePengeluaranBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PENDAPATAN,
      page: () => const CreatePendapatanView(),
      binding: CreatePendapatanBinding(),
    ),
    GetPage(
      name: _Paths.ALOKASI,
      page: () => const AlokasiView(),
      binding: AlokasiBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ALOKASI,
      page: () => const CreateAlokasiView(),
      binding: CreateAlokasiBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
  ];
}
