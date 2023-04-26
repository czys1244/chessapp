import 'package:chessapp/pieces/Bishop.dart';
import 'package:chessapp/pieces/King.dart';
import 'package:chessapp/pieces/Knight.dart';
import 'package:chessapp/pieces/Pawn.dart';
import 'package:chessapp/pieces/Queen.dart';
import 'package:collection/collection.dart';
import 'Position.dart';
import 'Rook.dart';

enum PieceColor { w, b }

abstract class Piece {
  final PieceColor pieceColor;
  Position position;
  bool wasMoved = false;
  bool isEnpassant = false;

  String get name;

  bool isTransparent = false;

  int get x => position.x;

  int get y => position.y;

  String get fileName =>
      "assets/${pieceColor.toString().split(".").last}$name.png";

  Piece(
    this.pieceColor,
    this.position,
  );

  List<Position> moves(List<Piece> others);

  List<Position> movesNotForKing(List<Piece> others);

  List<Position> allMoves(List<Piece> others) {
    List<Position> result = [];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (canMoveTo(i, j, others)) {
          result.add(Position(i, j));
        }
      }
    }
    return result;
  }

  bool canMoveTo(int x, int y, List<Piece> others) =>
      moves(others).contains(Position(x, y)) && !isKingAttacked(x, y, others);

  @override
  String toString() => "$name($x, $y)";

  bool isKingAttacked(int x, int y, List<Piece> pieces) {
    Piece king =
        pieces.firstWhere((p) => p is King && p.pieceColor == pieceColor);
    king.isTransparent = true;
    List<Position> underAttack = positionsUnderAttack(pieces);
    if (this is King) {
      king.isTransparent = false;
      if (underAttack.contains(Position(x, y))) {
        return true;
      } else {
        if (!king.wasMoved) {
          if (x == 6 &&
              (underAttack.contains(Position(x - 1, y)) ||
                  underAttack.contains(Position(this.x, y)))) {
            return true;
          } else if (x == 2 &&
              (underAttack.contains(Position(x + 1, y)) ||
                  underAttack.contains(Position(this.x, y)))) {
            return true;
          }
        }
      }
    } else {
      Piece test;
      if (this is Bishop) {
        test = Bishop(pieceColor, Position(x, y));
      } else if (this is Knight) {
        test = Knight(pieceColor, Position(x, y));
      } else if (this is Pawn) {
        test = Pawn(pieceColor, Position(x, y));
      } else if (this is Queen) {
        test = Queen(pieceColor, Position(x, y));
      } else {
        test = Rook(pieceColor, Position(x, y));
      }
      isTransparent = true;
      Piece? PieceOnLocation =
          pieces.firstWhereOrNull((p) => p.x == x && p.y == y);
      if (PieceOnLocation != null) {
        PieceOnLocation.isTransparent = true;
      }
      pieces.add(test);
      underAttack = positionsUnderAttack(pieces);
      king.isTransparent = false;
      if (PieceOnLocation != null) {
        PieceOnLocation.isTransparent = false;
      }
      if (underAttack.contains(king.position)) {
        pieces.remove(test);
        isTransparent = false;
        return true;
      } else {
        pieces.remove(test);
        isTransparent = false;
      }
    }

    return false;
  }

  static bool isKingInCheck(Piece king, List<Piece> pieces) {
    List<Position> underAttack = king.positionsUnderAttack(pieces);
    if (underAttack.contains(Position(king.x, king.y))) {
      return true;
    }
    return false;
  }

  List<Position> positionsUnderAttack(List<Piece> pieces) {
    List<Position> result = [];
    for (var el in pieces) {
      if (el.pieceColor != pieceColor) {
        result.addAll(el.movesNotForKing(pieces));
      }
    }
    return result;
  }

  List<Position> generateMovesOnDiagonal(
    bool isUp,
    bool isRight,
    List<Piece> pieces,
  ) {
    bool obstructed = false;

    return List<Position?>.generate(8, (i) {
      if (obstructed) return null;

      int dx = (isRight ? 1 : -1) * i;
      int dy = (isUp ? 1 : -1) * i;

      final destination = Position(x + dx, y + dy);

      final pieceOnLocation = pieces.any((Piece piece) =>
          (piece.position == destination) && (!piece.isTransparent));

      if (pieceOnLocation && position != destination) {
        obstructed = true;
        return null;
      }
      if (position == destination && pieceOnLocation) {
        return null;
      }
      return destination;
    }).whereType<Position>().where((position) => position.isValid).toList();
  }

  List<Position> generateCapturesOnDiagonal(
    bool isUp,
    bool isRight,
    List<Piece> pieces,
  ) {
    bool hasFoundCapture = false;
    bool obstructed = false;
    return List<Position?>.generate(8, (i) {
      if (hasFoundCapture || obstructed) return null;

      int dx = (isRight ? 1 : -1) * (i);
      int dy = (isUp ? 1 : -1) * (i);

      final destination = Position(x + dx, y + dy);
      final pieceOnLoc = pieces.any((piece) =>
          (piece.position == destination) &&
          (piece.pieceColor != pieceColor) &&
          (!piece.isTransparent));
      if (pieceOnLoc && position != destination) {
        hasFoundCapture = true;
        return destination;
      }
      final pieceOnLocation = pieces.any(
          (piece) => (piece.position == destination) && (!piece.isTransparent));

      if (pieceOnLocation && position != destination) {
        obstructed = true;
        return null;
      }
    }).whereType<Position>().where((position) => position.isValid).toList();
  }

  List<Position> generateMovesOnLine(
      bool isHor, bool isInc, List<Piece> pieces) {
    bool obstructed = false;

    return List<Position?>.generate(8, (i) {
      if (obstructed) return null;

      int dx = 0;
      int dy = 0;
      if (isHor) {
        if (isInc) {
          dx = i;
        } else {
          dx = -i;
        }
      } else {
        if (isInc) {
          dy = i;
        } else {
          dy = -i;
        }
      }

      final destination = Position(x + dx, y + dy);

      final pieceOnLocation = pieces.any(
          (piece) => (piece.position == destination) && (!piece.isTransparent));

      if (pieceOnLocation && position != destination) {
        obstructed = true;
        return null;
      }
      if (position == destination && pieceOnLocation) {
        return null;
      }
      return destination;
    }).whereType<Position>().where((position) => position.isValid).toList();
  }

  List<Position> generateCapturesOnLine(
      bool isHor, bool isInc, List<Piece> pieces) {
    bool hasFoundCapture = false;
    bool obstructed = false;
    return List<Position?>.generate(8, (i) {
      if (hasFoundCapture || obstructed) return null;

      int dx = 0;
      int dy = 0;
      if (isHor) {
        if (isInc) {
          dx = i;
        } else {
          dx = -i;
        }
      } else {
        if (isInc) {
          dy = i;
        } else {
          dy = -i;
        }
      }

      final destination = Position(x + dx, y + dy);
      final pieceOnLoc = pieces.any((piece) =>
          (piece.position == destination) &&
          (piece.pieceColor != pieceColor) &&
          (!piece.isTransparent));
      if (pieceOnLoc && position != destination) {
        hasFoundCapture = true;
        return destination;
      }
      final pieceOnLocation = pieces.any((piece) =>
          (piece.position == destination) &&
          (!piece.isTransparent)); //&& (piece.pieceColor != pieceColor)
      if (pieceOnLocation && position != destination) {
        obstructed = true;
        return null;
      }
    }).whereType<Position>().where((position) => position.isValid).toList();
  }

  List<Position> generateCapturesOnLineForKing(
      bool isHor, bool isInc, List<Piece> pieces) {
    bool hasFoundCapture = false;
    bool obstructed = false;
    return List<Position?>.generate(8, (i) {
      if (hasFoundCapture || obstructed) return null;

      int dx = 0;
      int dy = 0;
      if (isHor) {
        if (isInc) {
          dx = i;
        } else {
          dx = -i;
        }
      } else {
        if (isInc) {
          dy = i;
        } else {
          dy = -i;
        }
      }

      final destination = Position(x + dx, y + dy);
      final pieceOnLoc = pieces.any(
          (piece) => (piece.position == destination) && (!piece.isTransparent));
      if (pieceOnLoc && position != destination) {
        hasFoundCapture = true;
        return destination;
      }
      final pieceOnLocation = pieces.any((piece) =>
          (piece.position == destination) &&
          (!piece.isTransparent)); //&& (piece.pieceColor != pieceColor)
      if (pieceOnLocation && position != destination) {
        obstructed = true;
        return null;
      }
    }).whereType<Position>().where((position) => position.isValid).toList();
  }

  List<Position> generateCapturesOnDiagonalForKing(
    bool isUp,
    bool isRight,
    List<Piece> pieces,
  ) {
    bool hasFoundCapture = false;
    bool obstructed = false;
    return List<Position?>.generate(8, (i) {
      if (hasFoundCapture || obstructed) return null;

      int dx = (isRight ? 1 : -1) * (i);
      int dy = (isUp ? 1 : -1) * (i);

      final destination = Position(x + dx, y + dy);
      final pieceOnLoc = pieces.any(
          (piece) => (piece.position == destination) && (!piece.isTransparent));
      if (pieceOnLoc && position != destination) {
        hasFoundCapture = true;
        return destination;
      }
      final pieceOnLocation = pieces.any(
          (piece) => (piece.position == destination) && (!piece.isTransparent));

      if (pieceOnLocation && position != destination) {
        obstructed = true;
        return null;
      }
    }).whereType<Position>().where((position) => position.isValid).toList();
  }
}
