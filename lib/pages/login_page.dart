import 'package:flutter/material.dart';
import '../widget/auth.dart';
import '../widget/auth_provider.dart';
import '../ui/title.dart';
import '../ui/custom_button.dart';
import '../widget/custom_clipper.dart';
import '../widget/const.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String userId = await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          final String userId = await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      //appBar: AppBar(title: Text('Flutter login demo'),  ),
      body: Container(
        //color: Colors.redAccent,
        height: height,
        child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.all(16.0),
                child: new ListView(
                  children: <Widget>[
                    SizedBox(height: height * .08),
                    Container(
                      padding:  EdgeInsets.fromLTRB(20, 20, 20, 0),
                      height: 150,
                      child: Image.asset('images/undraw_finance_0bdk.png'),
                    ),
                  ],
                ),
              ),
              new ListView(
                  children: <Widget>[
                    Container(
                      //  color: Colors.green,
                      padding: EdgeInsets.all(0.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: buildInputs() + buildSubmitButtons(),
                        ),
                      ),
                    ),])
            ]),),
    );
  }


  List<Widget> buildInputs() {
    final height = MediaQuery.of(context).size.height;
    return <Widget>[  

      SizedBox(height: height/3),
      TitleUi(),
      SizedBox(height: 30),

      Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          SizedBox(height: 10),
          TextFormField(
            obscureText: false,
            validator: EmailFieldValidator.validate,
            onSaved: (String value) => _email = value,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide.none,
                  ),
                fillColor: color4,
                filled: true))]
      )),
      Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Password',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            validator: PasswordFieldValidator.validate,
            onSaved: (String value) => _password = value,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide.none,
                  ),
                fillColor: color4,
                filled: true))]
      )),

      // CustomButton(itemText: "Login")
    ];
  }
  

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        FlatButton(
          key: Key('signIn'),
          child: CustomButton(itemText: "Login"),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return <Widget>[
        FlatButton(
          child: CustomButton(itemText: "Create an account"),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
