import 'dart:ui';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    if (hexString == null || hexString.isEmpty) throw Exception('The input into this function cannot be null or empty');
    if (hexString.length == 6 || hexString.length == 7) {
      if (hexString.length == 7 && hexString.substring(0, 1) != '#') _error();
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      try {
        return Color(int.parse(buffer.toString(), radix: 16));
      } catch(_) {_error();}
    } else _error();
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
    '${alpha.toRadixString(16)}'
    '${red.toRadixString(16)}'
    '${green.toRadixString(16)}'
    '${blue.toRadixString(16)}';
}

_error() {
  throw Exception('Not a valid hex string');
}