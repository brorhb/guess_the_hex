import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_hex/extentions/color.dart';
import 'package:guess_the_hex/provider/game_state.dart';
import 'package:provider/provider.dart';

class Controls extends StatefulWidget {
  const Controls({Key key}) : super(key: key);

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {

  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration.zero, () {
      GameState gameState = Provider.of<GameState>(context);
      gameState.didWin.listen((WinState state) {
        if (state == WinState.win) Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Correct!'),
          action: SnackBarAction(
            label: 'Next challenge!',
            onPressed: () {
              gameState.reset();
            },
          ),
        ));
        if (state == WinState.loss) Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Sorry! That was wrong 😅',
            style: GoogleFonts.sourceCodePro(),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    GameState gameState = Provider.of<GameState>(context);

    TextStyle _textStyle = GoogleFonts.sourceCodePro(
      fontWeight: FontWeight.bold,
      textStyle: TextStyle(
        color: Colors.white
      )
    );

    ShapeBorder _shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16))
    );


    return Column(
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width / 4) * 2.5,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: FlatButton(
                    shape: _shape,
                    color: HexColor.fromHex('212124'),
                    child: Text(
                      'Hint',
                      style: _textStyle,
                    ),
                    onPressed: () {
                      gameState.createHint();
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 4),
                  child: FlatButton(
                    shape: _shape,
                    color: HexColor.fromHex('212124'),
                    child: Text(
                      'New color',
                      style: _textStyle,
                    ),
                    onPressed: () {
                      gameState.reset();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width / 4) * 2.5,
          child: FlatButton(
            shape: _shape,
            color: HexColor.fromHex('212124'),
            child: Text(
              'Guess!',
              style: _textStyle,
            ),
            onPressed: () {
              gameState.guess();
            },
          ),
        )
      ],
    );
  }
}