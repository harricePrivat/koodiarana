import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    return ShadInputFormField(
      cursorColor: Colors.white,
      label: const Text('Mot de passe', style: TextStyle(color: Colors.white)),
      controller: widget.controller,
      placeholder: const Text('*******'),
      obscureText: obscure,
      prefix: const Padding(
        padding: EdgeInsets.all(4.0),
        child: ShadImage.square(
          size: 16,
          LucideIcons.lock,
          color: Colors.white,
        ),
      ),
      style: const TextStyle(color: Colors.white),
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
    );
  }
}
