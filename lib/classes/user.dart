import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AppUser {
  String _id;
  String _nom;
  String _prenom;
  String _email; 
  Location _locationTracker = Location();

  AppUser(this._id,this._nom,this._prenom,this._email);
  AppUser.fromMap(String id,Map<String,dynamic> data){
    this._nom = data['nom'];
    this._prenom= data['prenon'];
    this._email= data['email'];
  }
  Map<String,dynamic> appUserToMap(){
    return {
      'nom': this._nom,
      'prenon': this._prenom,
      'email': this._email,
    };
  }

  Future<LatLng> currentLocation () async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await _locationTracker.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationTracker.requestService();
      if (!_serviceEnabled) {
        throw ServiceException();
      }
    }

    _permissionGranted = await _locationTracker.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationTracker.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw PermissionException();
      }
    }
    LocationData locationData = await _locationTracker.getLocation();
    return LatLng(locationData.latitude, locationData.longitude);
  }

  String get nom => _nom;

  String get email => _email;

  String get prenom => _prenom;

  Location get locationTracker => _locationTracker;

  String get id => _id;

}
class PermissionException implements Exception{

}
class ServiceException implements Exception{

}