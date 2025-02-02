import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_boilercode/repository/auth_repository.dart';
import 'package:provider_boilercode/utils/utils.dart';
import 'package:provider_boilercode/view/home_screen.dart';
import 'package:provider_boilercode/view/login_screen.dart';

class AuthViewModel extends ChangeNotifier {
  final _myRepo = LoginRepository();
  bool _loading = false;

  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<dynamic> loginApi(dynamic data, BuildContext context) async {
    // When API is hit setLoading to true
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      // When API call is successful setLoading to false
      setLoading(false);
      Utils.toastMessage('Login successfull');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
      if (kDebugMode) {
        Utils.toastMessage(value.toString());
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      // When API call is unsuccessful setLoading to false

      setLoading(false);
      if (kDebugMode) {
        Utils.toastMessage(error.toString());

        print(error.toString());
      }
    });
  }

// Register api

  bool _registerLoading = false;
  bool get registerLoading => _registerLoading;

  setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  Future<dynamic> registerApi(dynamic data, BuildContext context) async {
    // When API is hit setLoading to true
    setRegisterLoading(true);

    _myRepo.registerApi(data).then((value) {
      // When API call is successful setLoading to false
      setRegisterLoading(false);
      Utils.toastMessage('Registration successfull');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
      if (kDebugMode) {
        Utils.toastMessage(value.toString());
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      // When API call is unsuccessful setLoading to false

      setRegisterLoading(false);
      if (kDebugMode) {
        Utils.toastMessage(error.toString());

        print(error.toString());
      }
    });
  }
}
