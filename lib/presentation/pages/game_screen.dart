import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/home_page.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;

  const GameScreen({
    Key? key,
    required this.player1, 
    required this.player2
  }) : super(key: key);
  
  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  late List<List<String>> board;
  late String currentPlayer;
  late bool gameOver;
  late String winner = "";
  late int player1Score;
  late int player2Score;

  @override
  void initState() {
    super.initState();
    currentPlayer = "X";
    gameOver = false;
    player1Score = 0;
    player2Score = 0;
    resetBoard();
  }

  void resetBoard() {
    setState(() {
      board = List<List<String>>.generate(3, (_) => List<String>.filled(3, ''));
    });
  }

  void resetGame() {
    setState(() {
      resetBoard();
      currentPlayer = "X";
      gameOver = false;
    });
  }

  void restartGame() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirmation",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: const Text(
            "Are you sure you want to restart the game?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text(
                "Restart",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Make Move
  void makeMove(int row, int col) {
    if (board[row][col] != "" || gameOver) {
      return;
    }

    // Check for winner
    setState(() {
      board[row][col] = currentPlayer;
      if (board[row][0] == currentPlayer &&
          board[row][1] == currentPlayer &&
          board[row][2] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
        updateScores();
        winner = winner == "X" ? widget.player1 : widget.player2;
        showWinDialog(winner);
      } else if (board[0][col] == currentPlayer &&
          board[1][col] == currentPlayer &&
          board[2][col] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
        updateScores();
        winner = winner == "X" ? widget.player1 : widget.player2;
        showWinDialog(winner);
      } else if (board[0][0] == currentPlayer &&
          board[1][1] == currentPlayer &&
          board[2][2] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
        updateScores();
        winner = winner == "X" ? widget.player1 : widget.player2;
        showWinDialog(winner);
      } else if (board[0][2] == currentPlayer &&
          board[1][1] == currentPlayer &&
          board[2][0] == currentPlayer) {
        winner = currentPlayer;
        gameOver = true;
        updateScores();
        winner = winner == "X" ? widget.player1 : widget.player2;
        showWinDialog(winner);
      }

      // Check for a tie
      if (!gameOver && !board.any((row) => row.any((cell) => cell == ""))) {
        gameOver = true;
        winner = "Draw";
        updateScores();
        showTieDialog();
      }

      // Switch players
      currentPlayer = currentPlayer == "X" ? "O" : "X";
    });
  }

  // Update player scores
  void updateScores() {
    if (winner == "X") {
      player1Score += 3;
    } else if (winner == "O") {
      player2Score += 3;
    } else {
      player1Score++;
      player2Score++;
    }
  }

// Show dialog for win message
  void showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Congratulations!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            "$winner  wins !",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for tie message
  void showTieDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Draw!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: const Text(
            "The game ended in a tie.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Column(
        children: [
          Container(
            height: 120,
            color: Colors.deepPurple[50],
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.red,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "X",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      widget.player1,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      player1Score.toString(),
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0E1E3A),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      player2Score.toString(),
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.green,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "O",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      widget.player2,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final row = index ~/ 3;
              final col = index % 3;
              return GestureDetector(
                onTap: () => makeMove(row, col),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E1E3A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      board[row][col],
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: board[row][col] == "X"
                            ? const Color(0xFFE25041)
                            : const Color(0xFF1CBD9E),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: resetGame,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: const Text(
                    "Play Again",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: restartGame,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: const Text(
                    "Reset Game",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
