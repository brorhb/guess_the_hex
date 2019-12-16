import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_hex/extentions/color.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: (MediaQuery.of(context).size.width / 4) * 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: HexColor.fromHex('212124'),
      ),
      child: Text(
        'Guess the background color hex',
        style: GoogleFonts.sourceCodePro(
          fontSize: 20,
          textStyle: TextStyle(
            color: Colors.white
          )
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}