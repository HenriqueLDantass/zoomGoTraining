import 'package:flutter/material.dart';
import 'package:gotraining/modules/login/mocks/login_mock.dart';

class LoginStore extends ChangeNotifier {
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool verifyLogin(String email, String password) {
    final user = AuthService().mockUsers.firstWhere(
          (user) => user.email == email && user.password == password,
        );
    // ignore: unnecessary_null_comparison
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  checkboxValue(bool? value) {
    isChecked = value!;
    notifyListeners();
  }
}
