import 'package:chessapp/pieces/Piece.dart';

import 'Position.dart';
import 'Rook.dart';

class King extends Piece {
  King(super.pieceColor, super.position);

  @override
  String get name => "king";

  @override
  List<Position> moves(List<Piece> others) {
    return <Position>[
      ..._generateMoves(others),
    ].toList();
  }

  @override
  List<Position> movesNotForKing(List<Piece> others) {
    return <Position>[
      ..._generateMoves(others),
    ].toList();
  }

  List<Position> _generateMoves(List<Piece> pieces) {
    List<Position> result = [];
    List<Position> dest = [
      Position(x, y + 1),
      Position(x + 1, y + 1),
      Position(x + 1, y),
      Position(x + 1, y - 1),
      Position(x, y - 1),
      Position(x - 1, y - 1),
      Position(x - 1, y),
      Position(x - 1, y + 1),
    ];
    for (int i = 0; i < 8; i++) {
      Position destination = dest[i];
      bool pieceOnLocation = pieces.any((piece) =>
          (piece.position == destination) && (piece.pieceColor == pieceColor));
      if (dest[i].isValid && !pieceOnLocation && position != destination) {
        result.add(dest[i]);
      }
    }

    if (pieceColor == PieceColor.w && !wasMoved) {
      bool checkWhiteShortCastleRook = pieces.any((piece) =>
          (piece.position == Position(7, 0)) &&
          (piece is Rook && piece.wasMoved == false));
      bool checkWhiteLongCastleRook = pieces.any((piece) =>
          (piece.position == Position(0, 0)) &&
          (piece is Rook && piece.wasMoved == false));
      if (checkWhiteShortCastleRook &&
          !pieces.any((piece) => (piece.position == Position(6, 0))) &&
          !pieces.any((piece) => (piece.position == Position(5, 0)))) {
        Position shortCastle = Position(6, 0);
        result.add(shortCastle);
      }
      if (checkWhiteLongCastleRook &&
          !pieces.any((piece) => (piece.position == Position(3, 0))) &&
          !pieces.any((piece) => (piece.position == Position(2, 0))) &&
          !pieces.any((piece) => (piece.position == Position(1, 0)))) {
        Position longCastle = Position(2, 0);
        result.add(longCastle);
      }
    } else if (pieceColor == PieceColor.b && !wasMoved) {
      bool checkBlackShortCastleRook = pieces.any((piece) =>
          (piece.position == Position(7, 7)) &&
          (piece is Rook && piece.wasMoved == false));
      bool checkBlackLongCastleRook = pieces.any((piece) =>
          (piece.position == Position(0, 7)) &&
          (piece is Rook && piece.wasMoved == false));
      if (checkBlackShortCastleRook &&
          !pieces.any((piece) => (piece.position == Position(6, 7))) &&
          !pieces.any((piece) => (piece.position == Position(5, 7)))) {
        Position shortCastle = Position(6, 7);
        result.add(shortCastle);
      }
      if (checkBlackLongCastleRook &&
          !pieces.any((piece) => (piece.position == Position(3, 7))) &&
          !pieces.any((piece) => (piece.position == Position(2, 7))) &&
          !pieces.any((piece) => (piece.position == Position(1, 7)))) {
        Position longCastle = Position(2, 7);
        result.add(longCastle);
      }
    }
    return result;
  }
}
