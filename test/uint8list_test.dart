import 'dart:typed_data';

import 'package:convex/convex.dart';
import 'package:test/test.dart';

void main() {
  test('Uint8List', () {
    group('toHex', () {
      test('[0]', () => expect(Uint8List.fromList([0]).toHex(), '0x00'));
      test('[1]', () => expect(Uint8List.fromList([1]).toHex(), '0x01'));
    });
    group('toBigInt', () {
      test(
          '[0]', () => expect(Uint8List.fromList([0]).toBigInt(), BigInt.zero));
      test('[1]', () => expect(Uint8List.fromList([1]).toBigInt(), BigInt.one));
    });
  });
}
