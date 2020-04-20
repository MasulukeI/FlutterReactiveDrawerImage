import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactivedrawerimage/components/screenholder.dart';

import 'globals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Reactive Drawer Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageString;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    imageChanged.add(base64Image);

    setState(() {
      imageString = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return ScreenHolder(
      scaffoldKey: _scaffoldKey,
      title: widget.title,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                        child: Container(
                            width: 190.0,
                            height: 190.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: imageString != null &&
                                      imageString.isNotEmpty
                                      ? Image.memory(base64Decode(imageString))
                                      .image
                                      : ExactAssetImage(
                                      'assets/placeholder.png',
                                      scale: 1.0)),
                            )),
                        onTap: () => getImage()),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Tap image to change')
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
