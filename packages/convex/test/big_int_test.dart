import 'dart:typed_data';

import 'package:convex/convex.dart';
import 'package:test/test.dart';

void main() {
  test('BigInt', () {
    group('toHex', () {
      test('0', () => expect(BigInt.zero.toHex(), "0x00"));
      test('1', () => expect(BigInt.one.toHex(), "0x01"));
      test(
        '20000000000 (should always return even padded hex)',
        () => expect(BigInt.from(20000000000).toHex(), '0x04a817c800'),
      );
      test(
        '9223372036854775807',
        () => expect(
          BigInt.from(9223372036854775807).toHex(),
          '0x7fffffffffffffff',
        ),
      );

      test('No 0x', () => expect(BigInt.zero.toHex(with0x: false), "00"));
      test(
        '9223372036854775807',
        () => expect(
          BigInt.from(9223372036854775807).toHex(with0x: false),
          '7fffffffffffffff',
        ),
      );
    });
    group('toBytes', () {
      test('0', () => expect(BigInt.zero.toBytes(), Uint8List.fromList([0])));
      test('1', () => expect(BigInt.one.toBytes(), Uint8List.fromList([1])));

      test(
        '257',
        () => expect(
          BigInt.from(257).toBytes(),
          Uint8List.fromList([1, 1]),
        ),
      );
    });
  });
}
