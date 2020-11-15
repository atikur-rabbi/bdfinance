import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/const.dart';

// Sample Item for test
class TitleUi extends StatelessWidget {
  const TitleUi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'BD',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: color1,
          ),
          children: [
            TextSpan(
              text: ' Fina',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'nce',
              style: TextStyle(color: color1, fontSize: 30),
            ),
          ]),
    );
  }
}