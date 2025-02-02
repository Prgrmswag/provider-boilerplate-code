import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_boilercode/resources/components/round_button.dart';
import 'package:provider_boilercode/view_model/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Creating instance of AuthviewModel to call auth apis .
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          const Text('Login screen '),

          RoundButton(
            loading: authViewModel.loading,
              title: 'Login',
              onPress: () {
                Map data = {
                  'username': userNameController.text.toString(),
                  'password': passwordController.text.toString()
                };

                authViewModel.loginApi(data, context);
              })

          // ElevatedButton(

          //     onPressed: () {
          // Map data = {
          //   'username': userNameController.text.toString(),
          //   'password': passwordController.text.toString()
          // };

          // authViewModel.loginApi(data, context);
          //     },
          //     child: const Text('Login'))
        ],
      ),
    );
  }
}
