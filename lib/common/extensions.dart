import 'package:flutter/material.dart';


extension ConvertTime on int {
  String get toHour {
    int second = this % 60;
    int min = this ~/ 60;
    int hour = min ~/ 60;
    min %= 60;

    return "$hour : $min : $second";
  }
}

extension ConvertColor on Color {
  MaterialColor get toMaterial {
    return MaterialColor(value, {
      50: Color(value),
      100: Color(value),
      200: Color(value),
      300: Color(value),
      400: Color(value),
      500: Color(value),
      600: Color(value),
      700: Color(value),
      800: Color(value),
      900: Color(value),
    });
  }

  WidgetStateProperty<Color> get toMaterialStateProperty {
    return WidgetStateProperty.all(this);
  }
}

extension ObjectCheck on Object? {
  bool get isNotNull {
    return this != null;
  }

  bool get isNull {
    return this == null;
  }
}

extension KeyCheck on GlobalKey {
  Offset get positions {
    if (currentContext.isNotNull) {
      RenderBox box = currentContext!.findRenderObject() as RenderBox;
      Offset position =
          box.localToGlobal(Offset.zero); //this is global position

      return position;
    }

    return const Offset(0, 0);
  }

  Size get size {
    return currentContext.isNotNull ? currentContext!.size! : const Size(0, 0);
  }
}
