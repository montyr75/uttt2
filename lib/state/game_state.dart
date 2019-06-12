import 'package:flutter/foundation.dart';

import '../models/ttt_board.dart';

class GameState with ChangeNotifier {
  CellType _currentPlayer;
  CellType get currentPlayer => _currentPlayer;

  TTTBoard _mainBoard;
  List<TTTBoard> _subBoards;

  List<int> _availableMainCells;

  Map<int, List<int>> _availableSubCells;
  Map<int, List<int>> get availableSubCells => _availableSubCells;

  CellType _winner;
  CellType get winner => _winner;

  GameState() {
    newGame();
  }

  void newGame() {
    _currentPlayer = CellType.X;

    _mainBoard = TTTBoard();
    _subBoards = List<TTTBoard>.generate(9, (_) => TTTBoard());

    _availableMainCells = _mainBoard.emptyCells;
    _findAvailableSubCells();

    _winner = CellType.empty;

    notifyListeners();
  }

  void _findAvailableSubCells() {
    _availableSubCells = {};

    for (int mainCellIndex in _availableMainCells) {
      _availableSubCells[mainCellIndex] = _subBoards[mainCellIndex].emptyCells;
    }
  }

  void move(int mainCellIndex, int subCellIndex) {
    // make move on sub board
    final subBoardWinner = _subBoards[mainCellIndex].move(subCellIndex, currentPlayer);

    // if there is a sub winner, make move on main board
    if (subBoardWinner != CellType.empty) {
      _winner = _mainBoard.move(mainCellIndex, _currentPlayer);
    }

    // if there's no winner yet, go to next turn
    if (winner == CellType.empty) {
      if (_mainBoard[subCellIndex] == CellType.empty && _subBoards[subCellIndex].isNotFull) {
        _availableMainCells = [subCellIndex];
      }
      else {
        _availableMainCells = _mainBoard.emptyCells;
      }

      _findAvailableSubCells();

      _currentPlayer = _currentPlayer == CellType.X ? CellType.O : CellType.X;
    }

    notifyListeners();
  }

  List<CellType> get mainBoardData => _mainBoard.board;
  List<CellType> getSubBoardData(int index) => _subBoards[index].board;
}