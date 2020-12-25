class Product{
  String _code;
  String _nom;
  double _prix;
  //*****************Constructor*****************//
  Product(this._nom,this._code,this._prix);

  //*****************Getters*****************//
  String get nom => _nom;
  double get prix => _prix;
  String get code => _code;

  Product.fromMap(Map<String,dynamic> productInfo){
    this._nom = productInfo['nom'];
    this._code = productInfo['code'];
    this._prix = productInfo['prix'];
  }
  Map<String,dynamic> productToMap(){
    return {
      'nom' : this._nom,
      'code' : this._code,
      'prix' : this._prix,
    };
  }

}
class BMSProduct extends Product {
 
  //*****************Constructor*****************//
  BMSProduct(String nom,String code,double prix) : super(nom,code,prix);
  Map<String,dynamic> productToMap(){
    Map<String,dynamic> map = super.productToMap();
    map.addAll({
      'isBMS': true,
    }); 
    return map ; 
  }
}

class NotBMSProduct extends Product {
  //*****************Constructor*****************//
  NotBMSProduct(String nom,String code,double prix) : super(nom,code,prix);
  Map<String,dynamic> productToMap(){
    Map<String,dynamic> map = super.productToMap();
    map.addAll({
      'isBMS': false,
    }); 
    return map ; 
  }
}