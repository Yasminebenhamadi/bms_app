import "package:flutter/material.dart";

class PopupMenuButtonPage extends StatefulWidget {
  @override
  _PopupMenuButtonState createState() => _PopupMenuButtonState();
}

class _PopupMenuButtonState extends State<PopupMenuButtonPage> {
  @override
  Widget build(BuildContext context) {
    Widget _offsetPopup() => PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 1,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.mode_edit,
                  color: Color(0xff006579),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Mettre à jour",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ],
            )),
        PopupMenuItem(
            value: 2,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Color(0xff006579),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Supprimer",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ],
            )),
      ],
      icon: Icon(
        Icons.more_horiz,
        color: Colors.white,
      ),
//          offset: Offset(0, 100),
    );
    return Container(
      child: _offsetPopup(),
    );
  }
}