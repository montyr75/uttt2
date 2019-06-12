import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/game_state.dart';
import '../widgets/main_board_view.dart';
import '../models/ttt_board.dart' show CellType;
import '../utils/utils.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameState>(context);

    if (state.winner != CellType.empty) {
      _showWinnerDialog(context, state);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'New Game',
              onPressed: () {
                state.newGame();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Player: ${enumToString(state.currentPlayer)}", style: TextStyle(fontSize: 25))),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: MainBoardView(state: state)),
          ),
          ],
        ),
      ),
    );
  }

  void _showWinnerDialog(BuildContext context, GameState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Center(child: Text("${enumToString(state.winner)} Wins!")),
            children: <Widget>[
              Center(
                child: SimpleDialogOption(
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    tooltip: 'New Game',
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              )
            ],
          );
        }
      );

      state.newGame();
    });
  }
}
