import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lawyerapp/controllers/language_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  Future<void> storeLanguage(String language) async {
    final storage = FlutterSecureStorage();
    try {
      await storage.write(key: 'language', value: language);
      print('language changed');
    } catch (e) {
      print('Error writing to secure storage: $e');
    }
  }

  final LanguageController languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.teelColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListTile(
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            title: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              EvaIcons.globe,
              color: Color.fromRGBO(17, 25, 40, 1),
            ),
            onTap: () {
              showLanguageDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                margin: EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.choose_language,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    InkWell(
                      onTap: () async {
                        // Change language to English
                        await storeLanguage('en');
                        Navigator.pop(context, 'en');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'English',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () async {
                        // Change language to Arabic
                        await storeLanguage('ar');
                        Navigator.pop(context, 'ar');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'العربية',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16.0,
                top: 16.0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColor.teelColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
