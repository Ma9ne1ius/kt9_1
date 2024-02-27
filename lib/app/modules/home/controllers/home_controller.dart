import 'package:get/get.dart';

enum GameState {
  player1Turn,
  player2Turn,
  tie,
  player1Win,
  player2Win,
}

class HomeController extends GetxController {
  final gameState = GameState.player1Turn.obs;
  final gameBoard = List<int>.filled(9, 0).obs;

  final winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // горизонтали
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // вертикали
    [0, 4, 8], [2, 4, 6], // диагонали
  ];

  void onCellTap(int index) {
    if (gameBoard[index] != 0 || isGameOver()) return;

    final currentPlayer = gameState.value == GameState.player1Turn ? 1 : -1;
    gameBoard[index] = currentPlayer;

    if (isGameOver()) {
      gameState.value = checkWin(currentPlayer) ? 
        currentPlayer == 1 ? GameState.player1Win : GameState.player2Win : 
        GameState.tie;
    } else {
      gameState.value = gameState.value == GameState.player1Turn ? 
        GameState.player2Turn : 
        GameState.player1Turn;
    }
  }

  bool isGameOver() {
    return gameBoard.every((cell) => cell != 0) || checkWin(1) || checkWin(-1);
  }

  bool checkWin(int player) {
    return winPatterns.any((pattern) => pattern.every((index) => gameBoard[index] == player));
  }

  void resetGame() {
    gameState.value = GameState.player1Turn;
    gameBoard.fillRange(0, 9, 0);
  }
}
