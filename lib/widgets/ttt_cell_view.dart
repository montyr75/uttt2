import 'package:flutter/material.dart';

import '../models/ttt_board.dart' show CellType;
import '../utils/utils.dart';

class TTTCellView extends StatelessWidget {
  static const borderSide = BorderSide(
    color: Colors.grey,
    width: 1.0,
    style: BorderStyle.solid
  );

  final int index;
  final CellType type;
  final Function(int index) onSelected;
  final bool available;

  const TTTCellView({Key key, @required this.index, @required this.type, @required this.onSelected, this.available = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          border: determineCellBorder(index, borderSide),
          color: available ? Colors.blue[50] : null),
        child: _buildCellContent(),
      ),
    );
  }

  Widget _buildCellContent() {
    return type != CellType.empty ?
      FittedBox(
        fit: BoxFit.fill,
        child: Text(enumToString(type), style: TextStyle(color: Colors.grey[700]))
      ) : Container();
  }

  void _handleTap() {
    if (type == CellType.empty && available) {
      onSelected(index);
    }
  }
}
