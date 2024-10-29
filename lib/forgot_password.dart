import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'shadcn/phoneNumber.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  shadcn_flutter.PhoneNumber? phoneNumber;
  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mot de passe oublie"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.00),
            child: Column(
              children: [
                Text(
                  "Ici , vous pouvez recuperer votre compte en ajoutant votre numero telephone ou votre addresse mail",
                  style: themeText.displayMedium,
                ),
                const SizedBox(
                  height: 32.00,
                ),
                Text('Entrez votre numero de telephone',
                    style: themeText.displaySmall),
                Phonenumber(
                    phoneNumber: phoneNumber, onPhoneNumberChanged: (value) {}),
                const SizedBox(
                  height: 16.00,
                ),
                const ShadButton(child: Text("Recuperer votre compte")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
