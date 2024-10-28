import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'PageWork1.dart';
import 'package:koodiarana/PageWork2.dart';
import 'package:koodiarana/Provider.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;

class AccueilWork extends StatefulWidget {
  const AccueilWork({super.key});
  @override
  State<AccueilWork> createState() => _Accueil();
}

class _Accueil extends State<AccueilWork> {
//  int currentIndex = 0;
  late StreamSubscription<List<ConnectivityResult>> subscription;
  String connectionStatus = 'Unknow';
  String noConnexion = "Pas de connexion internet";
  String connexion = "Connexion internet restaure";
  bool? connex;

  List<Widget> listWidget = [const PageWork1(), const PageWork2()];

  void connectivitySnackBar(Widget message) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: message,
    //   duration: const Duration(seconds: 3),
    // ));
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

  Widget checkConnexion(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      connex = false;
      return const Text('Pas de connexion Internet');
    } else {
      connex = true;
      return const Text('Bonne Connexion Internet ');
    }
  }

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!
      // checkConnectivity();
      setState(() {
        //connectionStatus = (String)checkConnectivity(result.toString());
        connectivitySnackBar(checkConnexion(result));
      });
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomWork>(
      builder: (context, tabManager, child) {
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
            child: listWidget[tabManager.index],
          ),
          bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              //   selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(color: Colors.grey),
              currentIndex: tabManager.index,
              //  selectedLabelStyle: const TextStyle(color: Colors.black),
              onTap: (value) {
                tabManager.changeTab(value);
                //  print('Voici currentIndex:$tabManager.tabMan');
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.motorcycle), label: 'Acitivite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Compte')
              ]),
        );
      },
    );
  }
}
