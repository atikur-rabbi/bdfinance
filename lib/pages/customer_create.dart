import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/fireauth.dart';
//import '../controller/custom_ui.dart';
import '../widget/const.dart';
import '../ui/custom_button.dart';
import 'dart:io';
import 'package:gradient_app_bar/gradient_app_bar.dart';
//import 'package:path/path.dart';

class CustomerCreate extends StatefulWidget {
  @override
  _CustomerCreateState createState() => _CustomerCreateState();
}

class _CustomerCreateState extends State<CustomerCreate> {
  final TextEditingController _mobileFilter = new TextEditingController();
  final TextEditingController _nameFilter = new TextEditingController();
  final TextEditingController _addressFilter = new TextEditingController();
  final TextEditingController _birthdateFilter = new TextEditingController();
  final TextEditingController _professionFilter = new TextEditingController();
  final TextEditingController _networthFilter = new TextEditingController();

  File _image;
  
  String _name = "";
  String _mobile = "";
  String _address = "";
  String _profession = "";
  String _networth = "";
  String _birthdate = "Birthday: Select Date";
  String _imageURL = "";
  String _makedeposit = "";

  _CustomerCreateState() {
    _mobileFilter.addListener(_mobileListen);
    _nameFilter.addListener(_nameListen);
    _addressFilter.addListener(_addressListen);
    _birthdateFilter.addListener(_selectDate);
    _addressFilter.addListener(_addressListen);
    _professionFilter.addListener(_professionListen);
    _networthFilter.addListener(_netWorthListen);
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

  void _addressListen() {
    if (_addressFilter.text.isEmpty) {
      _address = "";
    } else {
      _address = _addressFilter.text;
    }
  }

  void _professionListen() {
    if (_professionFilter.text.isEmpty) {
      _profession = "";
    } else {
      _profession = _professionFilter.text;
    }
  }

  void _netWorthListen() {
    if (_networthFilter.text.isEmpty) {
      _networth = "";
    } else {
      _networth = _networthFilter.text;
    }
  }

void _selectDate() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      onChanged: (date) {
        print('change $date in time zone ' +
            date.timeZoneOffset.inDays.toString());

        setState(() {
        //  _birthdate = date.day.toString();
        });
      },
      onConfirm: (date) {
        print('confirm $date');
        setState(() {
          _birthdate = "Birthday: "+date.day.toString()+"-"+date.month.toString()+"-"+date.year.toString();
        });
        
      },
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }


  Widget _entryField(String title, final TextEditingController controllerName,
       {bool isMessage = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20,),
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

  void __submit() async {
    _imageURL = await FireAuth.uploadPicdata(_image);
    var data = {
      'mobileNo': _mobile,
      'name': _name,
      'address': _address,
      'profession': _profession,
      'networth': _networth,
      'birthdate': _birthdate,
      'profession': _profession,
      'imageURL': _imageURL,
      'makedeposit': _makedeposit,
    };

    String collectionName = "visit";
    FireAuth.createRecord(collectionName,data);
  }

/*  void getImageURL() async {
    _imageURL = await FireAuth.uploadPicdata(_image);
    print(_imageURL);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: Text("Create User"),
          gradient: LinearGradient(colors: [color3, color2])
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            _entryField("Name", _nameFilter),
            _entryField("Mobile", _mobileFilter),
            _entryField("Address", _addressFilter),
            _entryField("Profession", _professionFilter),
            _entryField("Approximate Net worth", _networthFilter),
            //_entryField("Date Time", _dateFilter),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: FlatButton(
                onPressed: () {
                  _selectDate();
                },
                child: Text(
              '$_birthdate',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),),),
            new FlatButton(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child:(_image!=null)?Image.file(
                _image,
                fit: BoxFit.fill,
              ):Image.network(
                "https://atikur-rabbi.github.io/fakeapi/profile.png",
                fit: BoxFit.fill,
              )),
              onPressed: getImage,
            ),

            new FlatButton(
              child: CustomButton(itemText: "Submit"),
              onPressed: __submit,
            ),
          ],
        ),
      ),
    );
  }
}
