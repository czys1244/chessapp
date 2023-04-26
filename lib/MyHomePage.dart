import 'package:chessapp/pieces/Bishop.dart';
import 'package:chessapp/pieces/King.dart';
import 'package:chessapp/pieces/Knight.dart';
import 'package:chessapp/pieces/Pawn.dart';
import 'package:chessapp/pieces/Piece.dart';
import 'package:chessapp/pieces/Position.dart';
import 'package:chessapp/pieces/Queen.dart';
import 'package:chessapp/pieces/Rook.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'Game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<bool>> isCellSelected = [
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
  ];

  late final double screenWidth = MediaQuery.of(context).size.width / 8.0;
  final Color brown = const Color.fromRGBO(181, 136, 99, 100);
  final Color white = const Color.fromRGBO(240, 217, 181, 100);
  final Color blue = const Color.fromRGBO(129, 229, 229, 100);
  final Color transparent = const Color.fromRGBO(129, 229, 229, 0);
  late Color col = transparent;
  bool back=false;
  String message = "Ruch białych";
  Game game = Game.newGame();
  List<Piece> prev = [];
  int a = 0;

  List<Piece> get pieces => game.pieces;

  Color _setColor(int x, int y) {
    Color c = (x.isEven && y.isEven) || (x.isOdd && y.isOdd) ? brown : white;
    return c;
  }

  void resetGame() {
    setState(() {
      game = game.startNewGame();
      message = "Ruch białych";
      back=false;
      clearBorders();
    });
  }
  void goBack() {
    setState(() {
      if (back && message != "Wygrały czarne!" && message != "Wygrały białe!" && message!="Remis!") {
        game = game.back(prev);
        if (game.currentTurn==PieceColor.w){
          message = "Ruch białych";
        }else if(game.currentTurn==PieceColor.b){
          message = "Ruch czarnych";
        }
        clearBorders();
        back=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Column(
            children: [
              ...List.generate(
                8,
                (y) => Row(
                  children: [
                    ...List.generate(
                      8,
                      (x) => buildBoard(x, y),
                    )
                  ],
                ),
              ).reversed,
            ],
          ),
          const SizedBox(height: 30),
          Text(
            "$message",
            style: const TextStyle(fontSize: 30),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'back',
              onPressed: goBack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_left,
                size: 40,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,

            child: FloatingActionButton(
              heroTag: 'reset',
              onPressed: resetGame,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.refresh,
                size: 40,
              ),
            ),
          ),
        ],
      )
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget? _drawPieces(int x, int y) {
    final piece = game.pieceOfTile(x, y);
    if (piece != null) {
      final child = Container(
        alignment: Alignment.center,
        child: Image.asset(
          piece.fileName,
          height: screenWidth * 0.9,
          width: screenWidth * 0.9,
        ),
      );

      return Draggable<Piece>(
        data: piece,
        feedback: game.currentTurn == piece.pieceColor
            ? child
            : const SizedBox.shrink(),
        childWhenDragging: game.currentTurn == piece.pieceColor
            ? const SizedBox.shrink()
            : child,
        onDragStarted: () => setBorders(piece, pieces),
        onDragCompleted: () => clearBorders(),
        child: child,
      );
    }
    return null;
  }

  void clearBorders() {
    setState(() {
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          isCellSelected[i][j] = false;
        }
      }
    });
  }

  void setBorders(Piece piece, List<Piece> pieces) {
    setState(() {
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          isCellSelected[i][j] = false;
        }
      }
      if (game.currentTurn == piece.pieceColor) {
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            bool canMoveTo = piece.canMoveTo(i, j, pieces);
            if (canMoveTo) {
              isCellSelected[i][j] = true;
            }
          }
        }
      }
    });
  }

  Widget buildBoard(int x, int y) {
    return DragTarget<Piece>(
      onAccept: (piece) {
        final capturedPiece = game.pieceOfTile(x, y);
        PieceColor prevTurn = game.currentTurn;//
        prev=[];
        switch (game.currentTurn) {
          case PieceColor.b:
            {
              game.currentTurn = PieceColor.w;
              setState(() {
                message = "Ruch białych";
              });
            }
            break;
          case PieceColor.w:
            {
              game.currentTurn = PieceColor.b;
              setState(() {
                message = "Ruch czarnych";
              });
            }
            break;
        }
        setState(() {
          int oldY = piece.position.y;
          int oldX = piece.position.x;
          for (var el in pieces) {
            Piece oldPiece;
            if (el is Bishop){
              oldPiece=(Bishop(el.pieceColor,Position(el.x,el.y)));
            }else if(el is King){
              oldPiece=(King(el.pieceColor,Position(el.x,el.y)));
            }else if(el is Knight){
              oldPiece=(Knight(el.pieceColor,Position(el.x,el.y)));
            }
            else if(el is Pawn){
              oldPiece=(Pawn(el.pieceColor,Position(el.x,el.y)));
            }else if(el is Queen){
              oldPiece=(Queen(el.pieceColor,Position(el.x,el.y)));
            }else {
              oldPiece=(Rook(el.pieceColor,Position(el.x,el.y)));
            }
            oldPiece.wasMoved=el.wasMoved;
            oldPiece.isEnpassant=el.isEnpassant;
            back=true;
            prev.add(oldPiece);
            el.isEnpassant = false;
          }
          _specialMoves(piece, y, x, oldY, oldX);
          piece.position = Position(x, y);

          if (capturedPiece != null) {
            pieces.remove(capturedPiece);
          }
          bool blackWin = true;
          bool whiteWin = true;
          bool draw = false;
          if (game.currentTurn == PieceColor.w) {
            for (var p in pieces) {
              if (p.pieceColor == PieceColor.w) {
                var all = p.allMoves(pieces);
                if (all.isNotEmpty) {
                  blackWin = false;
                }
              }
            }
            Piece king = pieces
                .firstWhere((p) => p is King && p.pieceColor == PieceColor.w);
            if (blackWin && !Piece.isKingInCheck(king, pieces)) {
              draw = true;
            }
            if (draw) {
              message = "Remis!";
            } else if (blackWin) {
              message = "Wygrały czarne!";
            }
          } else if (game.currentTurn == PieceColor.b) {
            for (var p in pieces) {
              if (p.pieceColor == PieceColor.b) {
                var all = p.allMoves(pieces);
                if (all.isNotEmpty) {
                  whiteWin = false;
                }
              }
            }
            Piece king = pieces
                .firstWhere((p) => p is King && p.pieceColor == PieceColor.b);
            if (whiteWin && !Piece.isKingInCheck(king, pieces)) {
              draw = true;
            }
            if (draw) {
              message = "Remis!";
            } else if (whiteWin) {
              message = "Wygrały białe!";
            }
          }
        });
      },
      onWillAccept: (piece) {
        if (piece == null) {
          return false;
        }

        final canMoveTo = piece.canMoveTo(x, y, pieces);

        return ((canMoveTo) && (game.currentTurn == piece.pieceColor));
      },
      builder: (context, data, rejects) => Container(
        decoration: BoxDecoration(
          color: _setColor(x, y),
          border: Border.all(
            color: isCellSelected[x][y] ? blue : col,
            width: 5,
          ),
        ),
        width: screenWidth,
        height: screenWidth,
        child: _drawPieces(x, y),
      ),
    );
  }

  void _specialMoves(Piece piece, int y, int x, int oldY, int oldX) {
    if (piece is Pawn) {
      if (piece.pieceColor == PieceColor.w && y == 7) {
        game.pieces.remove(piece);
        pieces.add(Queen(PieceColor.w, Position(x, y)));
      } else if (piece.pieceColor == PieceColor.b && y == 0) {
        game.pieces.remove(piece);
        pieces.add(Queen(PieceColor.b, Position(x, y)));
      }
      if (piece.pieceColor == PieceColor.b && y == 4 && oldY == 6) {
        piece.isEnpassant = true;
      } else if (piece.pieceColor == PieceColor.w && y == 3 && oldY == 1) {
        piece.isEnpassant = true;
      } else if (piece.pieceColor == PieceColor.w) {
        if (oldY == 4 &&
            y == 5 &&
            oldX != x &&
            game.pieceOfTile(x, y) == null) {
          pieces.remove(game.pieceOfTile(x, y - 1));
        }
      } else if (piece.pieceColor == PieceColor.b) {
        if (oldY == 3 &&
            y == 2 &&
            oldX != x &&
            game.pieceOfTile(x, y) == null) {
          pieces.remove(game.pieceOfTile(x, y + 1));
        }
      }
    } else if (piece is King) {
      if (piece.pieceColor == PieceColor.w) {
        if (x == 6 && !piece.wasMoved) {
          pieces.remove(game.pieceOfTile(7, 0));
          pieces.add(Rook(PieceColor.w, Position(5, 0)));
        } else if (x == 2 && !piece.wasMoved) {
          pieces.remove(game.pieceOfTile(0, 0));
          pieces.add(Rook(PieceColor.w, Position(3, 0)));
        }
      } else if (piece.pieceColor == PieceColor.b) {
        if (x == 6 && !piece.wasMoved) {
          pieces.remove(game.pieceOfTile(7, 7));
          pieces.add(Rook(PieceColor.b, Position(5, 7)));
        } else if (x == 2 && !piece.wasMoved) {
          pieces.remove(game.pieceOfTile(0, 7));
          pieces.add(Rook(PieceColor.b, Position(3, 7)));
        }
      }
      piece.wasMoved = true;
    } else if (piece is Rook) {
      piece.wasMoved = true;
    }
  }
}
