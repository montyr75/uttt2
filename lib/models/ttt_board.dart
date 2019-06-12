class TTTBoard {
  static const List<List<int>> winPatterns = const [
    const [0, 1, 2], // row 1
    const [3, 4, 5], // row 2
    const [6, 7, 8], // row 3
    const [0, 3, 6], // col 1
    const [1, 4, 7], // col 2
    const [2, 5, 8], // col 3
    const [0, 4, 8], // diag 1
    const [2, 4, 6]  // diag 2
  ];

  List<CellType> _board;
  List<CellType> get board => List.unmodifiable(_board);

  int _moveCount = 0;

  TTTBoard() {
    _board = List<CellType>.filled(9, CellType.empty);
  }

  CellType getWinner() {
    for (List<int> winPattern in winPatterns) {
      var square1 = _board[winPattern[0]];
      var square2 = _board[winPattern[1]];
      var square3 = _board[winPattern[2]];

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
    _board[cellIndex] = player;
    _moveCount++;
    return getWinner();
  }

  bool get isFull => _moveCount >= 9;
  bool get isNotFull => !isFull;

  List<int> get emptyCells {
    List<int> empties = [];

    for (int i = 0; i < _board.length; i++) {
      if (_board[i] == CellType.empty) {
        empties.add(i);
      }
    }

    return List.unmodifiable(empties);
  }

  CellType operator [](int square) => _board[square];

  @override String toString() {
    String prettify(int square) => _board[square] ?? " ";

    return """
${prettify(0)} | ${prettify(1)} | ${prettify(2)}
${prettify(3)} | ${prettify(4)} | ${prettify(5)}
${prettify(6)} | ${prettify(7)} | ${prettify(8)}
    """;
  }
}

enum CellType {
  X,
  O,
  empty
}