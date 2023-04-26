import 'package:chessapp/pieces/Piece.dart';

import 'Position.dart';

class Rook extends Piece {
  Rook(super.pieceColor, super.position);

  @override
  String get name => "rook";

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
    ].toList();
  }
}
