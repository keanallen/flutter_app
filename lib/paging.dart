import 'package:flutter/material.dart';

void main() => runApp( MyApp() );

class MyApp extends StatelessWidget{
  static const String _title = 'Flutter code sample';
  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: _title,
        home: MyStatelessWidget()
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

void openPage(BuildContext context){
  Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context){
        return Scaffold(
            appBar: AppBar(
              title: const Text('Next Page'),
            ),
            body: const Center(
              child: Text('This is the next page', style: TextStyle(fontSize: 24),),
            )
        );
      }
  )
  );
}

class MyStatelessWidget extends StatelessWidget{
  MyStatelessWidget({Key key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Appbar Demo'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: (){
                scaffoldKey.currentState.showSnackBar(snackBar);
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: (){
                openPage(context);
              },
            )
          ],
        ),
        body: const Center(
          child: Text(
            'This is the home page',
            style: TextStyle(fontSize: 24),
          ),
        )
    );
  }
}

