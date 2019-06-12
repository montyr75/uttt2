import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'state/game_state.dart';
import 'pages/home_page.dart';

void main() {
  // stay in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(UTTT());
}

class UTTT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ultimate Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<GameState>(
          builder: (context) => GameState(),
          child: HomePage(title: 'Ultimate Tic-Tac-Toe')
      ),
    );
  }
}
