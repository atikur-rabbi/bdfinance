import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../widget/fireauth.dart';
import '../widget/const.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final TextEditingController _mobileFilter = new TextEditingController();
  final TextEditingController _nameFilter = new TextEditingController();
  final TextEditingController _messageFilter = new TextEditingController();
  final TextEditingController _dateFilter = new TextEditingController();

  String _mobile = "";
  String _name = "";
  String _message = "";
  String _date = "Select Date";

  _AppointmentState() {
    _mobileFilter.addListener(_mobileListen);
    _nameFilter.addListener(_nameListen);
    _messageFilter.addListener(_messageListen);
    _dateFilter.addListener(_selectDate);
  }

  void _mobileListen() {
    if (_mobileFilter.text.isEmpty) {
      _mobile = "";
    } else {
      _mobile = _mobileFilter.text;
    }
  }

  void _nameListen() {
    if (_nameFilter.text.isEmpty) {
      _name = "";
    } else {
      _name = _nameFilter.text;
    }
  }

  void _messageListen() {
    if (_messageFilter.text.isEmpty) {
      _message = "";
    } else {
      _message = _messageFilter.text;
    }
  }

void _selectDate() {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onChanged: (date) {
        print('change $date in time zone ' +
            date.timeZoneOffset.inHours.toString());

        setState(() {
          _date = date.toString();
        });
      },
      onConfirm: (date) {
        print('confirm $date');
        setState(() {
          _date = date.toString();
        });
        
      },
    );
  }


  Widget _entryField(String title, final TextEditingController controllerName,
       {bool isMessage = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              
              controller: controllerName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: color4,
                  filled: true))
        ],
      ),
    );
  }

  Widget _customButton(String title) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [color2, color3])),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  void __submit() {
    print("The user wants a Mobile: $_mobile  Name: $_name Message: $_message Date: $_date");
    var data = {
      'mobile': _mobile,
      'name': _name,
      'message': _message,
      'date_time': _date 
    };
    String collectionName = "appoinment";
    FireAuth.createRecord(collectionName,data);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            _entryField("Mobile", _mobileFilter),
            _entryField("Name", _nameFilter),
            //_entryField("Date Time", _dateFilter),
            
            FlatButton(
                onPressed: () {
                  _selectDate();
                },
                child: Text(
              '$_date',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),),
            _entryField("Message", _messageFilter),
            new FlatButton(
              child: _customButton("Submit"),
              onPressed: __submit,
            ),
          ],
        ),
      ),
    );
  }
}
