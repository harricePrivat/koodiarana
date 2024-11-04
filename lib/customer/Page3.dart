import 'package:flutter/material.dart';
import 'package:koodiarana/services/Provider.dart';
import 'package:koodiarana/delayed_animation.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

class Page3 extends StatefulWidget {
  const Page3({super.key});
  @override
  State<Page3> createState() => _Page3();
}

class _Page3 extends State<Page3> {
  ShadPopoverController popover = ShadPopoverController();

  TimeOfDay _timeOfDay = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    //  final textTheme = ShadTheme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          title: const DelayedAnimation(
        delay: 200,
        child: Text(
          'Activites',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.normal),
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.00),
        child: Consumer<ManageReservation>(
          builder: (context, manageReservation, child) {
            final listReservation = manageReservation.listReservation;

            Widget listTileReservation() {
              return ListView.builder(
                itemCount: listReservation.length,
                itemBuilder: (context, i) {
                  String description = listReservation[i].description;
                  Future<bool?> confirmationDismiss(
                      BuildContext context, String description) async {
                    return showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirmer la suppression'),
                            content: Text(
                                'Voulez-vous vraimer supprimer $description?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    //context.pop();
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: 'Suppression reussie');
                                    setState(() {
                                      manageReservation.removeReservation(i);
                                    });
                                  },
                                  child: const Text('OUI')),
                              TextButton(
                                  onPressed: () {
                                    // context.pop();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('NON'))
                            ],
                          );
                        });
                  }

                  TextEditingController controller = TextEditingController(
                      text: listReservation[i].description);
                  return Dismissible(
                    key: Key(i.toString()),
                    background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                        alignment: Alignment.centerRight,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 50.0,
                            ),
                            // Icon(
                            //   Icons.delete_forever,
                            //   color: Colors.white,
                            //   size: 50.0,
                            // ),
                          ],
                        )),
                    child: GestureDetector(
                      onTap: () {
                        shadcn_flutter.showDialog(
                          context: context,
                          builder: (context) => ShadDialog(
                            title: const Text(
                                'Modifier ou supprimer une information'),
                            description: const Text(
                                "Vous pouvez modifier/supprimer seulement le titre et l'heure (si pas maintenant)"),
                            actions: [
                              ShadButton.destructive(
                                onPressed: () {
                                  manageReservation.removeReservation(i);
                                  Fluttertoast.showToast(
                                      msg: 'Suppression reussie');
                                  Navigator.pop(context);
                                },
                                child: const Text('Supprimer'),
                              ),
                              ShadButton(
                                child: const Text('Sauvegarder le changement'),
                                onPressed: () {
                                  if (controller.text != "") {
                                    manageReservation.changeDescription(
                                        i, controller.text);
                                    manageReservation.changeTime(i, _timeOfDay);
                                    Fluttertoast.showToast(
                                        msg: 'Modification réussie',
                                        toastLength: Toast.LENGTH_SHORT);
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Ne pas laisser vide la description",
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                },
                              ),
                            ],
                            child: Container(
                              width: 375,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ShadInputFormField(
                                    controller: controller,
                                    label: const Text('Description'),
                                    //  initialValue: 'Brice',
                                    // listReservation[i].description,
                                  ),
                                  buildTimeField(context, listReservation[i])
                                ],
                              ),
                            ),
                          ),

                          // final FormController controller = FormController();
                          // return AlertDialog(
                          //   title: const Text('Edit profile'),
                          //   content: Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const Text(
                          //           'Make changes to your profile here. Click save when you\'re done'),
                          //       const Gap(16),
                          //       Form(
                          //         controller: controller,
                          //         child: const FormTableLayout(rows: [
                          //           FormField<String>(
                          //             key: FormKey(#name),
                          //             label: Text('Name'),
                          //             child: TextField(
                          //               initialValue:
                          //                   'Thito Yalasatria Sunarya',
                          //             ),
                          //           ),
                          //           FormField<String>(
                          //             key: FormKey(#username),
                          //             label: Text('Username'),
                          //             child: TextField(
                          //               initialValue: '@sunaryathito',
                          //             ),
                          //           ),
                          //         ]),
                          //       ).withPadding(vertical: 16),
                          //     ],
                          //   ),
                          //   actions: [
                          //     PrimaryButton(
                          //       child: const Text('Save changes'),
                          //       onPressed: () {
                          //         Navigator.of(context)
                          //             .pop(controller.values);
                          //       },
                          //     ),
                          //   ],
                          // );
                        );
                      },
                      child: Card(
                        elevation: 3.00,
                        child: ListTile(
                          leading: Icon(Icons.watch_later,
                              color: listReservation[i].goNow
                                  ? Colors.red
                                  : Colors.green),
                          title: Text(listReservation[i].description),
                          subtitle: Text(
                              '${listReservation[i].amenity} ${listReservation[i].road},${listReservation[i].suburb},${listReservation[i].state}'),
                          trailing: Text(
                              '${listReservation[i].timeOfDay.hour.toString()}: ${listReservation[i].timeOfDay.minute.toString()}'),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return confirmationDismiss(context, description);
                    },
                    onDismissed: (direction) {},
                  );
                  //   );
                },
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DelayedAnimation(
                        delay: 600,
                        child: Text('Passées', style: TextStyle(fontSize: 30))),
                    DelayedAnimation(
                      delay: 1000,
                      child: IconButton(
                        onPressed: () {
                          Provider.of<BottomTabManager>(context, listen: false)
                              .goToMaps();
                        },
                        icon: const Icon(Icons.add_task_rounded),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                listReservation.isEmpty
                    ? const DelayedAnimation(
                        delay: 1300,
                        child: Text(
                          'Vous n\'avez pas une activite recente',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.00,
                          ),
                        ))
                    : Expanded(
                        child: DelayedAnimation(
                            delay: 1300, child: listTileReservation())),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTimeField(BuildContext context, listReservation) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStateModal) {
      return Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  final timeOfDay = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  setStateModal(() {
                    if (timeOfDay != null) {
                      //   print(timeOfDay);
                      _timeOfDay = timeOfDay;
                    }
                  });
                },
                child: const Text(
                  'Temps:',
                  // style: GoogleFonts.openSans(
                  //   fontSize: 21.0,
                  //   fontWeight: FontWeight.w700,
                  //   color: Colors.grey,
                  // ),
                ),
              ),
              Text(
                _timeOfDay.format(context),
              ),
              IconButton(
                icon: const Icon(Icons.watch_later_outlined),
                onPressed: () async {
                  if (!listReservation.goNow) {
                    final timeOfTheDay = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );
                    setStateModal(() {
                      if (timeOfTheDay != null) {
                        // print(_timeOfDay);
                        _timeOfDay = timeOfTheDay;
                      }
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
    });
  }
}
