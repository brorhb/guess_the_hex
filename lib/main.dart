import 'package:flutter/material.dart';
import 'package:guess_the_hex/provider/game_state.dart';
import 'package:guess_the_hex/src/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GameState>(
          create: (_) => GameState(),
        )
      ],
      child: App(),
    )
  );
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}