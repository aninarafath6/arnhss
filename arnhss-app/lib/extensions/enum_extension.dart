// extension EnumExtension<T> on Enum {
//   T toEnum(String str) {

//     switch (str) {
//       case "male":
//         return ;
//       case "female":
//         return Gender.female;
//       default:
//         return Gender.other;
//     }
//   }
// }
import 'package:arnhss/extensions/string_extension.dart';
import 'package:flutter/foundation.dart';

extension EnumExtension on Enum {
  String get describe {
    return describeEnum(this);
  }

  String get fancy {
    return describeEnum(this).capitalize;
  }
}
