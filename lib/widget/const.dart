import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var color1 = Color(0xffe46b10);
var color2 = Color(0xfffbb448);
var color3 = Color(0xfff7892b);
var color4 = Color(0xffEEEEEE);

Color c1 = const Color(0xFFFFFFFF);
Color c2 = const Color(0xFFF5F5F5);
Color c3 = color3;
//const Color(0xFF283593);
Color c4 = color3;

var globalTabIndex = 2;

class Buttons {
  String text;
  IconData icon;
  Image image;
  // constructor
  Buttons(this.text, this.icon, this.image);
}

var buttons = [
  Buttons("Deposit Products", FontAwesomeIcons.handHoldingUsd, Image.asset('images/deposit.png')),
  Buttons("Loan Products", FontAwesomeIcons.coins, Image.asset('images/loan.png')),
  Buttons("Customer Info", FontAwesomeIcons.idCard, Image.asset('images/customer_info.png')),
  Buttons("All Visit", FontAwesomeIcons.users, Image.asset('images/visits.png')),
  Buttons("Appoinment", FontAwesomeIcons.calendarCheck, Image.asset('images/appoinment.png')),
];

final List<Tab> myTabs = <Tab>[
  new Tab(
    text: 'Home',
    icon: FaIcon(FontAwesomeIcons.home),
  ),
  new Tab(
    text: 'Products',
    icon: FaIcon(FontAwesomeIcons.moneyCheck),
  ),
  new Tab(
    text: 'Appoinment',
    icon: FaIcon(FontAwesomeIcons.calendarCheck),
  ),
  new Tab(
    text: 'Visits',
    icon: FaIcon(FontAwesomeIcons.users),
  ),
];