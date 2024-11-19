import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

class VerifyOtp extends StatefulWidget {
  String email;
   VerifyOtp({super.key,required this.email});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Veriication par OTP'),
      ),
      body:   Padding(padding: const EdgeInsets.all(16.00),child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const Text("On a envoye un email qui a l'OTP pour recuperer votre mot de passe"),
          const SizedBox(height: 16.00,),
          shadcn_flutter.InputOTP(
                                    children: [
                                      shadcn_flutter.InputOTPChild.character(
                                          allowDigit: true),
                                      shadcn_flutter.InputOTPChild.character(
                                          allowDigit: true),
                                      shadcn_flutter.InputOTPChild.character(
                                          allowDigit: true),
                                      shadcn_flutter.InputOTPChild.separator,
                                      shadcn_flutter.InputOTPChild.character(
                                          allowDigit: true),
                                      shadcn_flutter.InputOTPChild.character(
                                          allowDigit: true),
                                      shadcn_flutter.InputOTPChild.character(
                                          allowDigit: true),
                                    ],
                                  ),

        ],),
      ),),
    );
  }
}