import 'dart:typed_data';

import 'package:convex/convex.dart';
import 'package:test/test.dart';

void main() {
  test('isHex', () {
    List<Map<String, dynamic>> tests = [
      {'value': '0x1', 'expected': true},
      {'value': '1', 'expected': false},
      {'value': '0xH', 'expected': false},
      {'value': 'H', 'expected': false},
      {'value': '{"test": "test"}', 'expected': false},
      {'value': 'myString', 'expected': false},
      {'value': 'myString 34534!', 'expected': false},
      {'value': 'Heeäööä👅D34ɝɣ24Єͽ-.,äü+#/', 'expected': false},
    ];
    for (int i = 0; i < tests.length; i++) {
      expect(
        tests[i]['value'].toString().isHex(),
        tests[i]['expected'],
      );
    }
  });

  test('toUTF8', () {
    final tests = [
      {
        'value':
            '0x486565c3a4c3b6c3b6c3a4f09f9185443334c99dc9a33234d084cdbd2d2e2cc3a4c3bc2b232f',
        'expected': 'Heeäööä👅D34ɝɣ24Єͽ-.,äü+#/'
      },
      {'value': '0x6d79537472696e67', 'expected': 'myString'},
      {'value': '0x6d79537472696e6700', 'expected': 'myString\x00'},
      {
        'value':
            '0x65787065637465642076616c7565000000000000000000000000000000000000',
        'expected':
            'expected value\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
      },
      {
        'value':
            '0x000000000000000000000000000000000000657870656374000065642076616c7565',
        'expected':
            '\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00expect\x00\x00ed value'
      }
    ];
    for (int i = 0; i < tests.length; i++) {
      expect(
        tests[i]['value'].toString().toUTF8(),
        tests[i]['expected'],
      );
    }
  });

  test('toBytes', () {
    final tests = [
      {
        'value': 'Heeäööä👅D34ɝɣ24Єͽ-.,äü+#/',
        'expected':
            '0x486565c3a4c3b6c3b6c3a4f09f9185443334c99dc9a33234d084cdbd2d2e2cc3a4c3bc2b232f'
      },
      {'value': 'myString', 'expected': '0x6d79537472696e67'},
      {
        'value': '我能吞下玻璃而不伤身体。',
        'expected':
            '0xe68891e883bde5909ee4b88be78ebbe79283e8808ce4b88de4bca4e8baabe4bd93e38082'
      },
      {
        'value': '나는 유리를 먹을 수 있어요. 그래도 아프지 않아요',
        'expected':
            '0xeb8298eb8a9420ec9ca0eba6aceba5bc20eba8b9ec9d8420ec889820ec9e88ec96b4ec9a942e20eab7b8eb9e98eb8f8420ec9584ed9484eca78020ec958aec9584ec9a94'
      },
    ];
    for (int i = 0; i < tests.length; i++) {
      expect(
        Uint8List.fromList(tests[i]['value']!.toBytes()).toHex(),
        tests[i]['expected'],
      );
    }
  });
}
