import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Api.dart';


class HomeScreen extends StatelessWidget {
  final ApiController controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image & Video Gallery'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('UID')),
                DataColumn(label: Text('DocType')),
                DataColumn(label: Text('URL')),
              ],
              rows: List<DataRow>.generate(
                controller.data.length,
                    (index) => DataRow(
                  cells: [
                    DataCell(Text(controller.data[index]['_name'],style: TextStyle(overflow: TextOverflow.ellipsis),)),
                    DataCell(Text(controller.data[index]['_uid'].toString())),
                    DataCell(Text(controller.data[index]['_docType'].toString())),
                    DataCell(Image.network(height: 100,width: 100,controller.data[index]['_url'].toString())),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}