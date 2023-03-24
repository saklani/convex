import 'dart:convert';
import 'dart:typed_data';
import 'big_int.dart';

extension StringExtension on String {
  /// Is the `String` a valid address
  bool isAddress() {
    final regex = RegExp(r'/^0x[a-fA-F0-9]{40}$/');
    return regex.hasMatch(this);
  }

  /// Is the `String` a valid binary
  bool isBinary() {
    for (int i = 0; i < length; i++) {
      if (this[i] != '0' && this[i] != '1') return false;
    }
    return true;
  }

  /// Is the `String` a valid hexadecimal
  bool isHex() => RegExp(r'^0x[a-fA-F0-9]+$').hasMatch(this);

  /// Remove '0x' from a hexadecimal `String`
  String strip0x() => startsWith('0x') ? substring(2, length) : this;

  /// Converts the hexadecimal `String` to a `BigInt`
  BigInt toBigInt() {
    if (this == '0x') {
      return BigInt.zero;
    } else if (!isHex()) {
      throw Exception("not a valid hex");
    } else {
      return BigInt.parse("0x${strip0x()}");
    }
  }

  /// Converts the hexadecimal `String` to a hexadecimal bytes array
  /// Converts the non-hexadecimal `String` to a utf8 hexadecimal bytes array
  Uint8List toBytes() {
    if (this == '0x') {
      return BigInt.zero.toBytes();
    } else if (!isHex()) {
      return Uint8List.fromList(utf8.encode(this));
    } else {
      return Uint8List.fromList(toBigInt().toBytes());
    }
  }

  /// Converts the UTF8 `String` to hexadecimal `String`.
  String toHex({int? size}) {
    String result = "";
    for (var i = 0; i < length; i++) {
      int code = codeUnitAt(i);
      String n = code.toRadixString(16);
      result += n.length < 2 ? '0$n' : n;
    }
    return "0x${padLeft(size ?? 0, '0')}$result";
  }

  /// Converts the hexadecimal `String` to an `int`.
  int toInt() => toBigInt().toInt();

  /// Converts the hexadecimal `String` to a UTF8 `String`.
  String toUTF8() {
    List<int> result = [];
    String temp = strip0x();
    for (int i = 0; i <= length - 3; i += 2) {
      int code = "0x${temp.substring(i, i + 2)}".toInt();
      result.add(code);
    }
    return utf8.decode(result);
  }
}
