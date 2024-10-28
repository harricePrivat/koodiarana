import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:koodiarana/Page1.dart';
import 'package:koodiarana/Page2.dart';
import 'package:koodiarana/Page3.dart';
import 'package:koodiarana/Page4.dart';
import 'package:koodiarana/Provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});
  @override
  State<Accueil> createState() => _Accueil();
}

class _Accueil extends State<Accueil> {
//  int currentIndex = 0;
  late StreamSubscription<List<ConnectivityResult>> subscription;
  String connectionStatus = 'Unknow';
  String noConnexion = "Pas de connexion internet";
  String connexion = "Connexion internet restaure";
  bool? connex;
  List<Widget> listWidget = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4()
  ];

  void connectivitySnackBar(Widget message) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: message,
    //   duration: const Duration(seconds: 3),
    // ));
    // ShadToaster.of(context).show(
    //   ShadToast(
    //     description: message,
    //     duration: const Duration(seconds: 5),
    //   ),
    // );
    shadcn_flutter.showToast(
        context: context,
        showDuration: const Duration(milliseconds: 3000),
        builder: buildToast);
  }

  Widget buildToast(
    BuildContext context,
    shadcn_flutter.ToastOverlay overlay,
  ) {
    return shadcn_flutter.SurfaceCard(
      child: shadcn_flutter.Basic(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            connex!
                ? const Icon(
                    Icons.wifi,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.wifi_off,
                    color: Colors.red,
                  ),
            const SizedBox(
              width: 8.00,
            ),
            Expanded(
              child: Text(
                connex! ? connexion : noConnexion,
                style: const TextStyle(decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        trailing: shadcn_flutter.PrimaryButton(
            size: shadcn_flutter.ButtonSize.small,
            onPressed: () {
              overlay.close();
            },
            child: const Text(
              'Fermer',
              style: TextStyle(decoration: TextDecoration.none),
            )),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      setState(() {
        //   Provider.of<ManageLogin>(context, listen: true).setConnectivity(result);
        connectivitySnackBar(checkConnexion(result));
        Provider.of<ManageLogin>(context, listen: false)
            .setConnectivity(result);
        print('Changement');
      });
    });
  }

  Widget checkConnexion(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      connex = false;
      return Text(noConnexion);
    } else {
      connex = true;
      return Text(connexion);
    }
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomTabManager>(
      builder: (context, tabManager, child) {
        void onTapped(value) {
          tabManager.changeTab(value);
        }

        return Scaffold(
          backgroundColor: const Color.fromARGB(240, 255, 255, 255),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 550),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: listWidget[tabManager.tabManager],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            currentIndex: tabManager.tabManager,
            onTap: onTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Maps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_task),
                label: 'Activité',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Compte',
              ),
            ],
          ),
        );
      },
    );
  }
}
