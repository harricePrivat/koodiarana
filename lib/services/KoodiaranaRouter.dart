import 'package:go_router/go_router.dart';
import 'package:koodiarana/customer/AccueilCustomer.dart';
import 'package:koodiarana/MessageEvolution.dart';
import 'package:koodiarana/work/AccueilWork.dart';
import 'package:koodiarana/customer/firstLoginCustomer.dart';
import 'Provider.dart';
import '../Login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../work/firstLoginWork.dart';

class KoodiaranaRouter {
  final BottomTabManager bottomTabManager;
  final ManageReservation manageReservation;
  KoodiaranaRouter(this.bottomTabManager, this.manageReservation);
  // final splashManager = SplashManager();
  late final router = GoRouter(
      initialLocation: '/login',
      refreshListenable: bottomTabManager,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            name: 'accueilCustomer',
            path: '/accueilCustomer',
            builder: (context, state) => const Accueil()),
        GoRoute(
            name: 'accueilWork',
            path: '/accueilWork',
            builder: (context, state) => const AccueilWork()),
        GoRoute(
            name: 'message',
            path: '/message',
            builder: (context, state) => const Message()),
        GoRoute(
            name: 'firstLoginCustomer',
            path: '/firstLoginCustomer',
            builder: (context, state) => const FirstLoginCustomer()),
        GoRoute(
            name: 'firstLoginWork',
            path: '/firstLoginWork',
            builder: (context, state) => const FirstLoginWork()),
        GoRoute(
            name: 'login',
            path: '/login',
            builder: (context, state) => const Login()),
      ],
      redirect: (context, state) {
        final user = Provider.of<User?>(context);
        final bool whoLogin = Provider.of<ManageLogin>(context).getStatus();
        final bool firstLoginWork =
            Provider.of<ManageLogin>(context).firstLoginWork;
        final bool firstLoginCustomer =
            Provider.of<ManageLogin>(context).firstLoginCustomer;
        if (user == null) return '/login';
        if (!whoLogin) {
          if (!firstLoginWork) {
            return '/accueilWork';
          } else {
            return '/firstLoginWork';
          }
        }

        if (whoLogin) {
          if (!firstLoginCustomer) {
            return '/accueilCustomer';
          } else {
            return '/firstLoginCustomer';
          }
        }

        return null;
      });
}
