import 'package:flutter/material.dart';
import 'package:guess_the_hex/provider/game_state.dart';
import 'package:guess_the_hex/src/widgets/controls.dart';
import 'package:guess_the_hex/src/widgets/hex_input.dart';
import 'package:guess_the_hex/src/widgets/message_box.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    GameState gameState = Provider.of<GameState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: gameState.color,
        child: SafeArea(
          top: true,
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 9),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MessageBox(),
                  Container(padding: EdgeInsets.only(top: 16)),
                  HexInput(),
                  Container(padding: EdgeInsets.only(top: 8)),
                  Controls()
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}