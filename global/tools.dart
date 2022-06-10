String convertToTwoDigits(int number) {
  return number < 10 ? '0$number' : '$number';
}
