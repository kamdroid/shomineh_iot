

import 'package:shomineh/config/constants/Constants.dart';

extension Converter on String {
  int get toInt {
    try {
      return int.parse(this.toEnglishNumber);
    } on Exception catch (_) {
      return 0;
    }
  }

  double get toDouble {
    try {
      return double.parse(this);
    } on Exception catch (_) {
      return 0.0;
    }
  }

  bool get toBoolean {
    return toLowerCase() == "true" || toLowerCase() == "1";
  }

  String get toPersianNumber {
    String output = this;

    for (int i = 0; i < englishNumbers.length; i++) {
      output = output.replaceAll(englishNumbers[i], farsiNumbers[i]);
    }

    return output;
  }

  String get toEnglishNumber {
    String output = this;

    for (int i = 0; i < englishNumbers.length; i++) {
      output = output.replaceAll(farsiNumbers[i], englishNumbers[i]);
    }

    return output;
  }

  String get toPersianLetters {
    return replaceAll("ي", "ی").replaceAll("ك", "ک");
  }

  String get toMoneyFormat {
    return this.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match match) => '${match[1]}/');
  }
}

extension ConverterString on String? {

  bool get isEmptyOrNull {
    return this == null || this?.isEmpty == true;
  }
}