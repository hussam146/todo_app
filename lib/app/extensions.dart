
extension NonNullInt on int? {
  int get orZeroInt => (this == null) ? this! : 0;
}

extension NonNullString on String? {
  String get orEmptyString => (this == null) ? this! : "";
}

extension NonNullDouble on double? {
  double get orZeroDouble => (this == null) ? this! : 0.0;
}

extension NonNullBool on bool? {
  bool get orBool => (this == null) ? this! : false;
}

extension ParsingInt on int?{
  int get parseInt => int.parse(this as String);
}
