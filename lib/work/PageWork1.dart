import 'package:flutter/material.dart';
import 'package:koodiarana/services/Provider.dart';
import 'package:koodiarana/delayed_animation.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageWork1 extends StatefulWidget {
  const PageWork1({super.key});
  @override
  State<PageWork1> createState() => _Page3();
}

class _Page3 extends State<PageWork1> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
          title: const DelayedAnimation(
            delay: 200,
            child: Text(
              'Activites',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.normal),
            ),
          ),
          actions: [
            DelayedAnimation(
              delay: 200,
              child: Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(right: 16.00),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),

                    boxShadow: const [
                      BoxShadow(
                          blurStyle: BlurStyle.solid,
                          color: Color.fromARGB(255, 91, 91, 91),
                          offset: Offset(2, 2))
                    ],
                    color: Provider.of<ManageLogin>(context, listen: false)
                            .getReady()
                        ? Colors.green[400]
                        : Colors.red[400],
                    // image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: NetworkImage(user!.photoURL.toString()))),
                  )),
            )
          ]),
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
                                    Navigator.pop(context);
                                  },
                                  child: const Text('NON'))
                            ],
                          );
                        });
                  }

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
                            Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ],
                        )),
                    child: Card(
                      elevation: 3.00,
                      child: ListTile(
                        leading: Icon(Icons.watch_later,
                            color: listReservation[i].goNow
                                ? Colors.red
                                : Colors.green),
                        title: Text(listReservation[i].description),
                        subtitle: Text(
                            '${listReservation[i].amenity},${listReservation[i].road},${listReservation[i].suburb},${listReservation[i].state}'),
                        trailing: Text(
                            '${listReservation[i].timeOfDay.hour}:${listReservation[i].timeOfDay.minute}'),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return confirmationDismiss(context, description);
                    },
                    onDismissed: (direction) {},
                  );
                },
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const
                //  Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                DelayedAnimation(
                    delay: 500,
                    child: Text('Passées',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 30))),
                //   ],
                // ),
                const SizedBox(height: 10.0),
                listReservation.isEmpty
                    ? const DelayedAnimation(
                        delay: 900,
                        child: Text(
                          'Vous n\'avez pas une activite a faire',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.00,
                          ),
                        ))
                    : Expanded(
                        child: DelayedAnimation(
                            delay: 1500, child: listTileReservation())),
              ],
            );
          },
        ),
      ),
    );
  }
}
