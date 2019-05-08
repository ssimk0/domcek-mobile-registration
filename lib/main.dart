import 'package:domcek_registration_mobile/pages/home_page.dart';
import 'package:domcek_registration_mobile/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR Generator-Scanner',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(_model),
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (BuildContext context) => HomePage(_model));
          },
        ));
  }
}
