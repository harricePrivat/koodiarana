import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
                FormBuilderTextField(
                  name: "forgot mdp",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "Entrez votre email",
                      prefix: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: ShadImage.square(
                          size: 16,
                          LucideIcons.mail,
                          color: Colors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Ce champ est obligatoire"),
                    FormBuilderValidators.email(
                        errorText: "L'email n'est valide")
                  ]),
                ),
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
