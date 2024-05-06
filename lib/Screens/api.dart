import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ApiController extends GetxController {
  var data = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    final String apiUrl = 'https://ajcjewel.com:4000/api/global-gallery/list';
    final String bearerToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTcxMTQ0NTY1OSwiZXhwIjoxNzQyOTgxNjU5fQ.lE1Gbdm8YZ6Fany4184Pb7kSUg-z6Rk8Ag1irB3fstc';

    try {
      final response = await Dio().post(
        apiUrl,
        data: {
          "statusArray": [1],
          "screenType": [],
          "responseFormat": [],
          "globalGalleryIds": [],
          "categoryIds": [],
          "docTypes": [],
          "types": [],
          "limit": 10,
          "skip": 0,
          "searchingText": ""
        },
        options: Options(
          headers: {
            'Authorization': '$bearerToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 201) {
        data.value = response.data['data']['list'];
        isLoading.value = false;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
    }
  }
}
