import 'package:chessapp/pieces/Piece.dart';

import 'Position.dart';

class Queen extends Piece {
  Queen(super.pieceColor, super.position);

  @override
  String get name => "queen";

  @override
  List<Position> moves(List<Piece> others) {
    if (isTransparent) {
      return [];
    }
    return <Position>[
      ...generateMovesOnLine(true, true, others),
      ...generateMovesOnLine(false, true, others),
      ...generateMovesOnLine(true, false, others),
      ...generateMovesOnLine(false, false, others),
      ...generateCapturesOnLine(true, true, others),
      ...generateCapturesOnLine(false, true, others),
      ...generateCapturesOnLine(true, false, others),
      ...generateCapturesOnLine(false, false, others),
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
      ...generateMovesOnLine(true, true, others),
      ...generateMovesOnLine(false, true, others),
      ...generateMovesOnLine(true, false, others),
      ...generateMovesOnLine(false, false, others),
      ...generateCapturesOnLineForKing(true, true, others),
      ...generateCapturesOnLineForKing(false, true, others),
      ...generateCapturesOnLineForKing(true, false, others),
      ...generateCapturesOnLineForKing(false, false, others),
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
