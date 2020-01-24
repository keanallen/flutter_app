

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'models/MeatInfo.dart';

class MyCustomForm extends StatefulWidget{
  @override
  MyCustomFormState createState() {
    // TODO: implement createState
    return MyCustomFormState();
  }
}

class MyCustomForm2 extends StatefulWidget{
  @override
  Step2 createState() {
    // TODO: implement createState
    return Step2();
  }
}
class MyCustomForm3 extends StatefulWidget{
  @override
  Step3 createState() {
    // TODO: implement createState
    return Step3();
  }
}

class MyCustomForm4 extends StatefulWidget{
  @override
  Step4 createState() {
    // TODO: implement createState
    return Step4();
  }
}

class MyCustomForm5 extends StatefulWidget{
  @override
  Review createState() {
    // TODO: implement createState
    return Review();
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

final _info = MeatInfo();

class MyCustomFormState extends State<MyCustomForm>{
  final _formKey = GlobalKey<FormState>();

  @override Widget build(BuildContext context) {
    // TODO: implement build

    return Form(
      key: _formKey,
      child: Container(
        child: ListView(
          children: <Widget>[


                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                      child: Text(
                        'Source of Animal',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Step 1', textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                    ),
                  ],
                ),


            Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _info.owner,
                    decoration: InputDecoration(labelText: 'Owner'),
                    validator: (value){
                      if(value.isEmpty){
                        _info.isValid = false;

                        return 'Please enter the owner';
                      }
                      return null;
                    },
                    onSaved: (val){
                      setState(() {
                        _info.owner = val;
                      });
                    },
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _info.address,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value){
                      if(value.isEmpty){
                        _info.isValid = false;
                        return 'Please enter address';
                      }
                      return null;
                    },
                    onSaved: (val){

                      setState(() {
                        _info.address = val;
                      });
                    },
                  ),
                )
              ],
            )
            ,

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

                                decoration: InputDecoration(labelText: 'Eartag Number'),
                                validator: (value){
                                  if(value.isEmpty){
                                    _info.isValid = false;
                                    return 'Please enter the eartag number';
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                  setState(() {
                                    _info.eartag = val;
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
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 13),
                              child: DropdownButtonFormField(

                                value: _info.sex,
                                elevation: 16,
                                onChanged: (String newval){
                                  setState(() {

                                    _info.sex = newval;

                                  });
                                },
                                onSaved: (value){
                                  setState(() {
                                    _info.sex = value;
                                  });
                                },
                                validator: (value){
                                  if(value.toString().isEmpty || value.toString().trim().toLowerCase() == 'sex'){
                                    _info.isValid = false;
                                    return 'Please select a sex';
                                  }
                                  return null;
                                },
                                items: <String>['Male','Female']
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

                  child: FlatButton(
                    onPressed: (){
                      final form = _formKey.currentState;
                      if(form.validate()){
                        form.save();
                        _info.currentPage=1;
                        _info.isValid=true;
                        validatePage(context);
                      }
                    },
                    child: Text('STEP 2', style: TextStyle(fontSize: 16.4),),
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.lightGreen)
                    ),

                  ),
                ),
              )

          ],
        ),

      ),

    );
  }
}




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
    dobValue.text = DateFormat('yyyy-MM-dd').format(_info.dob).toString();
    killValue.text = DateFormat('yyyy-MM-dd').format(_info.date_killed).toString();
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
       floatingActionButton: FloatingActionButton.extended(
           onPressed: (){
             final form = _formKey.currentState;
             if(form.validate()){
               form.save();
               _info.currentPage=2;
               _info.isValid=true;
               validatePage(context);
             }
           },
         label: const Text('Step 3'),
           elevation: 4.0,
         icon: const Icon(Icons.navigate_next),
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
                               initialValue: _info.live_weight.toString(),
                               keyboardType: TextInputType.number,
                               decoration: InputDecoration(labelText: 'Live weight (kg)'),
                               validator: (value){
                                 if(value.isEmpty || double.parse(value) <= 0 ){
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
                               initialValue: _info.dead_weight.toString(),
                               keyboardType: TextInputType.number,
                               decoration: InputDecoration(labelText: 'Carcass weight (kg)'),
                               validator: (value){
                                 if(value.isEmpty || double.parse(value) <= 0){
                                   _info.isValid = false;
                                   return 'Please enter carcass weight';
                                 }
                                 return null;
                               },
                               onSaved: (val){
                                 setState(() {
                                   _info.dead_weight = double.parse(val);
                                 });
                               },

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



           ],
         ),
       )
       ],
       ),
     ),
   );
  }
}

