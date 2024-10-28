import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class Reservation {
  LatLng position;
  LatLng destination;
  String description;
  bool goNow;
  String amenity;
  String road;
  String suburb;
  String city;
  String state;
  TimeOfDay timeOfDay;
  Reservation({
    required this.position,
    required this.destination,
    required this.description,
    required this.goNow,
    required this.amenity,
    required this.road,
    required this.suburb,
    required this.city,
    required this.timeOfDay,
    required this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'destination': destination,
      'description': description,
      'goNow': goNow,
      'amenity': amenity,
      'road': road,
      'suburb': suburb,
      'city': city,
      'state': state,
      'timeOfDay': timeOfDay.toString()
    };
  }
}
