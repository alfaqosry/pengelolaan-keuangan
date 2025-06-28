import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  final namaUser = ''.obs;
  final user = Rxn<User>();
  void ambilNamaDariFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists && doc.data() != null) {
      namaUser.value = doc.data()!['displayName'] ?? '';
    }
  }

  @override
  void onInit() {
    user.value = FirebaseAuth.instance.currentUser;

    FirebaseAuth.instance.authStateChanges().listen((u) {
      user.value = u; 
      if (u != null) ambilNamaDariFirestore();
    });

    super.onInit();
  }
}
