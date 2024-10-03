class SnackyDurationUtil {
  static const maxDuration = Duration(seconds: 30);
  static const baseDuration = Duration(seconds: 5);
  static const maxCharLength = 120;
  const SnackyDurationUtil();

  /// The minimum duration is 6 seconds
  /// Calculation: 5 seconds + 1 second for every 120 words (rounded up)
  static Duration calculateDuration(String title, String? subtitle) {
    final fullText = (title + (subtitle == null || subtitle.isEmpty ? '' : ' $subtitle')).trim();
    if (fullText.isEmpty) return baseDuration;
    final fullTextLength = fullText.length;
    final extraSeconds = (fullTextLength / maxCharLength).ceil();
    final fullDuration = baseDuration + Duration(seconds: extraSeconds);
    if (fullDuration < maxDuration) {
      return fullDuration;
    }
    return maxDuration;
  }
}
