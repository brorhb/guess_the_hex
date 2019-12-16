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
      String distance = '';
      gameState.distance.listen((String d) {
        distance = d;
      });
      gameState.didWin.listen((WinState state) {
        if (state == WinState.win || state == WinState.loss) {
          String title = state == WinState.win ? 'Correct!' : 'Sorry...';
          String correct = gameState.hexString;
          String guess = gameState.input;
          String _distance = distance;
          TextStyle _style = GoogleFonts.sourceCodePro(
            textStyle: TextStyle(color: Colors.white)
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: HexColor.fromHex('212124'),
                title: Text(title, style: _style),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(children: <Widget>[
                      CircleAvatar(backgroundColor: HexColor.fromHex(gameState.input)),
                      Container(padding: EdgeInsets.only(right: 4)),
                      Expanded(child: Text('Your guess: #${guess.toLowerCase()}', style: _style))
                    ]),
                    Container(padding: EdgeInsets.only(top: 8)),
                    Row(children: <Widget>[
                      CircleAvatar(backgroundColor: gameState.color),
                      Container(padding: EdgeInsets.only(right: 4)),
                      Expanded(child: Text('Correct color: ${correct.toLowerCase()}', style: _style))
                    ]),
                    Container(padding: EdgeInsets.only(top: 8)),
                    Text('Distance: $_distance*', style: _style),
                    Container(padding: EdgeInsets.only(top: 16)),
                    Text(
                      '*closer to 0 is better',
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 12,
                        textStyle: TextStyle(color: Colors.white)
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    textColor: Colors.grey,
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    textColor: Colors.yellowAccent,
                    child: Text('Next Challenge'),
                    onPressed: () {
                      gameState.reset();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
          );
        }
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