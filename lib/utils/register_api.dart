import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register {
  List<dynamic> attendanceDatad = [];
  Future<void> register(String name, String employeeId, String department,
      String position, String imagePath) async {
    var uri = Uri.https(
        "face-attendance-apis-1812.onrender.com", "/api/v1/auth/register");
    var boundary = "----${DateTime.now().microsecondsSinceEpoch}";
    var requests = http.MultipartRequest('POST', uri);
    var headers = {
      "Content-type": "multipart/form-data; boundary=${boundary}",
      "Content-length": "${requests.contentLength}",
      "Host": "${requests.url.host}",
      "User-Agent": "PostmanRuntime/7.32.2",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
    };
    var imageFile = File(imagePath);
    var imageBytes = await imageFile.readAsBytes();
    var multipartFile = await http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: 'image.jpg',
      contentType: MediaType(
        'image',
        'jpg',
      ),
    );

    /* var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: 'image.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    */
    requests.files.add(multipartFile);
    //requests.headers.addAll(headers);
    //requests.fields['image'] = imagePath;
    requests.fields['name'] = name;
    requests.fields['empolyeeId'] = employeeId;
    requests.fields['department'] = department;
    requests.fields['position'] = position;
    var response = await http.Response.fromStream(await requests.send());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Registration successful');
      Fluttertoast.showToast(
          msg: "Registration successful", gravity: ToastGravity.TOP);
      // print(response.body());
    } else {
      print('Registration failed');
      Fluttertoast.showToast(
          msg: "${response.statusCode}", gravity: ToastGravity.TOP);
      print(response.statusCode);
      // print(await response.stream.bytesToString());
    }
    print(response.body);
  }

  Future<void> login(String email, String password) async {
    var uri = Uri.https(
        "face-attendance-apis-1812.onrender.com", "/api/v1/auth/login");
    var body = {
      "email": email,
      "password": password,
    };
    final response = await http.post(
      uri,
      headers: {
        "Content-type": "application/json",
        "Content-length": "<calculated when request is sent>",
        "Host": "<calculated when request is sent>",
        "User-Agent": "PostmanRuntime/7.32.2",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      },
      body: jsonEncode(body),
    );
    print(response);
  }

  Future<List<dynamic>> fetchAttendanceByDate(
      List<dynamic> attendanceData, DateTime date, String tokend) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final url =
        'https://face-attendance-apis-1812.onrender.com/api/v1/attendance?date=${formattedDate}';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': "Bearer $tokend",
    });
    if (response.statusCode == 200) {
      // print(response.body);
      final jsonData = json.decode(response.body);
      attendanceData = jsonData['data'];
      //  print(attendanceData);
      attendanceDatad = attendanceData;
      return attendanceData;
    } else {
      // Handle API error
      print(response.statusCode);
      print(response.body);
      print("nodata");
      return attendanceData;
    }
  }
}
