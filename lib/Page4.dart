import 'package:flutter/material.dart';
import 'package:koodiarana/Animation.dart';
import 'package:koodiarana/MentionLegale.dart';
//import 'package:go_router/go_router.dart';
//import 'package:koodiarana/Parametres.dart';
import 'package:koodiarana/Provider.dart';
import 'package:koodiarana/confidetialite.dart';
import 'package:koodiarana/delayed_animation.dart';
import 'package:koodiarana/historique.dart';
import 'manageAccount/manageAccount.dart';
import 'MessageEvolution.dart';

//import 'package:koodiarana/services/authentification.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});
  @override
  State<Page4> createState() => _Page4();
}

class _Page4 extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
        appBar: AppBar(
            elevation: 30,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30.00))),
            leading: IconButton(
                iconSize: 20,
                onPressed: () {
                  Provider.of<BottomTabManager>(context, listen: false)
                      .goToAccueil();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 95),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.00, left: 16.00, right: 16.00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DelayedAnimation(
                        delay: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                user!.displayName.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 20),
                              ),
                            ),
                            //Icon(Icons.person, size: 50)
                            Container(
                              height: 70,
                              width: 70,
                              padding: const EdgeInsets.all(50.00),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          user.photoURL.toString()))),
                            ),
                          ],
                        ),
                      ),
                      DelayedAnimation(
                          delay: 500,
                          child: Container(
                            padding: const EdgeInsets.all(7.00),
                            height: 35,
                            width: 63,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.00),
                              color: const Color.fromARGB(255, 129, 126, 126),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.star),
                                Text('5.0'),
                              ],
                            ),
                          ))
                    ],
                  ),
                ))),
        body: Padding(
          padding: const EdgeInsets.all(16.00),
          child: ListView(
            children: [
              DelayedAnimation(
                delay: 900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<ManageLogin>(context, listen: false)
                            .reFirstLoginCustomer(true);
                      },
                      child: parameters('Aide', const Icon(Icons.help)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicyScreen()));
                      },
                      child:
                          parameters('Confidetialite', const Icon(Icons.lock)),
                    ),
                    GestureDetector(
                      onTap:
                          Provider.of<BottomTabManager>(context, listen: false)
                              .goToActivity,
                      child:
                          parameters('Activite', const Icon(Icons.motorcycle)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15.00,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              // ListTile(
              //     leading: const Icon(Icons.settings),
              //     title: const Text(
              //       'Parametres',
              //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //     ),
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const Parametres()));
              //     }),
              DelayedAnimation(
                  delay: 1200,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.mail),
                        title: const Text(
                          'Messages',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context, FadePageRoute(page: const Message()));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: const Text(
                          'Historique de deplacement',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HistoriqueCustomer()));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_2),
                        title: const Text(
                          'Gerer le compte Uber',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ManageAccount()));
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LegalNoticeScreen()));
                        },
                        child: const ListTile(
                          leading: Icon(Icons.warning),
                          title: Text(
                            'Mention Legale',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      OutlinedButton(
                          // highlightElevation: 2.00,
                          // elevation: 2.00,
                          onPressed: () {
                            Provider.of<BottomTabManager>(context,
                                    listen: false)
                                .goToAccueil();
                            _logout();
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) => Login()));
                          },
                          child: const Text(
                            'Deconnexion',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.red,
                                fontSize: 20),
                          ))
                    ],
                  ))
            ],
          ),
        ));
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    //  print("User logged out");
  }
}

Widget parameters(String descri, Icon icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color.fromARGB(255, 129, 126, 126),
    ),
    padding: const EdgeInsets.all(12.00),
    width: 100,
    height: 90,
    child: Center(
      child: Column(
        children: [
          icon,
          const SizedBox(
            height: 10.00,
          ),
          Expanded(
              child: Text(
            descri,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ))
        ],
      ),
    ),
  );
}
