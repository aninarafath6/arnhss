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
import 'package:flutter/foundation.dart';

extension EnumExtension on Enum {
  String get describe {
    return describeEnum(this);
  }
}
