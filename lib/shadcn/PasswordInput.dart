import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// ignore: must_be_immutable
class PasswordInput extends StatefulWidget {
  TextEditingController controller;
  PasswordInput({super.key, required this.controller});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      name: "password",
      cursorColor: Colors.white,
      controller: widget.controller,
      // placeholder: const Text('*******'),
      obscureText: obscure,
      decoration: InputDecoration(
        label:
            const Text('Mot de passe', style: TextStyle(color: Colors.white)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        hintText: '*******',
        prefix: const Padding(
          padding: EdgeInsets.all(4.0),
          child: ShadImage.square(
            size: 16,
            LucideIcons.lock,
            color: Colors.white,
          ),
        ),
        suffix: ShadButton(
          width: 24,
          height: 24,
          padding: EdgeInsets.zero,
          decoration: const ShadDecoration(
            secondaryBorder: ShadBorder.none,
            secondaryFocusedBorder: ShadBorder.none,
          ),
          icon: ShadImage.square(
            size: 16,
            obscure ? LucideIcons.eyeOff : LucideIcons.eye,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() => obscure = !obscure);
          },
        ),
      ),

      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Ce champ est obligatoire"),
        FormBuilderValidators.password(
            errorText:
                'au moins 8 caracteres , 1 majuscule, 1 minuscule,1 caracteres speciaux')
      ]),
      style: const TextStyle(color: Colors.white),
    );
  }
}
