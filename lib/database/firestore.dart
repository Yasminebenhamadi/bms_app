import 'package:bmsapp/classes/product.dart';
import 'package:bmsapp/classes/reseller.dart';
import 'package:bmsapp/classes/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../classes/product.dart';


class HandleFirestore{
  String _resselersCollection = "resellers";
  String _productsCollection = "products";
  String _usersCollection = "users";
  final Firestore _firestore = Firestore.instance;


  //**************************************Users*************************************************/
  Future<AppUser> getAppUserInfo (String uid) async {
    Map<String,dynamic> data;
    DocumentSnapshot documentSnapshot = await _firestore.collection(_usersCollection).document(uid).get();
    if (documentSnapshot.exists) {
      data = documentSnapshot.data;
      return AppUser.fromMap(uid, data);
    }
    else
      throw UserDataNotFoundException();
  }

  Future<void> addUserProfile (AppUser user) async{
    await _firestore.collection(_usersCollection).document(user.id).setData(user.appUserToMap());
  }
  //TODO
  Future<void> updateUserProfile (AppUser user) async{
    await _firestore.collection(_usersCollection).document(user.id).setData(user.appUserToMap());
  }

  //**************************************Resellers*************************************************/
  Stream<QuerySnapshot> getResellerStream(){
    return _firestore.collection(_resselersCollection).snapshots();
  }
  Future<void> addReseller (Reseller reseller) async {
      await _firestore.collection(_resselersCollection).add(reseller.resellerToMap());
  }
  Future<Reseller> getResellerInfo(String id) async
  {
    Map<String,dynamic> data;
    DocumentSnapshot documentSnapshot = await _firestore.collection(_resselersCollection).document(id).get();
    if (documentSnapshot.exists) {
      data = documentSnapshot.data;
      return Reseller.fromMap(id, data);
    }
    else
      throw CouldNotGetResellerException () ;
  }
  //TODO
  Future<void> updateResellersInfo (){

  }
  Future<void> deleteReseller(String resellersID)async{
    await _firestore.collection(_resselersCollection).document(resellersID).delete();
  }
  //**************************************Products*************************************************/
  Future<void> addProduit(String resellersID, Product produit) async {
    await _firestore.collection(_resselersCollection).document(resellersID).collection(_productsCollection).document(produit.code).setData(produit.productToMap());
  }
  Future<void> deleteProduit(String resellersID, Product produit) async {
    await _firestore.collection(_resselersCollection).document(resellersID).collection(_productsCollection).document(produit.code).delete();
  }
}

class CouldNotGetResellerException implements Exception {
  String _code ;
  CouldNotGetResellerException(){this._code = 'reseller_not_found';}
  String get code => _code;
}
class UserDataNotFoundException implements Exception {
  String _code ;
  UserDataNotFoundException(){this._code = 'user_data_not_found';}
  String get code => _code;
}