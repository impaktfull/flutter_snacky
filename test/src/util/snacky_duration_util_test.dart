import 'package:flutter_test/flutter_test.dart';
import 'package:snacky/src/util/duration/snacky_duration_util.dart';

void main() {
  test('Calculate different empty ', () {
    expect(SnackyDurationUtil.calculateDuration('', null),
        const Duration(seconds: 5));
    expect(SnackyDurationUtil.calculateDuration('', ''),
        const Duration(seconds: 5));
    expect(SnackyDurationUtil.calculateDuration('', '1'),
        const Duration(seconds: 6));
    expect(SnackyDurationUtil.calculateDuration('1', '1'),
        const Duration(seconds: 6));
    expect(SnackyDurationUtil.calculateDuration('1', ''),
        const Duration(seconds: 6));
    expect(SnackyDurationUtil.calculateDuration('1', null),
        const Duration(seconds: 6));
  });

  test('Calculate different long snackies (120 chars)', () {
    const longText =
        'This is some text that might increase the duration of the snacky, just because it is long! This should be just perfect!!';
    expect(longText.length, 120);
    expect(SnackyDurationUtil.calculateDuration(longText, ''),
        const Duration(seconds: 6));
    expect(SnackyDurationUtil.calculateDuration('', longText),
        const Duration(seconds: 6));
  });
  test('Calculate different long snackies (121 chars)', () {
    const longText =
        'This is some text that might increase the duration of the snacky, just because it is long! This should be just perfect!!!';
    expect(longText.length, 121);
    expect(SnackyDurationUtil.calculateDuration(longText, ''),
        const Duration(seconds: 7));
    expect(SnackyDurationUtil.calculateDuration('', longText),
        const Duration(seconds: 7));
  });

  test('Calculate different long snackies (exactly max length)', () {
    final longText = List.generate(120 * 30, (i) => '-'.toString()).join('');
    expect(longText.length, 3600);
    expect(SnackyDurationUtil.calculateDuration(longText, ''),
        const Duration(seconds: 30));
    expect(SnackyDurationUtil.calculateDuration('', longText),
        const Duration(seconds: 30));
  });
  test('Calculate different long snackies (more than max length)', () {
    final longText = List.generate(120 * 31, (i) => '-'.toString()).join('');
    expect(longText.length, 3720);
    expect(SnackyDurationUtil.calculateDuration(longText, ''),
        const Duration(seconds: 30));
    expect(SnackyDurationUtil.calculateDuration('', longText),
        const Duration(seconds: 30));
  });
}
