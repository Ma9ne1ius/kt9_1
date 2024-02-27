import 'package:get/get.dart';

// Перечисление для состояния игры
enum GameState {
  player1Turn,
  player2Turn,
  tie,
  player1Win,
  player2Win,
}

class HomeController extends GetxController {
  // Состояние игры
  final gameState = GameState.player1Turn.obs;

  // Игровое поле: -1 - нолик, 0 - пусто, 1 - крестик
  final List<int> gameBoard = List<int>.filled(9, 0).obs;

  // Матрица выигрышных комбинаций
  final winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // горизонтали
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // вертикали
    [0, 4, 8], [2, 4, 6], // диагонали
  ];

  // Метод для обработки нажатия на ячейку игрового поля
  void onCellTap(int index) {
    // Если ячейка уже занята или игра завершена, ничего не делаем
    if (gameBoard[index] != 0 || isGameOver()) return;

    // Определяем, чей сейчас ход
    final currentPlayer = gameState.value == GameState.player1Turn ? 1 : -1;

    // Обновляем значение ячейки
    gameBoard[index] = currentPlayer;

    // Проверяем, завершена ли игра
    if (isGameOver()) {
      // Если игра завершена, меняем состояние игры
      if (checkWin(currentPlayer)) {
        gameState.value = currentPlayer == 1 ? GameState.player1Win : GameState.player2Win;
      } else {
        gameState.value = GameState.tie;
      }
    } else {
      // Если игра не завершена, меняем состояние игры
      gameState.value = gameState.value == GameState.player1Turn ? GameState.player2Turn : GameState.player1Turn;
    }
  }

  // Метод для проверки завершения игры
  bool isGameOver() {
    return gameBoard.every((cell) => cell != 0) || checkWin(1) || checkWin(-1);
  }

  // Метод для проверки выигрышной комбинации
  bool checkWin(int player) {
    return winPatterns.any((pattern) {
      return pattern.every((index) => gameBoard[index] == player);
    });
  }

  // Метод для сброса игры
  void resetGame() {
    gameState.value = GameState.player1Turn;
    gameBoard.fillRange(0, 9, 0);
  }
}
