import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_hex/extentions/color.dart';
import 'package:guess_the_hex/provider/game_state.dart';
import 'package:provider/provider.dart';

class HexInput extends StatefulWidget {
  HexInput({Key key}) : super(key: key);

  @override
  _HexInputState createState() => _HexInputState();
}

class _HexInputState extends State<HexInput> {

  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration.zero, () {
      GameState gameState = Provider.of<GameState>(context);
      gameState.hint.listen((String hint) {
        if (hint.isNotEmpty) Scaffold.of(context).showSnackBar(SnackBar(
          content: Row(
            children: <Widget>[
              Text(
                'Hint: ',
                style: GoogleFonts.sourceCodePro(),
              ),
              Text(
                '$hint',
                style: GoogleFonts.sourceCodePro(
                  fontWeight: FontWeight.bold,
                  textStyle: TextStyle(
                    color: Colors.yellow
                  )
                ),
              )
            ],
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    GameState gameState = Provider.of<GameState>(context);
    return Container(
      width: (MediaQuery.of(context).size.width / 4) * 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: HexColor.fromHex('212124'),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '#',
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                  ),
                ),
                Container(padding: EdgeInsets.only(left: 4)),
                Expanded(
                  child: Form(
                    child: TextFormField(
                      onChanged: (String input) {
                        gameState.input = input;
                      },
                      autocorrect: false,
                      autovalidate: true,
                      validator: (String input) {
                        if (input.length > 6) return 'To long input';
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.white
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}