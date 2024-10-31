import 'package:flutter/material.dart';
import 'package:koodiarana/Models/model_user.dart';
import 'Models/ModelKoodiarana.dart';
import 'services/appCache.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BottomTabManager extends ChangeNotifier {
  int tabManager = 0;
  bool toogle = true;
  void darkMode() {
    toogle = !toogle;
    notifyListeners();
  }

  void changeTab(int index) {
    tabManager = index;
    notifyListeners();
  }

  void logout() {
    tabManager = 0;
  }

  void goToActivity() {
    tabManager = 2;
    notifyListeners();
  }

  void goToMaps() {
    tabManager = 1;
    notifyListeners();
  }

  void goToAccueil() {
    tabManager = 0;
    notifyListeners();
  }
}

class ManageReservation extends ChangeNotifier {
  List<Reservation> listReservation = [];
  void addReservation(reservation) {
    listReservation.add(reservation);
    notifyListeners();
  }

  void changeDescription(int i, String newValue) {
    listReservation[i].description = newValue;
    notifyListeners();
  }

  void changeTime(int i, TimeOfDay newValue) {
    listReservation[i].timeOfDay = newValue;
    notifyListeners();
  }

  void removeReservation(i) {
    listReservation.removeAt(i);
    notifyListeners();
  }
}

class ManageLogin extends ChangeNotifier {
  final appCache = AppCache();
  bool status = true;
  bool firstLoginCustomer = true;
  bool firstLoginWork = true;
  List<ConnectivityResult>? connectivityResult;
  bool ready = false;
  void setReady(bool ready) {
    this.ready = ready;
    notifyListeners();
  }

  void reFirstLoginCustomer(bool reallyCustomer) {
    reallyCustomer ? firstLoginCustomer = true : firstLoginWork = true;
    notifyListeners();
  }

  bool getReady() {
    return ready;
  }

  void setLoginCustomer(bool result) {
    firstLoginCustomer = result;
    notifyListeners();
  }

  void tipsDoneWork() async {
    await appCache.doneTipsWork();
    firstLoginWork = false;
    notifyListeners();
  }

  void tipsDoneCustomer() async {
    await appCache.doneTipsCustomer();
    firstLoginCustomer = false;
    notifyListeners();
  }

  List<ConnectivityResult> getConnectivty() {
    notifyListeners();
    return connectivityResult ?? [];
  }

  void setConnectivity(List<ConnectivityResult> connectivityResult) {
    this.connectivityResult = connectivityResult;
    notifyListeners();
  }

  Future<void> initializeApp() async {
    status = await appCache.checkLogin();
    firstLoginCustomer = await appCache.checkFirstCustomer();
    firstLoginWork = await appCache.checkFirstWork();
    ready = await appCache.checkActivity();
    //  print('InitializeApp: $status,$firstLoginCustomer,$firstLoginWork');
    notifyListeners();
  }

  void setLoginWork(bool result) {
    firstLoginWork = result;
    notifyListeners();
  }

  void changeStatus(bool change) {
    status = change;
    // print('Je change en $status');
    notifyListeners();
  }

  bool getStatus() => status;
}

class BottomWork extends ChangeNotifier {
  int index = 0;
  void changeTab(int index) {
    this.index = index;
    notifyListeners();
  }

  void goToAccueil() {
    index = 0;
  }
}

class CheckAnimation extends ChangeNotifier {
  bool alreadyThrough1 = false;
  bool alreadyThrough2 = false;
  bool alreadyThrough3 = false;
  bool alreadyThrough4 = false;
  bool chargement = false;

  void checkThrough(int value) {
    if (value == 1) {
      alreadyThrough1 = true;
    } else if (value == 2) {
      alreadyThrough2 = true;
    } else if (value == 3) {
      alreadyThrough3 = true;
    } else {
      alreadyThrough4 = true;
    }
    notifyListeners();
  }

  bool getChargement() {
    return chargement;
  }

  void beginChargement() {
    chargement = true;
    print('Voici le chargement commencement $chargement');
    notifyListeners();
  }

  void endChargement() {
    chargement = false;
    print('Voici le chargement de la fin $chargement');
    notifyListeners();
  }
}

class UserVerify extends ChangeNotifier {
  ModelUser? user;
  ModelUser getUser() {
    return user!;
  }

  void setUser(ModelUser user) {
    this.user = user;
    notifyListeners();
  }
}
