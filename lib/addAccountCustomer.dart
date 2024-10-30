import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koodiarana/delayed_animation.dart';
import 'package:koodiarana/send_data.dart';
import 'package:koodiarana/services/verify_mail.dart';
import 'package:koodiarana/shadcn/DatePicker.dart';
import 'package:koodiarana/shadcn/phoneNumber.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

class AddaccountCustomer extends StatefulWidget {
  const AddaccountCustomer({super.key});

  @override
  State<AddaccountCustomer> createState() => _AddaccountState();
}

class _AddaccountState extends State<AddaccountCustomer>
    with SingleTickerProviderStateMixin {
  DateTime? dateTime;
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController remdp = TextEditingController();
  TextEditingController mdp = TextEditingController();
  shadcn_flutter.PhoneNumber? phoneNumber;
  SendData sendData = SendData();
  VerifyMail verifyMail = VerifyMail();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final shadcn_flutter.StepperController controller =
        shadcn_flutter.StepperController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('S\'inscrire client'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.00),
          child: ListView(
            children: [
              shadcn_flutter.Stepper(
                controller: controller,
                direction: Axis.vertical,
                steps: [
                  shadcn_flutter.Step(
                    // icon: const Icon(Icons.person),
                    title: const Text('Votre information:'),
                    contentBuilder: (context) {
                      return DelayedAnimation(
                        delay: 100,
                        child: shadcn_flutter.StepContainer(
                          actions: [
                            const shadcn_flutter.SecondaryButton(
                              child: Text('Precedent'),
                            ),
                            shadcn_flutter.PrimaryButton(
                                child: const Text('Suivant'),
                                onPressed: () {
                                  (nom.text.trim() != "" &&
                                          dateTime != null &&
                                          prenom.text.trim() != "")
                                      ? controller.nextStep()
                                      : Fluttertoast.showToast(
                                          msg:
                                              "Veuillez remplir tous les champs");
                                }),
                          ],
                          child: SizedBox(
                              // index: 2,
                              height: 270,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  inputField(nom, 'Entrez votre nom:',
                                      'ex: NARIVELO', color),
                                  const SizedBox(
                                    height: 8.00,
                                  ),
                                  inputField(prenom, 'Entrez votre prenom:',
                                      'ex: Brice Privat', color),
                                  const SizedBox(
                                    height: 8.00,
                                  ),
                                  const shadcn_flutter.Text(
                                    'Entrez votre date de naissance:',
                                    style: shadcn_flutter.TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.00),
                                    child: Datepicker(
                                      dateTime: dateTime,
                                      onValueChanged: (value) {
                                        dateTime = value;
                                      },
                                    ),
                                  )
                                ],
                              )),
                          // child: const NumberedContainer(
                          //   index: 1,
                          //   height: 200,
                          // ),
                        ),
                      );
                    },
                  ),
                  shadcn_flutter.Step(
                    title: const Text('Votre information importante'),
                    contentBuilder: (context) {
                      return DelayedAnimation(
                          delay: 300,
                          child: shadcn_flutter.StepContainer(
                            actions: [
                              shadcn_flutter.SecondaryButton(
                                child: const Text('Precedent'),
                                onPressed: () {
                                  controller.previousStep();
                                },
                              ),
                              shadcn_flutter.PrimaryButton(
                                  child: const Text('Suivant'),
                                  onPressed: () {
                                    (email.text.trim() != "" &&
                                            phoneNumber!.value!.trim() != "")
                                        ? controller.nextStep()
                                        : Fluttertoast.showToast(
                                            msg:
                                                "Veuillez remplir tous les champs");
                                  }),
                            ],
                            child: SizedBox(
                              // index: 2,
                              height: 200,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Votre adrresse e-mail:'),
                                  shadcn_flutter.TextField(
                                    controller: email,
                                    useNativeContextMenu: true,
                                    placeholder: '@gmail.com',
                                    style:
                                        shadcn_flutter.TextStyle(color: color),
                                  ),
                                  const SizedBox(
                                    height: 16.00,
                                  ),
                                  const Text('Votre numéro de téléphone:'),
                                  Phonenumber(
                                    phoneNumber: phoneNumber,
                                    onPhoneNumberChanged: (value) {
                                      phoneNumber = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                  shadcn_flutter.Step(
                    title: const Text('Verification: '),
                    contentBuilder: (context) {
                      return DelayedAnimation(
                          delay: 300,
                          child: shadcn_flutter.StepContainer(
                            actions: [
                              shadcn_flutter.SecondaryButton(
                                child: const Text('Precedent'),
                                onPressed: () {
                                  controller.previousStep();
                                },
                              ),
                              shadcn_flutter.PrimaryButton(
                                  child: const Text('Terminer'),
                                  onPressed: () async {
                                    // phoneNumber = Phonenumber().getNumber();
                                    //controller.nextStep();
                                    if (mdp.text != '' && remdp.text != '') {
                                      if (remdp.text == mdp.text) {
                                        await verifyMail.registerUser(
                                            email.text, mdp.text);
                                        bool emailVerified =
                                            await verifyMail.isEmailVerified();
                                        if (emailVerified) {
                                          sendData.goData(
                                              "http://192.168.43.41:9999/register",
                                              {
                                                "nom": nom.text,
                                                "prenom": prenom.text,
                                                "date_naissance":
                                                    dateTime.toString(),
                                                "email": email.text,
                                                "num": phoneNumber!.value!,
                                                "password": mdp.text
                                              });
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Verifiez votre mot de passe",
                                            toastLength: Toast.LENGTH_LONG);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Remplir tous les champs",
                                          toastLength: Toast.LENGTH_LONG);
                                    }
                                    // print(
                                    //     "votre date de naissance : $dateTime");
                                    // print("Votre nom: ${nom.text}");
                                    // print("Votre prenom: ${prenom.text}");
                                    // print("Votre email: ${email.text}");
                                    // print("Votre num: $phoneNumber");
                                  }),
                            ],
                            child: SizedBox(
                              // index: 2,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  inputField(mdp, "Votre mot de passe:",
                                      "*******", color),
                                  inputField(
                                      remdp,
                                      "Confirmation de votre mot de passe:",
                                      "*******",
                                      color),

                                  // shadcn_flutter.InputOTP(
                                  //   children: [
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.separator,
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 16.00,
                                  // ),
                                  // const shadcn_flutter.Text(
                                  //     'Code de verification adresse e-mail: '),
                                  // shadcn_flutter.InputOTP(
                                  //   children: [
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.separator,
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //     shadcn_flutter.InputOTPChild.character(
                                  //         allowDigit: true),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget inputField(TextEditingController nom, String label, String placeholder,
      Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shadcn_flutter.Text(
          label,
          style: shadcn_flutter.TextStyle(
              fontWeight: FontWeight.w600, color: color),
        ),
        shadcn_flutter.TextField(
          controller: nom,
          useNativeContextMenu: true,
          placeholder: placeholder,
          style: shadcn_flutter.TextStyle(color: color),
        ),
      ],
    );
  }
}
