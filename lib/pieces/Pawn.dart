import 'package:chessapp/pieces/Piece.dart';

import 'Position.dart';

class Pawn extends Piece {
  Pawn(super.pieceColor, super.position);

  @override
  String get name => "pawn";

  @override
  List<Position> moves(List<Piece> others) {
    if (isTransparent) {
      return [];
    }
    return <Position>[
      ..._generateMoves(others),
      ..._generateCaptures(others),
    ].toList();
  }

  @override
  List<Position> movesNotForKing(List<Piece> others) {
    if (isTransparent) {
      return [];
    }
    return <Position>[
      ..._generateCapturesForKing(others),
    ].toList();
  }

  List<Position> _generateMoves(pieces) {
    List<Position> result = [];
    if (pieceColor == PieceColor.w) {
      List<Position> dest = [
        Position(x, y + 1),
        Position(x, y + 2),
      ];
      for (int i = 0; i < 2; i++) {
        Position destination = dest[i];
        bool pieceOnLocation =
            pieces.any((piece) => (piece.position == destination));
        if (dest[i].isValid && !pieceOnLocation && position != destination) {
          if (i == 0) {
            result.add(dest[i]);
          } else {
            if (position.y == 1) {
              result.add(dest[i]);
            }
          }
        }
      }
    } else {
      List<Position> dest = [
        Position(x, y - 1),
        Position(x, y - 2),
      ];
      for (int i = 0; i < 2; i++) {
        Position destination = dest[i];
        bool pieceOnLocation =
            pieces.any((piece) => (piece.position == destination));
        if (dest[i].isValid && !pieceOnLocation && position != destination) {
          if (i == 0) {
            result.add(dest[i]);
          } else {
            if (position.y == 6) {
              result.add(dest[i]);
            }
          }
        }
      }
    }
    return result;
  }

  List<Position> _generateCaptures(pieces) {
    List<Position> result = [];
    if (pieceColor == PieceColor.w) {
      List<Position> dest = [
        Position(x - 1, y + 1),
        Position(x + 1, y + 1),
      ];
      List<Position> enpassant = [
        Position(x - 1, y),
        Position(x + 1, y),
      ];
      for (int i = 0; i < 2; i++) {
        Position destination = dest[i];
        bool pieceOnLocation = pieces.any((piece) =>
            (piece.position == destination) &&
            (piece.pieceColor != pieceColor));
        if (dest[i].isValid && pieceOnLocation && position != destination) {
          result.add(dest[i]);
        }
        Position enp = enpassant[i];
        if (pieces.any(
            (Piece piece) => (piece.position == enp) && piece.isEnpassant)) {
          result.add(dest[i]);
        }
      }
    } else {
      {
        List<Position> dest = [
          Position(x - 1, y - 1),
          Position(x + 1, y - 1),
        ];
        List<Position> enpassant = [
          Position(x - 1, y),
          Position(x + 1, y),
        ];
        for (int i = 0; i < 2; i++) {
          Position destination = dest[i];
          bool pieceOnLocation = pieces.any((piece) =>
              (piece.position == destination) &&
              (piece.pieceColor != pieceColor));
          if (dest[i].isValid && pieceOnLocation && position != destination) {
            result.add(dest[i]);
          }
          Position enp = enpassant[i];
          if (pieces.any(
              (Piece piece) => (piece.position == enp) && piece.isEnpassant)) {
            result.add(dest[i]);
          }
        }
      }
    }
    return result;
  }

  List<Position> _generateCapturesForKing(pieces) {
    List<Position> result = [];
    if (pieceColor == PieceColor.w) {
      List<Position> dest = [
        Position(x - 1, y + 1),
        Position(x + 1, y + 1),
      ];

      for (int i = 0; i < 2; i++) {
        Position destination = dest[i];

        if (dest[i].isValid && position != destination) {
          result.add(dest[i]);
        }
      }
    } else {
      {
        List<Position> dest = [
          Position(x - 1, y - 1),
          Position(x + 1, y - 1),
        ];

        for (int i = 0; i < 2; i++) {
          Position destination = dest[i];
          if (dest[i].isValid && position != destination) {
            result.add(dest[i]);
          }
        }
      }
    }
    return result;
  }
}
