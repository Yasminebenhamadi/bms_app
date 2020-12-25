import 'package:bmsapp/classes/reseller.dart';
import 'package:bmsapp/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'map_page.dart';

class Home extends StatelessWidget {
  final List<String> listItems = [];
  final HandleFirestore _handleFirestore = HandleFirestore();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  backgroundColor: Color(0xff80b265),
                  title: Row(children: <Widget>[
                    SizedBox(width: 220),
                    Image.asset("images/yellow bleu.png",
                        height: 40, width: 40),
                  ]),
                  leading: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: new TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Color(0xffffdd2e),
                    tabs: [
                      Tab(
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 22),
                            Icon(Icons.list, size: 30),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Liste",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 22),
                            Icon(Icons.map, size: 30),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Carte",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: [
                Column(children: <Widget>[
                  personDetailCard(null),
                  personDetailCard2(),
                  personDetailCard3(),
                  personDetailCard4(),
                  personDetailCard5(),
                  personDetailCard6(),
                ]),
                Container(
                  child: Mapp(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  StreamBuilder<QuerySnapshot> body (BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: _handleFirestore.getResellerStream(),
      builder: (context,asyncSnap){
        if(asyncSnap.hasError){
          return null;
        }
        else if (asyncSnap.hasData){
          QuerySnapshot querySnapshot = asyncSnap.data; //Tous les documents de resellers
          List<Widget> list = List<Widget>(); //List de card avec futur builder
          for(DocumentSnapshot resellerDoc in querySnapshot.documents){
            list.add(personDetailCard(Reseller.fromMap(resellerDoc.documentID, resellerDoc.data))); //Créer une list de futur builder pour etre utilisé dans le column
          }
          return TabBarView(
            children: [
              Column(children: /*<Widget>[
                personDetailCard(null),
                personDetailCard2(),
                personDetailCard3(),
                personDetailCard4(),
                personDetailCard5(),
                personDetailCard6(),
              ]*/
              list
              ),
              Container(
                child: Mapp(),
              )
            ],
          );
        }
        else
          return null;
      },
    );
  }
}

List<Widget> resellersStars (Reseller reseller){
  List<Widget> list = List<Widget> ();
  num score = (reseller.clientevaluate+reseller.presentationevaluate)/2;
  int intScore;
  if(score is int ){
     intScore= score.round();
  }
  else {
    intScore = score.round() - 1;
  }
  for(int i=0;i<intScore;i++){
    list.add(
      Icon(
      Icons.star,
      color: Color(0xffffdd2e),
      )
    );
  }
  if (!(score is int )){
    list.add(
      Icon(
        Icons.star_half,
        color: Color(0xffffdd2e),
      ),
    );
    intScore++;
  }
  for(int i=0;i<5-intScore;i++){
    list.add(
      Icon(
        Icons.star_border,
        color: Color(0xffffdd2e),
      ),
    );
  }
  return list;
}

Widget personDetailCard(Reseller reseller) {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7),
    child: Card(
      color: Color(0xff80b265),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/avatar-369-456321.png")))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: resellersStars(reseller),
                  /*children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                  ],*/
                ),
                Text(
                  reseller.prenon+' '+reseller.nom,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  reseller.phone,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              width: 75,
            ),
            Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}


Widget personDetailCard2() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7),
    child: Card(
      color: Color(0xff80b265),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/avatar-369-456321.png")))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                  ],
                ),
                Text(
                  'Wafa Benyahia',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  "0658452612",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              width: 80,
            ),
            Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget personDetailCard3() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7),
    child: Card(
      color: Color(0xff006579),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/avatar-369-456321.png")))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Color(0xffffdd2e),
                    ),
                  ],
                ),
                Text(
                  'Amina Bouaziz',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  "0756214584",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              width: 80,
            ),
            Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget personDetailCard4() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7),
    child: Card(
      color: Color(0xff006579),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/avatar-369-456321.png")))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star_half,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Color(0xffffdd2e),
                    ),
                  ],
                ),
                Text(
                  'Yasmine Benhamadi',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  "0656923115",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              width: 35,
            ),
            Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
//j ffdd2e
}

Widget personDetailCard5() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7),
    child: Card(
      color: Color(0xff778284),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/avatar-369-456321.png")))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Color(0xffffdd2e),
                    ),
                  ],
                ),
                Text(
                  'Manel Bahi',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  "0657562136",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              width: 80,
            ),
            Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget personDetailCard6() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7),
    child: Card(
      color: Color(0xff778284),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/avatar-369-456321.png")))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Color(0xffffdd2e),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Color(0xffffdd2e),
                    ),
                  ],
                ),
                Text(
                  'Manel Bahi',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  "0657562136",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            SizedBox(
              width: 80,
            ),
            Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}