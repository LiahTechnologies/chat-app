import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:njadia/src/core/common/urls.dart';
import 'package:njadia/src/features/authentication/data/model/user_docs_response.dart';

class BackendApi {
// This is the registration of the application

  static registration1(
      {firstName,
      lastName,
      email,
      password,
      phone_number,
      date_of_birth,
      required File image,
      required File imageDocs}) async {
    final data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "tel": phone_number,
      "dob": date_of_birth,
      "selfie":"Selfie",
      "docs":"docs"
    };
    final response = await http.post(Uri.parse(AppUrls.signup),
        body: json.encode(data), headers: {"Content-Type": "Application/json"});
    print(
        "THE INPUT FIELDS IMCLUDE $firstName $lastName  $email $password  $phone_number  $date_of_birth");

    if (response.statusCode == 200)
      print("USER CREATED SUCCESSFULLY");
    else
      print("USER NOT CREATED ${response.body}");
  }

  static registration(
      {firstName,
      lastName,
      email,
      password,
      phone_number,
      date_of_birth,
      required File image,
      required File imageDocs}) async {
    print(
        "THE INPUT FIELDS IMCLUDE $firstName $lastName  $email $password  $phone_number  $date_of_birth");

    var length = await image.length;

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(AppUrls.signup_file),
    );

    var multipartFile = await http.MultipartFile.fromPath("selfie", image.path);
    var multipartFileDocs =
        await http.MultipartFile.fromPath("docs", imageDocs.path);

    request.files.add(multipartFile);
    request.files.add(multipartFileDocs);

    var endpointResponse = await request.send();
    // http.StreamedResponse endpointResponse = await request.send();

    var response = await http.Response.fromStream(endpointResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;
    // final UserDetail = UserFilesResponse.fromjson(result);

    if (endpointResponse.statusCode == 200) {
      print("FILE UPLOADED ${result['selfie'].toString()}");
      final data = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "tel": phone_number,
        "dob": date_of_birth,
        "selfie": result['selfie'],
        "docs": result['docs']
      };

      print(
          "THE INPUT FIELDS IMCLUDE $firstName $lastName  $email $password  $phone_number  $date_of_birth  data:$data");

      final response = await http.post(Uri.parse(AppUrls.signup_details),
          body: json.encode(data),
          headers: {"Content-Type": "Application/json"});
      if (response.statusCode == 200)
        return true;
      else
        return false;
    } else
      return !result['hasErrors'];
  }

// This is for the login of the application

  static login({email, password}) async {
    final response = await http.post(Uri.parse(AppUrls.login),
        body: json.encode({"email": email, "password": password}),
        headers: {"Content-Type": "Application/json"});

    if (response.statusCode == 200) {
      print("USER LOGIN SUCCESSFULLY");
      return true;
    } else {
      print("USER NOT LOGIN");

      return false;
    }
  }

  static generateOTP({required String numbers}) async {
    final response = await http.post(Uri.parse(AppUrls.OTP),
        body: json.encode({"number": numbers}),
        headers: {"content-Type": "Application/json"});
    if (response.statusCode == 200)
      print("OTP CODE IS WORKING");
    else
      print("OTP VERIFICATION CODE NOT GENERATED");
  }

  static verifyOTP({required String number, required String Code}) async {
    final response = await http.post(Uri.parse(AppUrls.OTP_VERIFICATION),
        body: json.encode({"number": number, "code": Code}),
        headers: {"Content-Type": "Application/json"});

    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
