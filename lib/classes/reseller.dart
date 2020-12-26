import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'product.dart';
class Reseller{
  String _id;
  String _nom;
  String _prenon;
  String _phone;
  String _wilaya;
  Activite _activite;
  String _storename;
  int _presentationevaluate;
  int _clientevaluate;
  LatLng _location;
  List<BMSProduct> _bmsproducts; //***
  List<NotBMSProduct> _competproducts; //****

  //*****************Constructor*****************//
  Reseller(this._id,this._nom,this._prenon,this._phone,this._location,
      this._presentationevaluate,this._clientevaluate,this._bmsproducts,
      this._competproducts,this._wilaya,this._storename);
  Reseller.fromMap (String id,Map<String,dynamic> resellerInfo){
    _id = id;
    _nom = resellerInfo['nom'];
    _prenon = resellerInfo['prenon'];
    _phone = resellerInfo['phone'];
    _wilaya = resellerInfo['wilaya'];
    _storename = resellerInfo['storename'];
    _presentationevaluate = resellerInfo['presentationevaluate'];
    _presentationevaluate = resellerInfo['clientevaluate'];
    _activite = resellerInfo['activite'];
    if(resellerInfo.containsKey('location')){
      GeoPoint geoPoint = resellerInfo['location'];
      _location = LatLng(geoPoint.latitude, geoPoint.longitude);
    }
  }
  //*****************Methodes*****************//
  Map<String,dynamic> resellerToMap () => {
    'nom' : _nom ,
    'prenon' : _prenon,
    'phone': _phone,
    'wilaya': _wilaya,
    'storename':_storename,
    'presentationevaluate': _presentationevaluate,
    'clientevaluate': _clientevaluate,
    'activite': _activite,
    'location': GeoPoint(_location.latitude, _location.longitude),
  };

  //*****************Getters*****************//
  List<BMSProduct> get bmsproducts => _bmsproducts;
  String get nom => _nom;
  String get id => _id;
  String get prenon => _prenon;
  int get presentationevaluate => _presentationevaluate;
  List<NotBMSProduct> get competproducts => _competproducts;
  int get clientevaluate => _clientevaluate;
  String get phone => _phone;
  LatLng get location => _location;
  String get storename => _storename;
  String get wilaya => _wilaya;

  set id(String value) {
    if(_id==null) {
      _id = value;
    }
    else throw IDModificationAttemptException();
  }
//*****************Setters*****************//

}
enum Activite{
  GROSSISTE,ELECTRECIEN,QUINCAILLERIE
}
class IDModificationAttemptException implements Exception{

}