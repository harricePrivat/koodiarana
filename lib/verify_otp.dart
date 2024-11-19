import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:koodiarana/change_password.dart';
import 'package:koodiarana/services/send_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VerifyOtp extends StatefulWidget {
  String email;
  VerifyOtp({super.key, required this.email});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification par OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.00),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                  "On a envoye un email qui a l'OTP pour recuperer votre mot de passe"),
              const SizedBox(
                height: 16.00,
              ),
              FormBuilderTextField(
                name: "otp",
                controller: controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: const TextInputType.numberWithOptions(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Ce champ est obligatoire"),
                ]),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16.00,
              ),
              ShadButton(
                child: const Text('Recuperer votre mot de passe'),
                onPressed: () async {
                  final response = await SendData().goData(
                      "${dotenv.env['URL']}/verify-otp",
                      {"mail": widget.email, "otp": controller.text});
                  if (response.statusCode == 200) {
                    final object = jsonDecode(response.body);
                    if (object['message'] == "OK") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangePassword(email: widget.email)));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
