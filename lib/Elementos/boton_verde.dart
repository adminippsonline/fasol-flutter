import 'package:flutter/material.dart';

class FloatingActionBotonVerde extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionBotonVerde();
  }
}

class _FloatingActionBotonVerde extends State<FloatingActionBotonVerde> {
  bool _pressed = false;
  void onPressedFav() {
    setState(() {
      _pressed = !this._pressed;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Se ha chikeado el favorito"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: onPressedFav,
      child: Icon(Icons.favorite_border),
    );
  }
}
