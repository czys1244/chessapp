import 'package:chessapp/pieces/Piece.dart';

import 'Position.dart';

class Knight extends Piece {
  Knight(super.pieceColor, super.position);

  @override
  String get name => "knight";

  @override
  List<Position> moves(List<Piece> others) {
    if (isTransparent) {
      return [];
    }
    return <Position>[
      ..._generateMovesUp(others),
      ..._generateMovesRight(others),
      ..._generateMovesDown(others),
      ..._generateMovesLeft(others),
    ].toList();
  }

  @override
  List<Position> movesNotForKing(List<Piece> others) {
    if (isTransparent) {
      return [];
    }
    return <Position>[
      ..._generateMovesUpForKing(others),
      ..._generateMovesRightForKing(others),
      ..._generateMovesDownForKing(others),
      ..._generateMovesLeftForKing(others),
    ].toList();
  }

  List<Position> _generateMovesUp(List<Piece> pieces) {
    List<Position> result = [];
    int up = y + 2;
    Position destination1 = Position(x - 1, up);
    Position destination2 = Position(x + 1, up);
    final pieceOnLocation1 = pieces.any((piece) =>
        (piece.position == destination1) && (piece.pieceColor == pieceColor));
    final pieceOnLocation2 = pieces.any((piece) =>
        (piece.position == destination2) && (piece.pieceColor == pieceColor));
    if (destination1.isValid && !pieceOnLocation1 && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && !pieceOnLocation2 && position != destination2) {
      result.add(destination2);
    }

    return result;
  }

  List<Position> _generateMovesRight(List<Piece> pieces) {
    List<Position> result = [];
    int right = x + 2;
    Position destination1 = Position(right, y - 1);
    Position destination2 = Position(right, y + 1);
    final pieceOnLocation1 = pieces.any((piece) =>
        (piece.position == destination1) && (piece.pieceColor == pieceColor));
    final pieceOnLocation2 = pieces.any((piece) =>
        (piece.position == destination2) && (piece.pieceColor == pieceColor));
    if (destination1.isValid && !pieceOnLocation1 && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && !pieceOnLocation2 && position != destination2) {
      result.add(destination2);
    }

    return result;
  }

  List<Position> _generateMovesDown(pieces) {
    List<Position> result = [];
    int down = y - 2;
    Position destination1 = Position(x - 1, down);
    Position destination2 = Position(x + 1, down);
    final pieceOnLocation1 = pieces.any((piece) =>
        (piece.position == destination1) && (piece.pieceColor == pieceColor));
    final pieceOnLocation2 = pieces.any((piece) =>
        (piece.position == destination2) && (piece.pieceColor == pieceColor));
    if (destination1.isValid && !pieceOnLocation1 && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && !pieceOnLocation2 && position != destination2) {
      result.add(destination2);
    }

    return result;
  }

  List<Position> _generateMovesLeft(pieces) {
    List<Position> result = [];
    int left = x - 2;
    Position destination1 = Position(left, y - 1);
    Position destination2 = Position(left, y + 1);
    final pieceOnLocation1 = pieces.any((piece) =>
        (piece.position == destination1) && (piece.pieceColor == pieceColor));
    final pieceOnLocation2 = pieces.any((piece) =>
        (piece.position == destination2) && (piece.pieceColor == pieceColor));
    if (destination1.isValid && !pieceOnLocation1 && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && !pieceOnLocation2 && position != destination2) {
      result.add(destination2);
    }

    return result;
  }

  List<Position> _generateMovesUpForKing(List<Piece> pieces) {
    List<Position> result = [];
    int up = y + 2;
    Position destination1 = Position(x - 1, up);
    Position destination2 = Position(x + 1, up);
    if (destination1.isValid && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && position != destination2) {
      result.add(destination2);
    }

    return result;
  }

  List<Position> _generateMovesRightForKing(List<Piece> pieces) {
    List<Position> result = [];
    int right = x + 2;
    Position destination1 = Position(right, y - 1);
    Position destination2 = Position(right, y + 1);

    if (destination1.isValid && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && position != destination2) {
      result.add(destination2);
    }

    return result;
  }

  List<Position> _generateMovesDownForKing(pieces) {
    List<Position> result = [];
    int down = y - 2;
    Position destination1 = Position(x - 1, down);
    Position destination2 = Position(x + 1, down);
    if (destination1.isValid && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && position != destination2) {
      result.add(destination2);
    }

    return result;
  }

  List<Position> _generateMovesLeftForKing(pieces) {
    List<Position> result = [];
    int left = x - 2;
    Position destination1 = Position(left, y - 1);
    Position destination2 = Position(left, y + 1);
    if (destination1.isValid && position != destination1) {
      result.add(destination1);
    }
    if (destination2.isValid && position != destination2) {
      result.add(destination2);
    }

    return result;
  }
}
