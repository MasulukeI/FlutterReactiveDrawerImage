import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class ScreenHolder extends StatefulWidget {
  final Widget body;
  final String title;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ScreenHolder(
      {Key key,
        @required this.body,
        @required this.title,
        @required this.scaffoldKey,
        this.backgroundColor: Colors.white,
       })
      : super(key: key);

  @override
  ScreenHolderState createState() => ScreenHolderState();
}

class ScreenHolderState extends State<ScreenHolder> {
  String imageString;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenforStream();
  }

  String listenforStream(){
    imageChanged.stream.listen((onData){
      setState(() {
        imageString = onData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title),
        ) ,
        drawer: Drawer(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: imageString != null && imageString.isNotEmpty
                  ? Image.memory(base64Decode(imageString)).image
                      : ExactAssetImage('assets/placeholder.png',
                  scale: 1.0)))),
                  ]),
            )),
    body: widget.body
    );
  }
}