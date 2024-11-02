import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:koodiarana/Provider.dart';
import 'package:koodiarana/ToQuit.dart';
import 'package:koodiarana/addAccountCustomer.dart';
import 'package:koodiarana/forgot_password.dart';
import 'package:koodiarana/send_data.dart';
import 'package:koodiarana/services/authentification.dart';
import 'package:koodiarana/shadcn/PasswordInput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter/services.dart';
import 'delayed_animation.dart';
import 'addAccountWork.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> with SingleTickerProviderStateMixin {
  bool isLoginProcessCustomer = false;
  bool isLoginProcessWork = false;
  TabController? _tabController;
  DateTime? lastPressed;
  TextEditingController mailNum = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ManageLogin().initializeApp();
    SystemChannels.platform.setMethodCallHandler((call) async {
      if (call.method == "SystemNavigator.pop") {
        if (lastPressed == null ||
            DateTime.now().difference(lastPressed!) <
                const Duration(seconds: 2)) {
          lastPressed = DateTime.now();
          Fluttertoast.showToast(
              msg: "Appuyez deux fois pou quitter",
              toastLength: Toast.LENGTH_LONG);
          return false;
        }
      }
      return true;
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        Provider.of<ManageLogin>(context, listen: false)
            .changeStatus((_tabController!.index == 0) ? true : false);
        //  print(Provider.of<ManageLogin>(context, listen: false).status);
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ManageLogin>(context).initializeApp();
    return ToQuit(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Se connecter:',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.00),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50.00)),
              child: Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(50.00),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/Accueil.jpeg'))),
              ),
            ),
          )
        ],
        elevation: 10,
        backgroundColor: Colors.black,
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 30),
            child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(
                    icon: Column(
                      children: [
                        Icon(
                          Icons.person_pin_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          'Client',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Tab(
                    icon: Column(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.white,
                        ),
                        Text(
                          'Chauffeur',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ])),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: tabView(
                      signInCustomer,
                      isLoginProcessCustomer,
                      isLoginProcessWork,
                      'Se connecter avec Google (Client)',
                    ),
                  ),
                ),
              );
            },
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: tabView(
                      signInWork,
                      isLoginProcessWork,
                      isLoginProcessCustomer,
                      'Se connecter avec Google (Chauffeur)',
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }

  signInWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('whoLogin', false);
    setState(() {
      isLoginProcessWork = true;
      AuthServiceWork().signInWithGoogle();
    });
    Timer(const Duration(seconds: 10), () {
      if (Provider.of<User?>(context, listen: false) == null) showToast();
      setState(() {
        isLoginProcessWork = false;
      });
    });
  }

  Future<void> showToast() {
    return Fluttertoast.showToast(
        msg: 'Erreur de connexion', toastLength: Toast.LENGTH_LONG);
  }

  Widget formulaire(String title, String describe) {
    TextStyle style = const TextStyle(color: Colors.white);
    return DelayedAnimation(
        delay: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.00),
          child: ShadCard(
            backgroundColor: Colors.transparent,
            title: Text(
              title,
              style: style,
            ),
            description: Text(describe),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShadButton(
                  child: const Text('Se connecter'),
                  onPressed: () async {
                    SendData sendData = SendData();
                    final response = await sendData.goData(
                        'http://192.168.43.41:9999/login',
                        {'mailNum': mailNum.text, 'mdp': password.text});
                    if (response.statusCode == 200) {
                      print(response.body);
                    }
                  },
                ),
                ShadButton.link(
                    onPressed: () {
                      title.compareTo('Client') == 0
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddaccountCustomer()))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddaccountWork()));
                    },
                    child: Text(
                      'S\'inscrire',
                      style: style,
                    ))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 14),
                FormBuilderTextField(
                  controller: mailNum,
                  name: "mailNum",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    label: Text('Mail ou Numero de telephone',
                        style: TextStyle(color: Colors.white)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.00)),
                    ),
                    hintText: "...@gmail.com ou +261....",
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Ce champ  est obligatoire"),
                  ]),
                ),
                const SizedBox(height: 16),
                PasswordInput(controller: password),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }

  Widget tabView(Function signInWork, bool isLoginProcessWork,
      bool isLoginProcessCustomer, String buttonName) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        // image: DecorationImage(
        //     opacity: 0.2,
        //     image: AssetImage('assets/Accueil.jpeg'),
        //     fit: BoxFit.cover)
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buttonName.compareTo("Se connecter avec Google (Client)") == 0
                ? formulaire('Client',
                    'Se connecter avec votre compte client Koodiarana')
                : formulaire('Chauffeur',
                    'Se connecter avec votre compte Chauffeur Koodiarana'),
            const SizedBox(
              height: 8.00,
            ),
            DelayedAnimation(
              delay: 700,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.00),
                child: ShadButton.link(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()));
                  },
                  child: const Text('Mot de passe oublié?',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
              height: 7.00,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Divider(
                  color: Colors.white,
                ),
                isLoginProcessWork
                    ? LoadingAnimationWidget.threeRotatingDots(
                        color: Colors.white,
                        size: 100,
                      )
                    : DelayedAnimation(
                        delay: 1100,
                        child: ShadButton(
                          // decoration: const BoxDecoration(
                          //   boxShadow: [
                          //     BoxShadow(
                          //         color: Color.fromARGB(255, 116, 115, 115),
                          //         blurRadius: 16.00)
                          //   ],
                          // ),
                          shadows: const [
                            BoxShadow(
                                blurRadius: 16.00,
                                color: Color.fromARGB(255, 120, 119, 119)),
                          ],
                          onPressed: () {
                            !isLoginProcessCustomer
                                ? signInWork()
                                : Fluttertoast.showToast(
                                    msg: 'Connexion a deux sens',
                                    toastLength: Toast.LENGTH_LONG);
                          },
                          width: 250,
                          height: 50,
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon(
                                //   ,
                                //   color: Colors.red,
                                //   size: 25,
                                // ),
                                Image.asset(
                                  'assets/google.png',
                                  width: 25,
                                  height: 25,
                                ),
                                const Text('Se connecter avec Google')
                              ],
                            ),
                          ),
                        ),
                      ),
                // : IconButton(
                //     onPressed: () {
                //       !isLoginProcessCustomer
                //           ? signInWork()
                //           : Fluttertoast.showToast(
                //               msg: 'Connexion a deux sens',
                //               toastLength: Toast.LENGTH_LONG);
                //     },
                //     icon: const Icon(
                //       FontAwesomeIcons.google,
                //       color: Colors.red,
                //       size: 40,
                //     )),
                const Divider(
                  color: Colors.white,
                )
              ],
            )
          ]),
    );
  }

  signInCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('whoLogin', true);
    setState(() {
      isLoginProcessCustomer = true;
      AuthServiceCustomer().signInWithGoogle();
    });
    Timer(const Duration(seconds: 10), () {
      if (Provider.of<User?>(context, listen: false) == null) showToast();
      setState(() {
        isLoginProcessCustomer = false;
      });
    });
  }
}
