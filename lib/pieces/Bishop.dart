import 'package:chessapp/pieces/Piece.dart';

import 'Position.dart';

class Bishop extends Piece {
  Bishop(super.pieceColor, super.position);

  @override
  String get name => "bishop";

  @override
  List<Position> moves(List<Piece> others) {
    if (isTransparent) {
      return [];
    }
    return <Position>[
      ...generateMovesOnDiagonal(true, true, others),
      ...generateMovesOnDiagonal(false, true, others),
      ...generateMovesOnDiagonal(true, false, others),
      ...generateMovesOnDiagonal(false, false, others),
      ...generateCapturesOnDiagonal(true, true, others),
      ...generateCapturesOnDiagonal(false, true, others),
      ...generateCapturesOnDiagonal(true, false, others),
      ...generateCapturesOnDiagonal(false, false, others),
    ].toList();
  }

  @override
  List<Position> movesNotForKing(List<Piece> others) {
    if (isTransparent) {
      return [];
    }
    return <Position>[
      ...generateMovesOnDiagonal(true, true, others),
      ...generateMovesOnDiagonal(false, true, others),
      ...generateMovesOnDiagonal(true, false, others),
      ...generateMovesOnDiagonal(false, false, others),
      ...generateCapturesOnDiagonalForKing(true, true, others),
      ...generateCapturesOnDiagonalForKing(false, true, others),
      ...generateCapturesOnDiagonalForKing(true, false, others),
      ...generateCapturesOnDiagonalForKing(false, false, others),
    ].toList();
  }
}
