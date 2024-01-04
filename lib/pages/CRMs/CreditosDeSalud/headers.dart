import 'package:flutter/material.dart';

class headerTop extends StatelessWidget {
  String titulo = "";
  String subTitulo = "";

  headerTop(this.titulo, this.subTitulo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(children: <Widget>[
      Text(
        titulo,
        style: TextStyle(
            //fontFamily: 'cursive', 
            color: Colors.white, fontSize: 30.0),
      ),
      // if (subTitulo != null)
      //   SizedBox(
      //     height: 10,
      //   ),
      if (subTitulo != null)
        Container(
          child: Text(
            subTitulo,
            style: TextStyle(
                //fontFamily: 'cursive', 
                color: Colors.white, fontSize: 30.0),
          ),
        )
      else
        Text("")

      //Divider(),
      /*SizedBox(
        height: 20,
      ),*/
    ]));
  }
}

class SubitleCards extends StatelessWidget {
  String subtitleCard = "";

  SubitleCards(this.subtitleCard);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitleCard,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
