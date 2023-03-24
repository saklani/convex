import 'dart:convert';
import 'dart:typed_data';

import 'big_int.dart';

extension Uint8ListExtension on Uint8List {

  /// Converts the `Uint8List` bytes array to a BigInt
  BigInt toBigInt({int sign = 1}) {
    if (sign == 0) {
      return BigInt.zero;
    }

    BigInt result;
    if (length == 1) {
      result = BigInt.from(this[0]);
    } else {
      result = BigInt.from(0);
      for (var i = 0; i < length; i++) {
        var item = this[length - i - 1];
        result |= (BigInt.from(item) << (8 * i));
      }
    }
    if (result != BigInt.zero) {
      if (sign < 0) {
        result = result.toSigned(result.bitLength);
      } else {
        result = result.toUnsigned(result.bitLength);
      }
    }
    return result;
  }

  /// Converts the `Uint8List` bytes array to a binary `String`.
  String toBinary() =>
      map((byte) => byte.toRadixString(2).padLeft(8, '0')).join('');

  /// Converts the `Uint8List` bytes array to a hexadecimal `String`.
  String toHex({bool with0x = true, int? size}) =>
      toBigInt().toHex(with0x: with0x, size: size);


  /// Converts the `Uint8List` bytes array to a UTF8 encoded `String`.
  String toUTF8({bool with0x = true}) => utf8.decode(this);
}