class Step3 extends State<MyCustomForm3>{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightGreen
      ),
      title: 'Step 3',
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Step 3'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            final form = _formKey.currentState;
            if(form.validate()){
              form.save();
              _info.currentPage=3;
              _info.isValid=true;
              validatePage(context);
            }
          },
          label: const Text('Step 4'),
          elevation: 4.0,
          icon: const Icon(Icons.navigate_next),
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
                      'Data on Extremities',
                      style:
                      TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
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
                                    initialValue: _info.head.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Head (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0 ){
                                        _info.isValid = false;
                                        return 'Please enter head weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.head = double.parse(val);
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
                                    initialValue: _info.legs.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Legs weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0){
                                        _info.isValid = false;
                                        return 'Please enter leg weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.legs = double.parse(val);
                                      });
                                    },

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
                                    initialValue: _info.kidney.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Kidney (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0 ){
                                        _info.isValid = false;
                                        return 'Please enter kidney weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.kidney = double.parse(val);
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
                                    initialValue: _info.skin.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Skin weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0){
                                        _info.isValid = false;
                                        return 'Please enter skin weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.skin = double.parse(val);
                                      });
                                    },

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

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: _info.bladder.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Gall Bladder'),
                          validator: (value){
                            if(value.isEmpty || double.parse(value) <= 0){
                              _info.isValid = false;

                              return 'Please enter the owner';
                            }
                            return null;
                          },
                          onSaved: (val){
                            setState(() {
                              _info.bladder = double.parse(val);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class Step4 extends State<MyCustomForm4>{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightGreen
      ),
      title: 'Step 4',
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Step 4'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            final form = _formKey.currentState;
            if(form.validate()){
              form.save();
              _info.currentPage=4;
              _info.isValid=true;
              validatePage(context);
            }
          },
          label: const Text('Review'),
          elevation: 4.0,
          icon: const Icon(Icons.navigate_next),
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
                      'Data on Offals',
                      style:
                      TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
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
                                    initialValue: _info.heart.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Heart weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0 ){
                                        _info.isValid = false;
                                        return 'Please enter heart weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.heart = double.parse(val);
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
                                    initialValue: _info.isaw.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Intestine weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0){
                                        _info.isValid = false;
                                        return 'Please enter intestine weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.isaw = double.parse(val);
                                      });
                                    },

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
                                    initialValue: _info.liver.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Liver weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0 ){
                                        _info.isValid = false;
                                        return 'Please enter liver weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.liver = double.parse(val);
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
                                    initialValue: _info.lungs.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Lungs weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0){
                                        _info.isValid = false;
                                        return 'Please enter skin weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.lungs = double.parse(val);
                                      });
                                    },

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
                                    initialValue: _info.stomach.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Stomach weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0 ){
                                        _info.isValid = false;
                                        return 'Please enter stomach weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.stomach = double.parse(val);
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
                                    initialValue: _info.lungs.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(labelText: 'Spleen weight (kg)'),
                                    validator: (value){
                                      if(value.isEmpty || double.parse(value) <= 0){
                                        _info.isValid = false;
                                        return 'Please enter spleen weight';
                                      }
                                      return null;
                                    },
                                    onSaved: (val){
                                      setState(() {
                                        _info.spleen = double.parse(val);
                                      });
                                    },

                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class Review extends State<MyCustomForm5>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      title: 'Review',
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Review'),
        ),
        floatingActionButton: FloatingActionButton.extended(

          onPressed: (){


              _info.isValid=true;
              ShowDialog(context);

          },
          label: const Text('Save Record'),
          elevation: 4.0,
          icon: const Icon(Icons.check_circle ),
        ),
        body: ListView(
          children: <Widget>[
            Container(


              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Container(
                  child: Card(


                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.teal,

                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0.1, 0.5, 0.7, 0.9],
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.indigo[500],
                            Colors.indigo[700],
                            Colors.indigo[600],
                            Colors.indigo[400],
                          ],
                        ),
                      ),
                      child: Column(

                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Center(child: Text( 'PRODUCT INFORMATION', style: TextStyle(color: Colors.white,fontSize: 22))),
                          ),
                          ListTile(
                            title: Text( 'Breed', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.breed.toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Owner', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.owner.toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Farm Address', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.address.toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Sex', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.sex.toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Eartag Number', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.eartag.toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Date of Birth', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( DateFormat('yyyy-MM-dd').format(_info.dob).toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Slaughtered Date', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( DateFormat('yyyy-MM-dd').format(_info.date_killed).toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Slaughter Inspection', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.inspection.toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Live Weight', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.live_weight.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Carcass Weight', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.dead_weight.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          ListTile(
                            title: Text( 'Meat Quality Grade', style: TextStyle(color: Colors.white70,fontSize: 15)),
                            subtitle: Text( _info.grade.toString()  , style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Container(

              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Card(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.green,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Center(child: Text( 'DATA ON EXTREMITIES', style: TextStyle(color: Colors.white,fontSize: 22))),
                      ),
                      ListTile(
                        title: Text( 'Head', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.head.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Legs', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.legs.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Kidney', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.kidney.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Skin', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.skin.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Gall Bladder', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.bladder.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(

              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Card(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.cyan,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Center(child: Text( 'DATA ON OFFALS', style: TextStyle(color: Colors.white,fontSize: 22))),
                      ),
                      ListTile(
                        title: Text( 'Heart', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.heart.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Intestines', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.isaw.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Liver', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.liver.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Lungs', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.lungs.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Stomach', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.stomach.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                      ListTile(
                        title: Text( 'Spleen', style: TextStyle(color: Colors.white70,fontSize: 15)),
                        subtitle: Text( _info.spleen.toString()+" kg"  , style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void ShowDialog(BuildContext context){


  showDialog(
  context: context,
    builder: (BuildContext context){

      return AlertDialog(

        title: Text('Confirm'),

        content: Text('Are you sure you want to save this data?'),

        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          FlatButton(
            child: new Text("Yes"),
            onPressed: () {
             // _info.isValid = true;
              Navigator.of(context).pop();

              _info.saveRecord(context);

            },
          ),
          FlatButton(
            child: new Text("Close"),
            onPressed: () {
              print(123);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );
}

void validatePage(BuildContext context){
  if( _info.isValid ){

    Navigator.push(context, MaterialPageRoute(

        builder: (BuildContext context){

          if( _info.currentPage == 1 ){
            return MyCustomForm2();
          }else if(_info.currentPage == 2){
            return  MyCustomForm3();
          }else if(_info.currentPage == 3){
            return MyCustomForm4();
          }else if(_info.currentPage == 4){
            return MyCustomForm5();
          }
          return null;
        }
    )
    );
  }else{
    print('Not saved');
  }

}
