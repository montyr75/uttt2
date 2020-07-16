import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import '../models/ttt_board.dart' show CellType;
import '../state/game_state.dart';
import 'grid_layout.dart';
import 'ttt_board_view.dart';
import '../utils/utils.dart';

class MainBoardView extends StatefulWidget {
  static const borderSide = BorderSide(
    color: Colors.black,
    width: 2.0,
    style: BorderStyle.solid
  );

  final GameState state;

  const MainBoardView({Key key, @required this.state}) : super(key: key);

  @override
  _MainBoardViewState createState() => _MainBoardViewState();
}

class _MainBoardViewState extends State<MainBoardView> {
  int _lastSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      width: 3,
      children: List<Widget>.generate(widget.state.mainBoardData.length, _cellBuilder)
    );
  }

  Widget _cellBuilder(int index) {
    // what's in this cell?
    final type = widget.state.mainBoardData[index];

    // "empty" cells have a sub board in them
    Widget content;
    if (type == CellType.empty) {
      content = TTTBoardView(
        index: index,
        boardData: widget.state.getSubBoardData(index),
        availableCells: widget.state.availableSubCells[index] ?? [],
        onCellSelected: _handleCellSelected
      );
    }
    else {
      final box = FittedBox(fit: BoxFit.fill, child: Text(enumToString(type)));

      if (_lastSelectedIndex == index) {
        _lastSelectedIndex = null;

        content = FadeIn(
          duration: const Duration(milliseconds: 500),
          child: box,
        );
      }
      else {
        content = box;
      }
    }

    return Container(
      margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(border: determineCellBorder(index, MainBoardView.borderSide)),
      child: content,
    );
  }

  void _handleCellSelected(int mainCellIndex, int subCellIndex) {
    _lastSelectedIndex = mainCellIndex;
    widget.state.move(mainCellIndex, subCellIndex);
  }
}
