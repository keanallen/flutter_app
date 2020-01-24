import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/newrecord.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

//GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//MeatInfo myGlobals = new MeatInfo();
class MeatInfo{
//  GlobalKey _scaffoldKey;
//  MeatInfo(){
//    _scaffoldKey = GlobalKey();
//  }
//  GlobalKey get scaffoldKey => _scaffoldKey;
  String owner  = 'ISU-MPC';
  String address = 'P-5, San Fabian, Echague, Isabela';
  String eartag = '';
  String sex = 'Male';
  String breed = 'Native';
  DateTime dob = new DateTime(
      DateTime.now().year ,
      DateTime.now().month,
      DateTime.now().day );
  DateTime date_killed= new DateTime(
      DateTime.now().year ,
      DateTime.now().month,
      DateTime.now().day );
  double live_weight=0;
  double dead_weight=0;
  String inspection='Passed';
  String grade = 'A';
  double head = 0.0;
  double legs = 0.0;
  double kidney = 0.0;
  double skin = 0.0;
  double bladder=0.0;

  double heart = 0.0;
  double isaw = 0.0;
  double liver = 0.0;
  double lungs = 0.0;
  double stomach=0.0;
  double spleen=0.0;

  int currentPage = 1;
  bool isFinished = false;
  bool isValid = false;


  Future<String>saveRecord(BuildContext context) async{

    var pr = ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: true, showLogs: true);
    pr.style(

        message: 'Saving Record...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    pr.show();
    String url = "http://192.168.1.5/chevon/appv2/query.php?q=save";
    Map body = {
      'owner': this.owner,
      'address': this.address,
      'tagno': this.eartag,
      'sex': this.sex,
      'breed': this.breed,
      'dob': this.dob.toString(),
      'sdate': this.date_killed.toString(),
      'lweight': this.live_weight.toString(),
      'cweight': this.dead_weight.toString(),
      'inspection': this.inspection.toString(),
      'grade': this.grade.toString(),
      'head': this.head.toString(),
      'legs': this.legs.toString(),
      'kidney': this.kidney.toString(),
      'skin': this.skin.toString(),
      'gall': this.bladder.toString(),
      'heart': this.heart.toString(),
      'isaw': this.isaw.toString(),
      'liver': this.liver.toString(),
      'lungs': this.lungs.toString(),
      'stomach': this.stomach.toString(),
      'spleen': this.spleen.toString()
    };
    var response = await http.post(Uri.encodeFull(url),
        body: jsonEncode(body),
        headers: {'Accept':'application/json'}
        );

    print(response.body);
    pr.hide();
    if( response.body == '1' ){

      print("Saved");
    }else{
      Navigator.of(context).pushNamed("main");
      print(response.body);
    }
  }

}

