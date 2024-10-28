import 'package:flutter/material.dart';
import 'package:koodiarana/delayed_animation.dart';
import 'package:koodiarana/shadcn/DatePicker.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

class AddaccountWork extends StatefulWidget {
  const AddaccountWork({super.key});

  @override
  State<AddaccountWork> createState() => _AddaccountState();
}

class _AddaccountState extends State<AddaccountWork>
    with SingleTickerProviderStateMixin {
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shadcn_flutter.StepperController controller =
        shadcn_flutter.StepperController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('S\'inscrire Chauffeur'),
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
                        delay: 300,
                        child: shadcn_flutter.StepContainer(
                          actions: [
                            const shadcn_flutter.SecondaryButton(
                              child: Text('Precedent'),
                            ),
                            shadcn_flutter.PrimaryButton(
                                child: const Text('Suivant'),
                                onPressed: () {
                                  controller.nextStep();
                                }),
                          ],
                          child: SizedBox(
                              // index: 2,
                              height: 270,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  inputField(
                                      nom, 'Entrez votre nom:', 'ex: NARIVELO'),
                                  const SizedBox(
                                    height: 8.00,
                                  ),
                                  inputField(prenom, 'Entrez votre prenom:',
                                      'ex: Brice Privat'),
                                  const SizedBox(
                                    height: 8.00,
                                  ),
                                  const shadcn_flutter.Text(
                                    'Entrez votre date de naissance:',
                                    style: shadcn_flutter.TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(16.00),
                                    child: Datepicker(),
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
                    title: const Text('Step 2'),
                    contentBuilder: (context) {
                      return shadcn_flutter.StepContainer(
                        actions: [
                          shadcn_flutter.SecondaryButton(
                            child: const Text('Prev'),
                            onPressed: () {
                              controller.previousStep();
                            },
                          ),
                          shadcn_flutter.PrimaryButton(
                              child: const Text('Next'),
                              onPressed: () {
                                controller.nextStep();
                              }),
                        ],
                        child: Container(
                          // index: 2,
                          height: 200,
                        ),
                      );
                    },
                  ),
                  shadcn_flutter.Step(
                    title: const Text('Step 3'),
                    contentBuilder: (context) {
                      return shadcn_flutter.StepContainer(
                        actions: [
                          shadcn_flutter.SecondaryButton(
                            child: const Text('Prev'),
                            onPressed: () {
                              controller.previousStep();
                            },
                          ),
                          shadcn_flutter.PrimaryButton(
                              child: const Text('Finish'),
                              onPressed: () {
                                controller.nextStep();
                              }),
                        ],
                        child: Container(
                          // index: 2,
                          height: 200,
                        ),
                        // child: const shadcn_flutter.NumberedContainer(
                        //   index: 3,
                        //   height: 200,
                        // ),
                      );
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget inputField(
      TextEditingController nom, String label, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shadcn_flutter.Text(
          label,
          style: const shadcn_flutter.TextStyle(fontWeight: FontWeight.w600),
        ),
        shadcn_flutter.TextField(
          controller: nom,
          useNativeContextMenu: true,
          placeholder: placeholder,
        ),
      ],
    );
  }
}
