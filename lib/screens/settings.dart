import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/language_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';

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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
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
    final LanguageController languageController = Get.put(LanguageController());
    String currentLanguage = languageController.currentLanguage;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              //   width: double.infinity,
              // height: 80,
              decoration: BoxDecoration(
                  color: AppColor.teelColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.choose_language,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () async {
                await languageController.changeLanguage('en');
                Navigator.pop(context, 'en');
              },
              child: Container(
                child: Row(
                  children: [
                    Radio(
                      activeColor: AppColor.teelColor,
                      value: 'en',
                      groupValue: currentLanguage,
                      onChanged: (String? value) async {
                        await languageController.changeLanguage(value!);
                        Navigator.pop(context, value);
                      },
                    ),
                    Text(
                      'English',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: currentLanguage == 'en'
                            ? AppColor.teelColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(

            //   title:
            //   leading:
            // ),
            // // Divider(
            //   color: AppColor.teelColor,
            // ),
            InkWell(
              onTap: () async {
                await languageController.changeLanguage('ar');
                Navigator.pop(context, 'ar');
              },
              child: Container(
                child: Row(
                  children: [
                    Radio(
                      activeColor: AppColor.teelColor,
                      value: 'ar',
                      groupValue: currentLanguage,
                      onChanged: (String? value) async {
                        await languageController.changeLanguage(value!);
                        Navigator.pop(context, value);
                      },
                    ),
                    Text(
                      'العربية',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: currentLanguage == 'ar'
                            ? AppColor.teelColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ListTile(

            //   title:
            //   leading:
            // ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
