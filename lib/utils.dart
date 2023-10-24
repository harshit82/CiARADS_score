bool isNumeric(String number) {
  // checks if string is a number or not
  return double.tryParse(number) != null;
}
