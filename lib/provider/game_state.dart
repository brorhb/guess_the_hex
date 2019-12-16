import 'dart:math';

import 'package:delta_e/delta_e.dart';
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

  BehaviorSubject<String> _distance = BehaviorSubject<String>();
  Stream<String> get distance => _distance.stream;
  Function(String) get _addDistance => _distance.sink.add;

  BehaviorSubject<String> _error = BehaviorSubject<String>();
  Stream<String> get error => _error.stream;
  Function(String) get _addError => _error.sink.add;

  GameState() {
    reset();
  }

  void guess() {
    if (input.isEmpty || input.length < 6) {
      _addError('A hex string have 6 characters, not ${input.length}');
      return;
    }
    String hex = hexString.toLowerCase();
    Color inputColor = HexColor.fromHex(input);
    Color hexColor = HexColor.fromHex(hexString);
    LabColor labInput = LabColor.fromRGB(inputColor.red, inputColor.green, inputColor.blue);
    LabColor labHex = LabColor.fromRGB(hexColor.red, hexColor.green, hexColor.blue);
    _addDistance(deltaE(labInput, labHex).toString());
    _win('#${input.toLowerCase()}' == hex);
  }

  void reset() {
    hexString = _generateRandomHexColor();
    color = HexColor.fromHex(hexString);
    setWinState(WinState.none);
    _hintInput('');
    _addError('');
    input = '';
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
    _didWin.close();
    _distance.close();
    _error.close();
    super.dispose();
  }
}

enum WinState {
  none,
  loss,
  win
}