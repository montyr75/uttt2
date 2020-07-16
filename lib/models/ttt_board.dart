class TTTBoard {
  static const List<List<int>> winPatterns = [
    [0, 1, 2], // row 1
    [3, 4, 5], // row 2
    [6, 7, 8], // row 3
    [0, 3, 6], // col 1
    [1, 4, 7], // col 2
    [2, 5, 8], // col 3
    [0, 4, 8], // diag 1
    [2, 4, 6]  // diag 2
  ];

  List<CellType> _grid = List<CellType>.filled(9, CellType.empty);
  List<CellType> get grid => List.unmodifiable(_grid);

  int _moveCount = 0;

  CellType getWinner() {
    for (List<int> winPattern in winPatterns) {
      final square1 = _grid[winPattern[0]];
      final square2 = _grid[winPattern[1]];
      final square3 = _grid[winPattern[2]];

      // if all three squares match and aren't empty, there's a win
      if (square1 != CellType.empty &&
          square1 == square2 &&
          square2 == square3) {
        return square1;
      }
    }

    // if we get here, there is no win
    return CellType.empty;
  }

  CellType move(int cellIndex, CellType player) {
    _grid[cellIndex] = player;
    _moveCount++;
    return getWinner();
  }

  bool get isFull => _moveCount >= 9;
  bool get isNotFull => !isFull;

  List<int> get emptyCells {
    List<int> empties = [];

    for (int i = 0; i < _grid.length; i++) {
      if (_grid[i] == CellType.empty) {
        empties.add(i);
      }
    }

    return List.unmodifiable(empties);
  }

  CellType operator [](int square) => _grid[square];

  @override
  String toString() {
    return """
${cellTypeToString(_grid[0])} | ${cellTypeToString(_grid[1])} | ${cellTypeToString(_grid[2])}
${cellTypeToString(_grid[3])} | ${cellTypeToString(_grid[4])} | ${cellTypeToString(_grid[5])}
${cellTypeToString(_grid[6])} | ${cellTypeToString(_grid[7])} | ${cellTypeToString(_grid[8])}
    """;
  }
}

enum CellType {
  X,
  O,
  empty
}

String cellTypeToString(CellType type) {
  switch (type) {
    case CellType.empty: return ' '; break;
    case CellType.X: return 'X'; break;
    case CellType.O: return 'O'; break;
    default: return null;
  }
}