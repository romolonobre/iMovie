import 'dart:developer';

import 'package:flutter/foundation.dart';

// ignore: avoid_classes_with_only_static_members
class Helper {
  /// Converts and asserts the [value] as if it was a boolean
  static bool getBool(dynamic value) {
    bool returnValue = false;

    /// check for null values
    if (value == null) {
      return false;
    }

    /// check for [bool] types
    if (value is bool) {
      return value;
    }

    return returnValue;
  }

  /// Converts [value] to a double, returns 0.0 on failure or unconverteble value.
  static double getDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    if (value is double) {
      return value;
    }

    /// check for [int] types
    if (value is int) {
      return value.toDouble();
    }

    /// check for [String] types
    if (value is String) {
      if (value.isNotEmpty) {
        try {
          return double.parse(value);
        } catch (error) {
          // do nothing, this value is not parse-able.
        }
      }
    }

    return 0.0;
  }

  /// Converts [value] to a double, returns 0.0 on failure or unconverteble value.
  static double? getDoubleOrNull(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is double) {
      return value;
    }

    /// check for [int] types
    if (value is int) {
      return value.toDouble();
    }

    /// check for [String] types
    if (value is String) {
      if (value.isNotEmpty) {
        try {
          return double.parse(value);
        } catch (error) {
          // do nothing, this value is not parse-able.
        }
      }
    }

    return null;
  }

  /// Converts [value] to an int, returns 0 on failure or unconverteble value.
  static int getInt(dynamic value) {
    if (value == null) {
      return 0;
    }

    if (value is int) {
      return value;
    }

    /// check for [double] types
    if (value is double) {
      return value.toInt();
    }

    /// check for [String] types
    if (value is String) {
      if (value.isNotEmpty) {
        try {
          return int.parse(value);
        } catch (error) {
          // re assume this means the value is actually a double, as a string.
          return getInt(double.parse(value));
        }
      }
    }

    return 0;
  }

  /// Converts [value] to an int, returns 0 on failure or unconverteble value.
  static int? getIntOrNull(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.toInt();
    }

    /// check for [String] types
    if (value is String) {
      if (value.isNotEmpty) {
        try {
          return int.parse(value);
        } catch (error) {
          // re assume this means the value is actually a double, as a string.
          return getIntOrNull(double.parse(value));
        }
      }
    }

    return null;
  }

  /// Parses the [value] as a string. If the value is a Map or List, it will
  /// use the first index, returns '' on failure or error.
  static String getString(dynamic value) {
    if (value == null) {
      return '';
    }

    if (value is String) {
      return value;
    }

    /// check for [int] and [double] types
    if (value is int || value is double) {
      return value.toString();
    }

    /// check for [Map] type
    if (value is Map || value is List) {
      if (value.length == 0) {
        return '';
      }

      return Helper.getString(value[0]);
    }

    return '';
  }

  /// Parses the [value] as a string. If the value is a Map or List, it will
  /// use the first index, returns '' on failure or error.
  static String? getStringOrNull(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is String) {
      return value;
    }

    /// check for [int] and [double] types
    if (value is int || value is double) {
      return value.toString();
    }

    /// check for [Map] type
    if (value is Map || value is List) {
      if (value.length == 0) {
        return '';
      }

      return Helper.getStringOrNull(value[0]);
    }

    return null;
  }

  /// Parses the [value] as a list of string values. If [lowerCase] is true,
  /// the values with be lower cased.
  static List<String> getStringList(dynamic value, {bool lowerCase = false}) {
    if (value == null) {
      return <String>[];
    }

    /// check for [Map] type
    if (value is Map || value is List) {
      if (value.length == 0) {
        return <String>[];
      }

      final List<dynamic> listValue = value as List<dynamic>;

      final List<String> items = [];
      for (final dynamic str in listValue) {
        String newStr = Helper.getString(str);

        if (lowerCase == true) {
          newStr = newStr.toLowerCase();
        }

        items.add(newStr);
      }

      return items;
    }

    /// check for [String] types
    if (value is String) {
      String str = Helper.getString(value);

      if (lowerCase == true) {
        str = value.toLowerCase();
      }

      return <String>[str];
    }

    /// check for [int] and [double] types
    if (value is int || value is double) {
      return <String>[value.toString()];
    }

    return <String>[];
  }

  // Make sure we return a map if the input is a list
  static Map<String, dynamic> getMap(dynamic value) {
    if (value is! Map) {
      return {};
    }

    return value as Map<String, dynamic>;
  }
}

void debugLog(dynamic data, [String? title]) {
  if (kReleaseMode) return;
  log(' ================================================== DEBUGGING: $title ================================================== ');
  log(' ');
  log(data.toString());
  log(' ');
  log(' ======================================================================================================================= ');
}
