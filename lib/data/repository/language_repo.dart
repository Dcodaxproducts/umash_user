import 'package:umash_user/data/model/language.dart';
import 'package:umash_user/utils/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstants.languages;
  }
}
