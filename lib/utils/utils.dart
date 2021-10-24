import 'package:intl/intl.dart';

class Utils {
  static String formatMoney(num amount) {
    final oCcy = new NumberFormat("#,##0", "en_US");

    return oCcy.format(amount);
  }
}
