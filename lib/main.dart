import 'package:flutter/material.dart';
// import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:koodiarana/services/Provider.dart';
import 'package:koodiarana/services/authentification.dart';
import 'package:provider/provider.dart';
import 'services/KoodiaranaRouter.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const Main());
  });
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider.value(
            initialData: null,
            value: AuthServiceCustomer().userCustomer,
          ),
          StreamProvider.value(
            initialData: null,
            value: AuthServiceWork().userWork,
          ),
          ChangeNotifierProvider(create: (context) => BottomTabManager()),
          ChangeNotifierProvider(create: (context) => ManageReservation()),
          ChangeNotifierProvider(create: (context) => CheckAnimation()),
          ChangeNotifierProvider(create: (context) => ManageLogin()),
          ChangeNotifierProvider(create: (context) => BottomWork()),
          ChangeNotifierProvider(create: (context) => UserVerify())
        ],
        // child: shadcn_flutter.ShadcnApp(
        //   debugShowCheckedModeBanner: false,
        //   theme: shadcn_flutter.ThemeData(
        //     colorScheme: shadcn_flutter.ColorSchemes.darkZinc(),
        //     radius: 0.5,
        //   ),
        child: shadcn_flutter.ShadcnApp(
          debugShowCheckedModeBanner: false,
          theme: shadcn_flutter.ThemeData(
              colorScheme: shadcn_flutter.ColorSchemes.darkZinc(), radius: 0.5),
          home: const ShadApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});
  @override
  Widget build(BuildContext context) {
    final bottomTabManager = BottomTabManager();
    final manageReservation = ManageReservation();
    late final koodiaranaRouter =
        KoodiaranaRouter(bottomTabManager, manageReservation);
    final router = koodiaranaRouter.router;
    return MaterialApp.router(
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      theme: AppTheme
          .lightTheme, //GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      title: 'Koodiarana',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider:
          router.routeInformationProvider, //home: const SplashScreen(),
    );
  }
}

class _SplashScreen extends State<SplashScreen> {
  Future<void> _navigateToMainContent() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainContent()),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToMainContent();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Koodiarana',
          style: TextStyle(
              fontSize: 35.0,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
