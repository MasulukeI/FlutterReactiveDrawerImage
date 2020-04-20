import 'package:rxdart/rxdart.dart';

final imageChanged = new BehaviorSubject<String>();

addImage(String base64){
  imageChanged.add(base64);
}