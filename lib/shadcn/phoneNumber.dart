// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

class Phonenumber extends StatefulWidget {
  shadcn_flutter.PhoneNumber? phoneNumber;
  final ValueChanged<shadcn_flutter.PhoneNumber>? onPhoneNumberChanged;

  Phonenumber(
      {super.key, this.onPhoneNumberChanged, required this.phoneNumber});

  @override
  State<Phonenumber> createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: shadcn_flutter.PhoneInput(
            initialCountry: shadcn_flutter.Country.madagascar,
            onChanged: (value) {
              widget.onPhoneNumberChanged!(value);
            },
          ),
        ),
      ],
    );
  }
}
