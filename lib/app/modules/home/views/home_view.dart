import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Виджет для отображения состояния игры
          Obx(() {
            String gameStateText = '';
            switch (controller.gameState.value) {
              case GameState.player1Turn:
                gameStateText = 'Ход крестиков';
                break;
              case GameState.player2Turn:
                gameStateText = 'Ход ноликов';
                break;
              case GameState.tie:
                gameStateText = 'Ничья';
                break;
              case GameState.player1Win:
                gameStateText = 'Победа крестиков';
                break;
              case GameState.player2Win:
                gameStateText = 'Победа ноликов';
                break;
              default:
                gameStateText = '';
                break;
            }
            return Text(
              gameStateText,
              style: TextStyle(fontSize: 20),
            );
          }),
          // Игровое поле
          Expanded(
            child: Center(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      controller.onCellTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Obx(
                          () {
                            final value = controller.gameBoard[index];
                            if (value == 1) {
                              return const Icon(Icons.close, size: 48,color: Color.fromARGB(255, 255, 17, 0),);
                            } else if (value == -1) {
                              return const Icon(Icons.circle, size: 48,color: Color.fromARGB(255, 0, 90, 163),);
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.resetGame();
            },
            child: const Text('Начать заново'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
