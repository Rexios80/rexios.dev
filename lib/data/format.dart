String formatLargeNum(num number) {
  var temp = number.abs().toDouble();
  if (temp < 1000) return number.toInt().toString();

  const suffixes = ['K', 'M', 'B', 'T'];
  var suffixIndex = -1;

  while (temp >= 1000 && suffixIndex < suffixes.length - 1) {
    temp /= 1000;
    suffixIndex++;
  }

  final integerDigits = temp.floor().toString().length;
  var decimalDigits = 3 - integerDigits;
  if (decimalDigits < 0) decimalDigits = 0;

  var formatted = temp.toStringAsFixed(decimalDigits);
  if (formatted.contains('.')) {
    formatted = formatted.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  final sign = number < 0 ? '-' : '';
  final suffix = suffixes[suffixIndex];
  return '$sign$formatted$suffix';
}
