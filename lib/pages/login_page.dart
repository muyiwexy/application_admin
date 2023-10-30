import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/app_controllers.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Enter E-mail",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.black)),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: "Enter Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.black)),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              final accountProvider =
                  Provider.of<AccountProvider>(context, listen: false);
              accountProvider
                  .createAccountSession(
                    email: emailController.text,
                    password: passwordController.text,
                  )
                  .then((value) => Navigator.pushNamed(context, "/home"));
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }
}
