import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';

class HttpHandler {
  static String endPointUrl = APIEndpoints.endPoint;

  static Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(StorageKey.token);
   /* if (token != null) {
      debugPrint("Token -- '$token'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      debugPrint("Token  null-- '$token'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    } */
    if (token != null) {
      debugPrint("Token -- '$token'");
      return {

    'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      debugPrint("Token  null-- '$token'");
      return {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod({@required String? url, bool isMockUrl = false}) async {
    var header = await _getHeaders();

    debugPrint("Get URL -- '$endPointUrl$url'");
    debugPrint("Get Data -- 'null'");
    http.Response response = await http.get(
      Uri.parse(isMockUrl ? "$url" : "$endPointUrl$url"),
      headers: header,
    );
    debugPrint("Get Response Code -- '${response.statusCode}'");
    debugPrint("Get Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Get '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Get '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Get '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Get '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Get '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Get '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Get 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> postHttpMethod({@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    debugPrint("Post URL -- '$endPointUrl$url'");
    debugPrint("Post Data -- '$data'");
    http.Response response = await http.post(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    debugPrint("Post Response Code -- '${response.statusCode}'");
    debugPrint("Post Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Post '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Post '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Post '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Post '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Post '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Post '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Post 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> patchHttpMethod({@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    debugPrint("Patch URL -- '$endPointUrl$url'");
    debugPrint("Patch Data -- '$data'");
    http.Response response = await http.patch(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    debugPrint("Patch Response Code -- '${response.statusCode}'");
    debugPrint("Patch Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Patch '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Patch '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Patch '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Patch '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Patch '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Patch '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Patch 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> putHttpMethod({@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    debugPrint("Put URL -- '$endPointUrl$url'");
    debugPrint("PUT Data -- '$data'");
    http.Response response = await http.put(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );

    debugPrint("PUT Response code -- '${response.statusCode}'");
    debugPrint("PUT Response -- '${response.body}'");

    if (response.statusCode == 200) {
      debugPrint("In Put '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Put '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Put '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Put '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Put '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Put '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Put 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> deleteHttpMethod({@required String? url}) async {
    var header = await _getHeaders();
    debugPrint("Delete URL -- '$endPointUrl$url'");
    debugPrint("Delete Data -- 'null'");
    http.Response response = await http.delete(
      Uri.parse("$endPointUrl$url"),
      headers: header,
    );
    debugPrint("Delete Response Code -- '${response.statusCode}'");
    debugPrint("Delete Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Delete '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Delete '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Delete '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Delete '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Delete '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Delete '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Delete 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> formHttpMethod(
      {@required String? methodType,
        @required String? url,
        Map<String, String>? data,
        File? singleFile,
        File? singleFile2,
        String? singleFileKey,
        String? singleFileKey2,
        List<File>? multipleFile,
        String? multipleFileKey}) async {
    var header = await _getHeaders();
    debugPrint("Form URL -- '$endPointUrl$url'");
    debugPrint("Form Header -- '$header'");
    http.MultipartRequest request =
    http.MultipartRequest(methodType!, Uri.parse("$endPointUrl$url"));
    // request.headers.addAll(header);
    if (data != null) {
      request.fields.addAll(data);
    }
    if (singleFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        singleFileKey!,
        singleFile.path,
      ));
    }
    if (singleFile2 != null) {
      request.files.add(await http.MultipartFile.fromPath(
        singleFileKey2!,
        singleFile2.path,
      ));
    }
    if (multipleFile!.isNotEmpty) {
      for (File element in multipleFile) {
        request.files.add(await http.MultipartFile.fromPath(
          multipleFileKey!,
          element.path,
        ));
      }
    }

    debugPrint("FORM FIELDS - ${request.fields}");
    debugPrint("FORM FILES - ${request.files}");
    http.StreamedResponse streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200 ) {
      http.Response response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200 ) {
        debugPrint("In Post '${response.statusCode}'");
        debugPrint("FORM RESPONSE -- '${response.body}'");

        Map<String, dynamic> data;

          data = {
            'body': response.body,
            'headers': response.headers,
            'error': null,
          };

        return data;
      } else {
        debugPrint("In Form 'else - ${response.statusCode}'");
        return {
          'body': response.body,
          'headers': response.headers,
          'error': "${response.statusCode}",
        };
      }
    } else {
      debugPrint("In Form 'else ---- ${streamedResponse.statusCode}'");
      return {
        'headers': streamedResponse.headers,
        'error': "${streamedResponse.statusCode}",
      };
    }
  }



  static Future<Map<String, dynamic>> uploadImage({required String? url,required List<File> filesList,}) async{
    debugPrint("Delete URL -- '$endPointUrl$url'");
    var request = http.MultipartRequest("POST",Uri.parse("$endPointUrl$url"));
    request.headers['Content-Type'] = "multipart/form-data";

    filesList.forEach((element)async {
      request.files.add( http.MultipartFile.fromBytes('image', (await rootBundle.load(element.path)).buffer.asUint8List(),));
    });

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var body = String.fromCharCodes(responseData);
    if (response.statusCode == 200) {
      debugPrint("In Delete '200'");
      Map<String, dynamic> data = {
        'body': body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Delete '400'");
      Map<String, dynamic> data = {
        'body': body,
        'headers': response.headers,
        'error': "40*",
      };
      return data;
    }else {
      debugPrint("UploadImage 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }

  }
}


