import 'package:flutter/material.dart';
import '../widget/auth.dart';
import '../widget/auth_provider.dart';
import '../widget/const.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'products.dart';
import 'visits.dart';
import 'appointment.dart';
import 'customer_create.dart';
import 'customer_info.dart';

class MyTabbedPage extends StatefulWidget {

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}


class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {

  _MyTabbedPageState({this.onSignedOut});
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }



  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: GradientAppBar(
          title: Text("Dashboard"),
          gradient: LinearGradient(colors: [color3, color2])
      ),
      bottomNavigationBar: new TabBar(
        controller: tabController,
        // labelColor: Colors.red,
        // labelColor: Colors.redAccent,
        unselectedLabelColor: color3,
        labelStyle: TextStyle(fontSize: 10.0,fontFamily: 'ubuntu'),  //For Selected tab
        unselectedLabelStyle: TextStyle(fontSize: 9.0,fontFamily: 'ubuntu'), //For Un-selected Tabs
        indicatorSize: TabBarIndicatorSize.tab,
        indicator:  BoxDecoration(
            gradient: LinearGradient(
                colors: [color3, color1]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            color: Colors.red
        ),

        onTap: (index) {
          // Tab index when user select it, it start from zero
          // print("tap ");
          print(index);
        },
        tabs: myTabs,
      ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          ListView(

              children: <Widget>[

                SizedBox(height: 0),
                Container(
                    height: height,
                    color: Color(0xffF0F0F0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      physics: ScrollPhysics(), // to disable GridView's scrolling
                      shrinkWrap: true,
                      padding: EdgeInsets.all(6.0),
                      children: new List<Widget>.generate(5, (index) {
                        return new GridTile(
                          child: new Card(
                              color: c1,
                              margin: EdgeInsets.all(6.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    print('Card $index tapped');
                                    var grade = index.toString();
                                    switch(grade) {
                                      case "0": {  tabController.animateTo(1);  }
                                      break;

                                      case "1": {  tabController.animateTo(1);  }
                                      break;

                                      case "2": {   Navigator.push(
                                        context,  MaterialPageRoute(builder: (context) => CustomerCreate()),
                                      );  }
                                      break;

                                      case "3": {  tabController.animateTo(3);  }
                                      break;

                                      case "4": {  tabController.animateTo(2);  }
                                      break;

                                      case "5": {  print("Poor");  }
                                      break;

                                      default: { print("Invalid choice"); }
                                      break;
                                    }
                                  },
                                  child: new Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding:  EdgeInsets.fromLTRB(20, 20, 20, 0),
                                          height: 100,
                                          child: buttons[index].image,
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          buttons[index].text,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: c4,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontFamily: 'ubuntu'),
                                        ) // text
                                      ],
                                    ),
                                  )
                              )
                          ),
                        );
                      }),
                    ))]),
          ProductPage(context: context),
          Appointment(),// CustomerCreate(), //FileUpload(), // Appointment(),// Testpage(),
          Visit(),//Testpage()// Visit(),
        ],
      ),
    );
  }
}
