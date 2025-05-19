import 'package:intl/intl.dart';

class CurrencyHelper {
  static final _brFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );

  static String format(double value) {
    return _brFormatter.format(value);
  }
}
