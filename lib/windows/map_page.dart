import 'dart:async';
import 'package:bmsapp/classes/reseller.dart';
import 'package:bmsapp/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapp extends StatefulWidget {
  @override
  MappState createState() => MappState();
}

class MappState extends State<Mapp> {
  Completer<GoogleMapController> _controller = Completer();
  HandleFirestore _handleFirestore = HandleFirestore();
  Set<Marker> _markers = Set<Marker> ();
  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          /*_zoomminusfunction(),
          _zoomplusfunction(),*/
          StreamBuilder<QuerySnapshot>(
            stream: _handleFirestore.getResellerStream(),
            builder: (context,asyncSnap){
              if(asyncSnap.hasError){
                return null;
              }
              else if (asyncSnap.hasData){
                QuerySnapshot querySnapshot = asyncSnap.data; //Tous les documents de resellers
                return _buildContainer(querySnapshot.documents);
              }
              else
                return null;
              },
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: "Tapez votre recherche ici ",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Color(0xff80b265)),
                        // onPressed: searchAndNavigate,
                        iconSize: 30.0,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.zoom_out, color: Color(0xff006579)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.zoom_in, color: Color(0xff006579)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  Widget _buildContainer(List<DocumentSnapshot> resellersDocs ) {
    List<Widget> list = List<Widget>(); //List view children
    for(DocumentSnapshot resellerDoc in resellersDocs){
      list.add(
        SizedBox(width: 10.0),
      );
      list.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _boxes("https://batis.dz/images/94.jpg", Reseller.fromMap(resellerDoc.documentID, resellerDoc.data)),
        ),
      );
    }
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: list,
        ),
      ),
    );
  }

  Widget _boxes(String _image, Reseller reseller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('Oran'),
          position: LatLng(35.69906, -0.63588),
          infoWindow: InfoWindow(title: 'Zitouni Aya'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow,
          ),
        ),
      );
    });
    return GestureDetector(
      onTap: () {
        _gotoLocation(reseller.location.latitude, reseller.location.longitude);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 8.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(
                          reseller.storename, reseller.nom+' '+reseller.prenon, reseller.phone),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(
      String storeName, String nameReseller, String Phonenumber) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                storeName,
                style: TextStyle(
                    color: Color(0xff006579),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.1",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
              ],
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              nameReseller,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              Phonenumber,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
        CameraPosition(target: LatLng(36.73225, 3.08746), zoom: 4.5),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers:  /*{
          BatnaMarker,
          MedeaMarker,
          OranMarker,
          AlgiersMarker,
          OuarglaMarker,
          AnnabaMarker
        }*/ _markers,
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker AlgiersMarker = Marker(
  markerId: MarkerId('Algiers'),
  position: LatLng(36.73225, 3.08746),
  infoWindow: InfoWindow(title: 'Manel Bahi'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  ),
);

Marker OuarglaMarker = Marker(
  markerId: MarkerId('Ouargla'),
  position: LatLng(31.9500, 5.3167),
  infoWindow: InfoWindow(title: 'Benhamadi Yasmine'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  ),
);
Marker AnnabaMarker = Marker(
  markerId: MarkerId('Annaba'),
  position: LatLng(36.9, 7.76667),
  infoWindow: InfoWindow(title: 'Kermiche Asma'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  ),
);

Marker BatnaMarker = Marker(
  markerId: MarkerId('Batna'),
  position: LatLng(35.55597, 6.17414),
  infoWindow: InfoWindow(title: 'Bouaziz Amina'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  ),
);
Marker MedeaMarker = Marker(
  markerId: MarkerId('Medea'),
  position: LatLng(36.2675, 2.7500),
  infoWindow: InfoWindow(title: 'Benyahia Wafa'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  ),
);
Marker OranMarker = Marker(
  markerId: MarkerId('Oran'),
  position: LatLng(35.69906, -0.63588),
  infoWindow: InfoWindow(title: 'Zitouni Aya'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  ),
);