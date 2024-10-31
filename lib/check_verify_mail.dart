import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koodiarana/Provider.dart';
import 'package:koodiarana/send_data.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CheckVerifyMail extends StatefulWidget {
  const CheckVerifyMail({super.key});

  @override
  State<CheckVerifyMail> createState() => _CheckVerifyMailState();
}

class _CheckVerifyMailState extends State<CheckVerifyMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification mail"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.00),
            child: Column(
              children: [
                const Text(
                    "Une mail a ete envoye , veuillez verifier et cliquez ce bouton ci-dessus apres avoir ouvrir le lien de verification  dans le mail"),
                const SizedBox(
                  height: 16.00,
                ),
                ShadButton(
                  child: const Text("Mail Verifier"),
                  onPressed: () async {
                    final user = Provider.of<UserVerify>(context, listen: false)
                        .getUser();
                    SendData sendData = SendData();
                    final response = await sendData.goData(
                        "http://192.168.43.41:9999/check-confirm",
                        user.toJson());
                    if (response.statusCode == 200) {
                      final body = jsonDecode(response.body);
                      if ("OK".compareTo(body['response']) == 0) {
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Veuillez verifier votre mail",
                            toastLength: Toast.LENGTH_LONG);
                      }
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
