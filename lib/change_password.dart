import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koodiarana/services/send_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:convert';
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
        body: Padding(
          padding: const EdgeInsets.all(16.00),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      'Vous pouvez maintenant changer votre mot de passe'),
                  const SizedBox(
                    height: 16.00,
                  ),
                  PasswordInput(
                      controller: mdp, color: Theme.of(context).primaryColor),
                  const SizedBox(
                    height: 16.00,
                  ),
                  PasswordInput(
                      controller: remdp, color: Theme.of(context).primaryColor),
                  const SizedBox(
                    height: 16.00,
                  ),
                  ShadButton(
                    child: const Text("Changer le mot de passe"),
                    onPressed: () async {
                      if (remdp.text == mdp.text) {
                        final response = await SendData().goData(
                            "${dotenv.env['URL']}/changePassword",
                            {"mail": widget.email, "newMdp": mdp.text});
                        if (response.statusCode == 200) {
                          final object = jsonDecode(response.body);
                          if (object['message'] == "OK") {
                            Fluttertoast.showToast(
                                msg: 'Votre mot de passe a bien ete change',
                                toastLength: Toast.LENGTH_LONG);
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Erreur de connexion',
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
