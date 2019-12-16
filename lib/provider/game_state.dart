import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_the_hex/extentions/color.dart';
import 'package:rxdart/subjects.dart';

class GameState with ChangeNotifier {
  String hexString;
  Color color;
  Random _random = Random();
  String input = '';

  BehaviorSubject<WinState> _didWin = BehaviorSubject<WinState>();
  Stream<WinState> get didWin => _didWin.stream;
  Function(WinState) get setWinState => _didWin.sink.add;

  BehaviorSubject<String> _hint = BehaviorSubject<String>();
  Stream<String> get hint => _hint.stream;
  Function(String) get _hintInput => _hint.sink.add;


  GameState() {
    reset();
  }

  void guess() {
    input = '#${input.toLowerCase()}';
    String hex = hexString.toLowerCase();
    _win(input == hex);
  }

  void reset() {
    hexString = _generateRandomHexColor();
    color = HexColor.fromHex(hexString);
    setWinState(WinState.none);
    _hintInput('');
    notifyListeners();
  }

  Function get _win => (bool w) {
    if (w == true) setWinState(WinState.win);
    else setWinState(WinState.loss);
    notifyListeners();
  };

  Function get createHint => () {
    _hintInput(hexString.substring(0, 4));
    notifyListeners();
  };

  String _generateRandomHexColor(){
    int length = 6;
    String chars = '0123456789ABCDEF';
    String hex = '#';
    while(length-- > 0) hex += chars[(_random.nextInt(16)) | 0];
    return hex;
  }

  @override
  void dispose() {
    _hint.close();
    super.dispose();
  }
}

enum WinState {
  none,
  loss,
  win
}