import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import '../models/ttt_board.dart' show CellType;
import 'grid_layout.dart';
import 'ttt_cell_view.dart';

class TTTBoardView extends StatefulWidget {
  final index;
  final List<CellType> boardData;
  final List<int> availableCells;
  final Function(int boardIndex, int cellIndex) onCellSelected;

  const TTTBoardView({
    Key key,
    @required this.index,
    @required this.boardData,
    @required this.availableCells,
    @required this.onCellSelected
  }) : super(key: key);

  @override
  _TTTBoardViewState createState() => _TTTBoardViewState();
}

class _TTTBoardViewState extends State<TTTBoardView> {
  int _lastSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: GridLayout(
        width: 3,
        children: List<Widget>.generate(widget.boardData.length, _cellBuilder),
      ),
    );
  }

  Widget _cellBuilder(int index) {
    final cellView = TTTCellView(
      index: index,
      type: widget.boardData[index],
      onSelected: _handleCellSelected,
      available: isCellAvailable(index),
    );

    if (_lastSelectedIndex == index) {
      _lastSelectedIndex = null;

      return FadeIn(
        duration: const Duration(milliseconds: 500),
        child: cellView,
      );
    }

    return cellView;
  }

  void _handleCellSelected(int cellIndex) {
    _lastSelectedIndex = cellIndex;
    widget.onCellSelected(widget.index, cellIndex);
  }

  bool isCellAvailable(int index) => widget.availableCells.contains(index);
}
