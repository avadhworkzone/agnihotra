import 'package:get/get.dart';

import 'en.dart';
import 'gu.dart';
import 'hi.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {"en_US": en, 'gu': gu,'hi':hi};
}
