import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/MeatInfo.dart';
import './newrecord.dart';

final _info = MeatInfo();
class Step2 extends State<MyCustomForm2>{
  final _formKey = GlobalKey<FormState>();
  var dobValue = TextEditingController();
  var killValue = TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _info.dob,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _info.dob)
      setState(() {
        _info.dob = new DateTime(picked.year, picked.month, picked.day);
        dobValue.text = DateFormat('yyyy-MM-dd').format(_info.dob);
      });
  }
  Future<Null> _selectDateKilled(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _info.date_killed,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _info.date_killed)
      setState(() {
        _info.date_killed = new DateTime(picked.year, picked.month, picked.day);
        killValue.text = DateFormat('yyyy-MM-dd').format(_info.date_killed);
      });
  }
  @override Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightGreen
      ),
      title: 'Step 2',

      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Step 2'),
        ),
        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                    child: Text(
                      'Product Information',
                      style:
                      TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 13),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Breed'),
                          value: _info.breed,
                          elevation: 16,
                          onChanged: (String newval){
                            setState(() {

                              _info.breed = newval;

                            });
                          },
                          onSaved: (value){
                            setState(() {
                              _info.breed = value;
                            });
                          },
                          validator: (value){
                            if(value.toString().isEmpty){
                              _info.isValid = false;
                              return 'Please select breed';
                            }
                            return null;
                          },
                          items: <String>['Native','Anglo','Boer','Saanen',
                            'Anglo - Nubian','Upgraded Boer',
                            'Upgraded Anglo - Nubian',
                            'Upgraded Saanen']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(

                              value: value.toString(),
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Text(value.toString()),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),


                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: DateFormat('yyyy-MM-dd').format(_info.dob).toString(),
                                    controller: dobValue,
                                    decoration: InputDecoration(labelText: 'Date of Birth'),
                                    validator: (value){
                                      if(value.isEmpty){
                                        _info.isValid = false;
                                        return 'Please enter date of birth';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.dob = DateTime.parse(val);
                                      });
                                    },
                                    onTap: () => _selectDate(context),
                                  ),
                                )
                              ],
                            ),
                          )
                          ,
                          Expanded(
                            child: Column(
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: killValue,
                                    decoration: InputDecoration(labelText: 'Slaughter Date'),
                                    validator: (value){
                                      if(value.isEmpty){
                                        _info.isValid = false;
                                        return 'Please enter slaughter date';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.date_killed = DateTime.parse(val);
                                      });
                                    },
                                    onTap: () => _selectDateKilled(context),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Live weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty){
                                        _info.isValid = false;
                                        return 'Please enter live weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.live_weight = double.parse(val);
                                      });
                                    },

                                  ),
                                )
                              ],
                            ),
                          )
                          ,
                          Expanded(
                            child: Column(
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Carcass weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty){
                                        _info.isValid = false;
                                        return 'Please enter carcass weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.dead_weight = double.parse(val);
                                      });
                                    }

                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 13),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(labelText: 'Slaughter Inspection'),
                                    value: _info.inspection,
                                    elevation: 16,
                                    onChanged: (String newval){
                                      setState(() {

                                        _info.inspection = newval;

                                      });
                                    },
                                    onSaved: (value){
                                      setState(() {
                                        _info.inspection = value;
                                      });
                                    },
                                    validator: (value){
                                      if(value.toString().isEmpty){
                                        _info.isValid = false;
                                        return 'Please select inspection result';
                                      }
                                      return null;
                                    },
                                    items: <String>['Passed','Failed']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(

                                        value: value.toString(),
                                        child: Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Text(value.toString()),
                                        ),

                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          )
                          ,
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 13),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(labelText: 'Quality Grade'),
                                    value: _info.grade,
                                    elevation: 16,
                                    onChanged: (String newval){
                                      setState(() {

                                        _info.grade = newval;

                                      });
                                    },
                                    onSaved: (value){
                                      setState(() {
                                        _info.grade = value;
                                      });
                                    },
                                    validator: (value){
                                      if(value.toString().isEmpty){
                                        _info.isValid = false;
                                        return 'Please select meat quality grade';
                                      }
                                      return null;
                                    },
                                    items: <String>['A','B','C']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(

                                        value: value.toString(),
                                        child: Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Text(value.toString()),
                                        ),

                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: double.infinity),
                      child: RaisedButton(
                        onPressed: (){
                          final form = _formKey.currentState;
                          if(form.validate()){
                            form.save();
                            _info.currentPage=2;
                            _info.isValid=true;
                            validatePage(context);
                          }
                        },
                        child: Text('Next'),
                        color: Colors.amber,

                      ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}