const String title = 'Guatiní';

const String productName = 'Guatiní';

const String version = '1.0.0';

const String developer = 'Damian Aldair';

//const String developerEmail = 'daldairgp@outlook.com';

const String department = 'Facultad de Ingeniería Informática';

const String organization =
    'Universidad Tecnológica de La Habana\n"José Antonio Echeverría"';

const String organizationLite = 'CUJAE';

String copyright = '© ${_copyrightYears(2022)} $organizationLite';

String _copyrightYears(int compilationYear) {
  var currentYear = DateTime.now().year;
  return compilationYear == currentYear
      ? compilationYear.toString()
      : compilationYear.toString() + '-' + currentYear.toString();
}
