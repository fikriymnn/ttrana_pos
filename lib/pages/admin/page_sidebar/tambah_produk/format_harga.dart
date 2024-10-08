import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Hapus semua karakter non-digit
    String cleaned = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Format angka menjadi string
    if (cleaned.isNotEmpty) {
      // Menggunakan format Rupiah
      String formatted =
          NumberFormat.currency(locale: 'id_ID', symbol: ' ', decimalDigits: 0)
              .format(int.parse(cleaned));

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else {
      return TextEditingValue.empty;
    }
  }
}
