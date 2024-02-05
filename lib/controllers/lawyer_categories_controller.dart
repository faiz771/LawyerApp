import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_textfield/dropdown_textfield.dart';

class LawyerCategoriesController extends GetxController {
  RxList<DropDownValueModel> lawyerCategories = <DropDownValueModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLawyerCategories();
  }

  Future<void> fetchLawyerCategories() async {
    final url =
        'https://lawyer-app.azsolutionspk.com/api/user/lawyer/categories';

    try {
      final response = await http.get(Uri.parse(url));

      final responseData = json.decode(response.body);

      if (responseData['status'] == 1) {
        // Categories found
        List<dynamic> categoriesData = responseData['data'];

        lawyerCategories.clear();

        for (var categoryData in categoriesData) {
          lawyerCategories.add(DropDownValueModel(
            name: categoryData['category_name'],
            value: categoryData['id'].toString(),
          ));
        }
      } else {
        // Categories not found
        print('Categories not found');
        print('Message: ${responseData['message']}');
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }
}
