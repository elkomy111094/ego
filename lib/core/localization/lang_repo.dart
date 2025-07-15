import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

import '../../app/get_it/get_it.dart';
import '../../config/app_config.dart';
import '../../core/cache/cache_helper.dart';
import '../../core/utils/translation_helper.dart';

class LangRepo {
  String? lang ;
  String ? selectedLanguage ; 
  LangRepo();

  Future<Either<String, void>> setLang(
      {required String lang,required String language,required BuildContext context}) async {
    try {
      this.lang = lang;
      CacheHelper.saveData(key: kUserLangKey ,  value: lang );
      selectedLanguage = language; 
      context.setLocale(
        Locale(
          lang,
        ),
      );
      return const Right(null);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }

  Future<Either<String, String>> getLang() async {
    try {
      final kLang = await CacheHelper.getData(kUserLangKey) ;

      if (kLang is String) {
        lang = kLang;
      } else {
        lang = "en";
      }

      return Right(lang ?? 'en');
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }
}
