import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koodiarana/shadcn/phoneNumber.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;
import 'package:shadcn_ui/shadcn_ui.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccount();
}

class _ManageAccount extends State<ManageAccount> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    shadcn_flutter.PhoneNumber phoneNumber = shadcn_flutter.PhoneNumber(
        shadcn_flutter.Country.madagascar, user!.phoneNumber.toString());
    // TextEditingController controller =
    //     TextEditingController(text: user!.displayName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerer mon compte'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.00),
            child: SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: Card(
                      color: Colors.red,
                      child: Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.black,
                            )),
                      )),
                )),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16.00),
            height: 100,
            width: 100,
            child: Container(
              height: 100,
              width: 100,
              // margin: const EdgeInsets.all(16.00),
              //  padding: const EdgeInsets.all(10.0), // Correction du padding
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      user.photoURL.toString()), // Utilisation de user.photoURL
                ),
              ),
            ),
          ),
          Expanded(
            // Ajout de Expanded ici pour permettre à ListView d'occuper l'espace restant
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Ici vous pouvez supprimer, modifier des informations sur votre compte.',
                        style: GoogleFonts.openSans(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      inputField("Votre nom:", user.displayName.toString()),
                      const SizedBox(
                        height: 16.0,
                      ),
                      inputField("Votre date de naissance:",
                          user.displayName.toString()),
                      const SizedBox(
                        height: 16.0,
                      ),
                      inputField("Votre adresse mail:", user.email.toString()),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const shadcn_flutter.Text("Votre numero de telephone:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Phonenumber(phoneNumber: phoneNumber),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const ShadButton(
                        child:
                            shadcn_flutter.Text("Sauvegarder les changements"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shadcn_flutter.Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        shadcn_flutter.TextField(
          initialValue: initialValue,
        ),
      ],
    );
  }
}
