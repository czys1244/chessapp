import 'package:chessapp/pieces/King.dart';
import 'package:chessapp/pieces/Pawn.dart';
import 'package:chessapp/pieces/Piece.dart';
import 'package:chessapp/pieces/Bishop.dart';
import 'package:chessapp/pieces/Knight.dart';
import 'package:chessapp/pieces/Position.dart';
import 'package:chessapp/pieces/Queen.dart';
import 'package:chessapp/pieces/Rook.dart';
import 'package:collection/collection.dart';

class Game {
  final List<Piece> pieces;

  PieceColor currentTurn = PieceColor.w;

  Game(this.pieces);

  // set previousMove(List previousMove) {}

  Piece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);

  factory Game.newGame() {
    return Game(
      [
        Knight(PieceColor.w, Position(1, 0)),
        Knight(PieceColor.w, Position(6, 0)),
        Bishop(PieceColor.w, Position(2, 0)),
        Bishop(PieceColor.w, Position(5, 0)),
        Rook(PieceColor.w, Position(0, 0)),
        Rook(PieceColor.w, Position(7, 0)),
        Queen(PieceColor.w, Position(3, 0)),
        King(PieceColor.w, Position(4, 0)),
        Pawn(PieceColor.w, Position(0, 1)),
        Pawn(PieceColor.w, Position(1, 1)),
        Pawn(PieceColor.w, Position(2, 1)),
        Pawn(PieceColor.w, Position(3, 1)),
        Pawn(PieceColor.w, Position(4, 1)),
        Pawn(PieceColor.w, Position(5, 1)),
        Pawn(PieceColor.w, Position(6, 1)),
        Pawn(PieceColor.w, Position(7, 1)),
        Knight(PieceColor.b, Position(1, 7)),
        Knight(PieceColor.b, Position(6, 7)),
        Bishop(PieceColor.b, Position(2, 7)),
        Bishop(PieceColor.b, Position(5, 7)),
        Rook(PieceColor.b, Position(0, 7)),
        Rook(PieceColor.b, Position(7, 7)),
        Queen(PieceColor.b, Position(3, 7)),
        King(PieceColor.b, Position(4, 7)),
        Pawn(PieceColor.b, Position(0, 6)),
        Pawn(PieceColor.b, Position(1, 6)),
        Pawn(PieceColor.b, Position(2, 6)),
        Pawn(PieceColor.b, Position(3, 6)),
        Pawn(PieceColor.b, Position(4, 6)),
        Pawn(PieceColor.b, Position(5, 6)),
        Pawn(PieceColor.b, Position(6, 6)),
        Pawn(PieceColor.b, Position(7, 6)),
      ],
    );
  }

  Game startNewGame() {
    currentTurn = PieceColor.w;
    return Game(
      [
        Knight(PieceColor.w, Position(1, 0)),
        Knight(PieceColor.w, Position(6, 0)),
        Bishop(PieceColor.w, Position(2, 0)),
        Bishop(PieceColor.w, Position(5, 0)),
        Rook(PieceColor.w, Position(0, 0)),
        Rook(PieceColor.w, Position(7, 0)),
        Queen(PieceColor.w, Position(3, 0)),
        King(PieceColor.w, Position(4, 0)),
        Pawn(PieceColor.w, Position(0, 1)),
        Pawn(PieceColor.w, Position(1, 1)),
        Pawn(PieceColor.w, Position(2, 1)),
        Pawn(PieceColor.w, Position(3, 1)),
        Pawn(PieceColor.w, Position(4, 1)),
        Pawn(PieceColor.w, Position(5, 1)),
        Pawn(PieceColor.w, Position(6, 1)),
        Pawn(PieceColor.w, Position(7, 1)),

        Knight(PieceColor.b, Position(1, 7)),
        Knight(PieceColor.b, Position(6, 7)),
        Bishop(PieceColor.b, Position(2, 7)),
        Bishop(PieceColor.b, Position(5, 7)),
        Rook(PieceColor.b, Position(0, 7)),
        Rook(PieceColor.b, Position(7, 7)),
        Queen(PieceColor.b, Position(3, 7)),
        King(PieceColor.b, Position(4, 7)),
        Pawn(PieceColor.b, Position(0, 6)),
        Pawn(PieceColor.b, Position(1, 6)),
        Pawn(PieceColor.b, Position(2, 6)),
        Pawn(PieceColor.b, Position(3, 6)),
        Pawn(PieceColor.b, Position(4, 6)),
        Pawn(PieceColor.b, Position(5, 6)),
        Pawn(PieceColor.b, Position(6, 6)),
        Pawn(PieceColor.b, Position(7, 6)),
      ],
    );
  }

  Game back(List<Piece> previousMove) {
    Game back = Game(previousMove);
    switch (currentTurn) {
      case PieceColor.b:
        {
          back.currentTurn = PieceColor.w;
        }
        break;
      case PieceColor.w:
        {
          back.currentTurn = PieceColor.b;
        }
        break;
    }
    return back;
  }
}
