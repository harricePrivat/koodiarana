import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:koodiarana/services/Provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:koodiarana/delayed_animation.dart';
import '../Models/ModelKoodiarana.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:http/http.dart' as http;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn_flutter;
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});
  @override
  State<Page2> createState() => _Page2();
}

class _Page2 extends State<Page2> with TickerProviderStateMixin {
  bool toogle = false;
  LatLng? _currentPosition;
  LatLng? futurePosition;
  List<LatLng> routes = [];
  String? description;
  bool? goNow;
  bool chargement = false;

  final String tokens =
      '5b3ce3597851110001cf62485775a9d2e27048c9a7c9ab5cfbf3ee05';
  TimeOfDay _timeOfDay = TimeOfDay.now();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  String valueToGo = 'Maintenant';
  Marker? marker;
  List<ConnectivityResult>? connectivityResult = [ConnectivityResult.none];
  @override
  void initState() {
    super.initState();
    getCurrentLocalisation();
    startListening();
  }

  // Future<void> getRoute() async {
  //   final uri =Uri.parse('http://router.project-osrm.org/route/v1/driving/')
  // }

  void startListening() {
    const locationSettings =
        LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 5);
    // _myPosition =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      //setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      // });
    });
  }

  Future<void> getCurrentLocalisation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error('Vous avez besoin de la permission');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('La permission a ete refuse');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('La permission a ete refuse de maniere permanente');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void newMarker(LatLng latLng) {
    futurePosition = latLng;
    setState(() {
      marker = Marker(
          point: latLng,
          child: const Icon(
            Icons.place,
            color: Colors.black,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    connectivityResult = Provider.of<ManageLogin>(context).getConnectivty();

    Color loadingColor = Theme.of(context).primaryColor;
    return shadcn_flutter.DrawerOverlay(
        child: Scaffold(
      appBar: AppBar(
        title:
            const DelayedAnimation(delay: 500, child: Text('Koodiarana Maps')),
      ),
      body: (!connectivityResult!.contains(ConnectivityResult.none))
          ? _currentPosition == null
              ? Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                    color: loadingColor,
                    size: 100,
                  ),
                )
              : flutterMap(loadingColor)
          : Center(
              child: noConnexion(),
            ),
    ));
  }

  Widget flutterMap(Color loadingColor) {
    TextEditingController controllerLocation = TextEditingController();
    return Stack(
      children: [
        FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
            initialCenter: _currentPosition!,
            initialZoom: 15,
            onTap: (position, latLng) async {
              setState(() {
                chargement = true;
              });
              // Provider.of<CheckAnimation>(context, listen: false)
              //     .beginChargement();
              showModalBottom(latLng);
              // setState(() {
              //   chargement = true;
              // });
            },
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: const ['a', 'b', 'c'],
                tileProvider: NetworkTileProvider()),
            MarkerLayer(
              markers: marker != null ? [marker!] : [],
            ),
            AnimatedMarkerLayer(
              markers: [
                AnimatedMarker(
                  point: _currentPosition!,
                  builder: (_, animation) {
                    final size = 30.0 * animation.value;
                    return Icon(
                      Icons.location_on,
                      size: size,
                      color: Colors.red,
                    );
                  },
                ),
              ],
            ),
            futurePosition != null
                ? PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routes, // [_currentPosition!, futurePosition!],
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  )
                : PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [_currentPosition!, _currentPosition!],
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  )
          ],
        ),
        Positioned(
          left: 15,
          top: 15,
          child: Row(
            children: [
              Card(
                color: Colors.grey,
                child: IconButton(
                  onPressed: () async {
                    setState(() {
                      chargement = true;
                    });
                    // Provider.of<CheckAnimation>(context, listen: false)
                    //     .beginChargement();
                    final url =
                        'https://nominatim.openstreetmap.org/search?q=${controllerLocation.text}&format=json&addressdetails=1&limit=5&viewbox=47.46,-19.02,47.56,-18.78&bounded=1';

                    final response = await http.get(Uri.parse(url));
                    if (response.statusCode == 200) {
                      final data = jsonDecode(response.body);

                      if (data is List && data.isEmpty) {
                        shadcn_flutter.showDialog(
                            context: context,
                            builder: (context) {
                              // setState(() {
                              //   chargement = false;
                              // });
                              return Padding(
                                padding: const EdgeInsets.all(16.00),
                                child: Container(
                                  height: 220,
                                  color: Colors.white,
                                  width: double.infinity,
                                  child: shadcn_flutter.AlertDialog(
                                    title: const shadcn_flutter.Text(
                                      'Lieu non trouvé',
                                      style: shadcn_flutter.TextStyle(
                                          color: Colors.red),
                                    ),
                                    content: const shadcn_flutter.Text(
                                        'Le lieu que vous avez marqué est introuvable'),
                                    actions: [
                                      shadcn_flutter.PrimaryButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                        setState(() {
                          chargement = false;
                        });
                        // Provider.of<CheckAnimation>(context, listen: false)
                        //     .endChargement();
                      } else {
                        LatLng resultSearch = LatLng(
                            double.parse(data[0]['lat']),
                            double.parse(data[0]['lon']));
                        //print(resultSearch);
                        // print('lat:${data[0]['lat']}, long:${data[0]['lon']}');
                        // setState(() {
                        //   chargement = false;
                        // });
                        showModalBottom(resultSearch);
                        // Provider.of<CheckAnimation>(context, listen: false)
                        //     .endChargement();
                      }
                    }
                  },
                  icon: Icon(Icons.search, color: loadingColor),
                ),
              ),
              const SizedBox(width: 4),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.00),
                    color: Colors.grey,
                  ),
                  width: 260,
                  child: ShadInputFormField(
                      controller: controllerLocation,
                      placeholder: const Text(
                        'Recherchez votre destination ici',
                        style: shadcn_flutter.TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
        if (chargement)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
            child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Center(
                        child: Card(
                          color: Colors.grey,
                          elevation: 5,
                          child: LoadingAnimationWidget.threeRotatingDots(
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 100),
                        ),
                      )),
                )),
          ),
      ],
    );
  }

  List<shadcn_flutter.OverlayPosition> positions = [
    shadcn_flutter.OverlayPosition.left,
    shadcn_flutter.OverlayPosition.left,
    shadcn_flutter.OverlayPosition.bottom,
    shadcn_flutter.OverlayPosition.bottom,
    shadcn_flutter.OverlayPosition.top,
    shadcn_flutter.OverlayPosition.top,
    shadcn_flutter.OverlayPosition.right,
    shadcn_flutter.OverlayPosition.right,
  ];

  void open(BuildContext context, LatLng latLng, dataDestination,
      dataLocalisation, String duration, bool toogle) {
    TextEditingController controller = TextEditingController();
    final color = Theme.of(context).secondaryHeaderColor;
    shadcn_flutter
        .openDrawer(
      context: context,
      expands: true,
      //barrierColor: color,
      builder: (context) {
        final adresseDestination = dataDestination['address'];
        final adresseLocalisation = dataLocalisation['address'];

        // Vérification des valeurs nulles
        final amenityLocalisation =
            adresseLocalisation['amenity'] ?? 'N/A'; // valeur par défaut
        final roadLocalisation = adresseLocalisation['road'] ?? 'N/A';
        final suburbLocalisation = adresseLocalisation['suburb'] ?? 'N/A';
        final cityLocalisation = adresseLocalisation['city'] ?? 'N/A';
        final stateLocalisation = adresseLocalisation['state'] ?? 'N/A';

        final suburbDestination = adresseDestination['suburb'] ?? 'N/A';
        final cityDestination = adresseDestination['city'] ?? 'N/A';
        final amenityDestination = adresseDestination['amenity'] ?? 'N/A';
        final roadDestination = adresseDestination['road'] ?? 'N/A';
        final stateDestination = adresseDestination['state'] ?? 'N/A';
        // setState(() {
        //   chargement = false;
        // });
        Provider.of<CheckAnimation>(context, listen: false).endChargement();
        return Expanded(
            child: Container(
                //    height: 400,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.00), color: color),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32),
                child: Consumer<ManageReservation>(
                    builder: (context, manageReservation, child) {
                  return ListView(
                    padding: const EdgeInsets.all(5.00),
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Votre direction',
                                  style: GoogleFonts.openSans(
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                  )),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        description = controller.text;
                                        if (description == '') {
                                          Fluttertoast.showToast(
                                              gravity: ToastGravity.BOTTOM,
                                              msg:
                                                  'Veuillez remplir le champ description');
                                        } else {
                                          valueToGo == 'Plus Tard'
                                              ? goNow = false
                                              : goNow = true;
                                          final reservation = Reservation(
                                              timeOfDay: _timeOfDay,
                                              position: _currentPosition!,
                                              destination: futurePosition!,
                                              description: description!,
                                              goNow: goNow!,
                                              amenity: amenityDestination,
                                              road: roadDestination,
                                              suburb: suburbDestination,
                                              city: cityDestination,
                                              state: stateDestination);
                                          manageReservation
                                              .addReservation(reservation);
                                          //  print(_timeOfDay);
                                          Provider.of<BottomTabManager>(context,
                                                  listen: false)
                                              .goToActivity();

                                          sendData(reservation.toJson());
                                          context.pop();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        size: 15,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(16.00),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Depart:',
                                    style: GoogleFonts.openSans(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                    )),
                                DropdownButton<String>(
                                  value:
                                      valueToGo, // Utilise une valeur par défaut si valueToGo est null
                                  items: <String>[
                                    'Maintenant',
                                    'Plus Tard',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      valueToGo = newValue.toString();
                                    });
                                    //  print(valueToGo);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Text('Description',
                              style: GoogleFonts.openSans(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              )),
                          TextField(
                            controller: controller,
                            maxLines: 3,
                            enabled: true,
                            decoration: const InputDecoration(
                              focusColor: Colors.black,
                              hintText: 'ex: Analakely Pietra Hotel',
                              border: OutlineInputBorder(),
                              //labelText: 'Description de votre Destination'
                            ),
                          ),
                          valueToGo == 'Plus Tard'
                              ? buildTimeField(context)
                              : const SizedBox(
                                  height: 10,
                                ),
                          information(
                              'Localisation',
                              amenityLocalisation,
                              roadLocalisation,
                              suburbLocalisation,
                              stateLocalisation,
                              cityLocalisation),
                          information(
                              'Destination',
                              amenityDestination,
                              roadDestination,
                              suburbDestination,
                              stateDestination,
                              cityDestination),
                          const SizedBox(height: 15),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ShadButton(
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  description = controller.text;
                                  if (description == '') {
                                    Fluttertoast.showToast(
                                        gravity: ToastGravity.BOTTOM,
                                        msg:
                                            'Veuillez remplir le champ description');
                                  } else {
                                    valueToGo == 'Plus Tard'
                                        ? goNow = false
                                        : goNow = true;
                                    final reservation = Reservation(
                                        timeOfDay: _timeOfDay,
                                        position: _currentPosition!,
                                        destination: futurePosition!,
                                        description: description!,
                                        goNow: goNow!,
                                        amenity: amenityDestination,
                                        road: roadDestination,
                                        suburb: suburbDestination,
                                        city: cityDestination,
                                        state: stateDestination);
                                    manageReservation
                                        .addReservation(reservation);
                                    Provider.of<BottomTabManager>(context,
                                            listen: false)
                                        .goToActivity();

                                    sendData(reservation.toJson());
                                    context.pop();
                                  }
                                },
                                child: Text(
                                  'Reservez',
                                  style: GoogleFonts.openSans(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  );
                })));
      },
      position: positions[3],
    )
        .whenComplete(() {
      setState(() {
        chargement = false;
      });
      // Provider.of<CheckAnimation>(context, listen: false).endChargement();
    });
    //     .whenComplete(() {
    //   setState(() {
    //     chargement = false;
    //   });
    // });
  }

  void showModalBottom(LatLng latLng) async {
    final latitudeDestination = latLng.latitude;
    final longitudeDestination = latLng.longitude;
    final latitudeLocalisation = _currentPosition!.latitude;
    final longitudeLocalisation = _currentPosition!.longitude;
    newMarker(latLng);
    final responseDestination = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitudeDestination&lon=$longitudeDestination'));
    final responseLocalisation = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitudeLocalisation&lon=$longitudeLocalisation'));
    final uriRoutes = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?start=${_currentPosition!.longitude},${_currentPosition!.latitude}&end=${latLng.longitude},${latLng.latitude}'),
      headers: {
        'Authorization': tokens,
        'Content-Type': 'application/json',
      },
    );

    if (uriRoutes.statusCode == 200) {
      final feature = jsonDecode(uriRoutes.body);
      // Accès correct aux coordonnées de la route
      final data = feature['features'][0];
      final List<dynamic> coordinates = data['geometry']['coordinates'];

      setState(
        () {
          routes =
              coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
        },
      );
    }
    if (responseDestination.statusCode == 200 &&
        responseLocalisation.statusCode == 200) {
      final dataDestination = jsonDecode(responseDestination.body);
      final dataLocalisation = jsonDecode(responseLocalisation.body);

      // open(context, latLng, dataDestination, dataLocalisation, 'Maintenant',
      //     toogle);
      manageDeplacement(
          latLng, dataDestination, dataLocalisation, 'Maintenant', toogle);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Verifiez votre connexion Internet'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  Widget noConnexion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.wifi_off,
          size: 80,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Pas de connexion Internet',
          style:
              GoogleFonts.openSans(fontStyle: FontStyle.normal, fontSize: 25),
        )
      ],
    );
  }

  Future<dynamic> manageDeplacement(LatLng latLng, dataDestination,
      dataLocalisation, String duration, bool toogle) {
    TextEditingController controller = TextEditingController();
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          final adresseDestination = dataDestination['address'];
          final adresseLocalisation = dataLocalisation['address'];

          // Vérification des valeurs nulles
          final amenityLocalisation =
              adresseLocalisation['amenity'] ?? 'N/A'; // valeur par défaut
          final roadLocalisation = adresseLocalisation['road'] ?? 'N/A';
          final suburbLocalisation = adresseLocalisation['suburb'] ?? 'N/A';
          final cityLocalisation = adresseLocalisation['city'] ?? 'N/A';
          final stateLocalisation = adresseLocalisation['state'] ?? 'N/A';

          final suburbDestination = adresseDestination['suburb'] ?? 'N/A';
          final cityDestination = adresseDestination['city'] ?? 'N/A';
          final amenityDestination = adresseDestination['amenity'] ?? 'N/A';
          final roadDestination = adresseDestination['road'] ?? 'N/A';
          final stateDestination = adresseDestination['state'] ?? 'N/A';
          print(adresseDestination);

          return Consumer<ManageReservation>(
              builder: (context, manageReservation, child) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateModal) {
              return ListView(
                padding: const EdgeInsets.all(5.00),
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Votre direction',
                          style: GoogleFonts.openSans(
                            fontSize: 27.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          )),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(16.00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Depart:',
                                style: GoogleFonts.openSans(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                )),
                            DropdownButton<String>(
                              value:
                                  valueToGo, // Utilise une valeur par défaut si valueToGo est null
                              items: <String>[
                                'Maintenant',
                                'Plus Tard',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setStateModal(() {
                                  valueToGo = newValue.toString();
                                });
                                print(valueToGo);
                              },
                            ),
                          ],
                        ),
                      ),
                      Text('Description',
                          style: GoogleFonts.openSans(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          )),
                      TextField(
                        controller: controller,
                        maxLines: 3,
                        enabled: true,
                        decoration: const InputDecoration(
                          focusColor: Colors.black,
                          hintText: 'ex: Analakely Pietra Hotel',
                          border: OutlineInputBorder(),
                          //labelText: 'Description de votre Destination'
                        ),
                      ),
                      valueToGo == 'Plus Tard'
                          ? buildTimeField(context)
                          : const SizedBox(
                              height: 10,
                            ),
                      information(
                          'Localisation',
                          amenityLocalisation,
                          roadLocalisation,
                          suburbLocalisation,
                          stateLocalisation,
                          cityLocalisation),
                      information(
                          'Destination',
                          amenityDestination,
                          roadDestination,
                          suburbDestination,
                          stateDestination,
                          cityDestination),
                      const SizedBox(height: 15),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ShadButton(
                            onPressed: () {
                              description = controller.text;
                              if (description == '') {
                                Fluttertoast.showToast(
                                    gravity: ToastGravity.BOTTOM,
                                    msg:
                                        'Veuillez remplir le champ description');
                              } else {
                                valueToGo == 'Plus Tard'
                                    ? goNow = false
                                    : goNow = true;
                                final reservation = Reservation(
                                    timeOfDay: _timeOfDay,
                                    position: _currentPosition!,
                                    destination: futurePosition!,
                                    description: description!,
                                    goNow: goNow!,
                                    amenity: amenityDestination,
                                    road: roadDestination,
                                    suburb: suburbDestination,
                                    city: cityDestination,
                                    state: stateDestination);
                                manageReservation.addReservation(reservation);
                                print(_timeOfDay);
                                Provider.of<BottomTabManager>(context,
                                        listen: false)
                                    .goToActivity();

                                sendData(reservation.toJson());
                                context.pop();
                              }
                            },
                            child: Text(
                              'Reservez',
                              style: GoogleFonts.openSans(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                            )),
                      )
                    ],
                  )
                ],
              );
            });
          });
        }).whenComplete(() {
      setState(() {
        chargement = false;
      });
    });
  }

  Future<void> sendData(Map<String, dynamic> reservation) async {
    const String url = 'http://192.168.43.125:9999/post';
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reservation));

    if (response.statusCode == 200) {
      print('Envoye avec succes');
      //  final test = jsonDecode(response.body);
      // print(test);
    } else {
      //  print(response.statusCode);
    }
  }

  Widget buildTimeField(BuildContext context) {
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
                  final now = DateTime.now();
                  final DateTime dateTime = DateTime(
                      now.year, now.month, timeOfDay!.hour, timeOfDay.minute);
                  setStateModal(() {
                    if (dateTime.isAfter(now)) {
                      //   print(timeOfDay);
                      _timeOfDay = timeOfDay;
                    } else {
                      Fluttertoast.showToast(
                          msg: "Veuillez taper une heure correcte");
                    }
                  });
                },
                child: Text(
                  'Temps:',
                  style: GoogleFonts.openSans(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
              ),
              Text(_timeOfDay.format(context),
                  style: GoogleFonts.openSans(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  )),
              IconButton(
                icon: const Icon(Icons.watch_later_outlined),
                onPressed: () async {
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

  Widget information(String type, data1, data2, data3, data4, data5) {
    TextEditingController controller =
        TextEditingController(text: '$data1, $data2, $data3, $data4, $data5');
    return Card(
      margin: const EdgeInsets.all(5.00),
      elevation: 5.00,
      child: Column(
        children: [
          Text(type,
              style: GoogleFonts.openSans(
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              )),
          TextField(
            controller: controller,
            maxLines: 3,
            enabled: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
