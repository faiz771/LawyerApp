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
    String currentLanguage = languageController.currentLanguage;

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
                // padding: EdgeInsets.only(
                //   top: 20.0,
                //   bottom: 16.0,
                //   left: 16.0,
                //   right: 16.0,
                // ),
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
                    Container(
                      width: double.infinity,
                      // height: 80,
                      decoration: BoxDecoration(
                          color: AppColor.teelColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.choose_language,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ListTile(
                      onTap: () async {
                        await languageController.changeLanguage('en');
                        Navigator.pop(context, 'en');
                      },
                      title: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: currentLanguage == 'en'
                              ? AppColor.teelColor
                              : Colors.black,
                        ),
                      ),
                      leading: Radio(
                        activeColor: AppColor.teelColor,
                        value: 'en',
                        groupValue: currentLanguage,
                        onChanged: (String? value) async {
                          await languageController.changeLanguage(value!);
                          Navigator.pop(context, value);
                        },
                      ),
                    ),
                    // Divider(
                    //   color: AppColor.teelColor,
                    // ),
                    ListTile(
                      onTap: () async {
                        await languageController.changeLanguage('ar');
                        Navigator.pop(context, 'ar');
                      },
                      title: Text(
                        'العربية',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: currentLanguage == 'ar'
                              ? AppColor.teelColor
                              : Colors.black,
                        ),
                      ),
                      leading: Radio(
                        activeColor: AppColor.teelColor,
                        value: 'ar',
                        groupValue: currentLanguage,
                        onChanged: (String? value) async {
                          await languageController.changeLanguage(value!);
                          Navigator.pop(context, value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
