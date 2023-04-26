class Position {
  final int x;
  final int y;
  bool isTransparent = false;

  Position(this.x, this.y);

  @override
  bool operator ==(Object other) {
    return other is Position && (x == other.x && y == other.y);
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => "Position($x, $y)";

  bool get isValid => x >= 0 && y >= 0 && x <= 7 && y <= 7;
}
