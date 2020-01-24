import 'package:flutter/material.dart';
import './newrecord.dart';


void main() => runApp( MyApp() );
GlobalKey<ScaffoldState> scaffoldKey4 = GlobalKey<ScaffoldState>(debugLabel: 'Key4');
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      routes: <String, WidgetBuilder>{
        "main": (BuildContext context)=> MyApp()
      },

      home: DefaultTabController(

        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon( Icons.create_new_folder )),
                Tab(icon: Icon( Icons.camera )),
              ],
            ),
            title: Text('Goat Meat Information'),
          ),
          key:scaffoldKey4,
          body: TabBarView(children: [
            MyHomePage(),
            MyCustomForm(),
            Text('Tab 3')
          ]),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      home: Scaffold(
      key: scaffoldKey,
        body: Center(
          child: Text('HOME PAGE'),
        ),
      ),
    );
  }
}