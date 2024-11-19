import 'package:flutter/material.dart';

import 'shadcn/PasswordInput.dart';

class ChangePassword extends StatefulWidget {
  String email;
  ChangePassword({super.key, required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController mdp = TextEditingController();
  TextEditingController remdp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Changer mon mot de passe"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              PasswordInput(
                  controller: mdp, color: Theme.of(context).primaryColor),
              const SizedBox(
                height: 16.00,
              ),
              PasswordInput(
                  controller: remdp, color: Theme.of(context).primaryColor),
            ],
          )
        ],
      ),
    );
  }
}
