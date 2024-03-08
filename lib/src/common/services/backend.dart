import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:njadia/src/common/urls.dart';

class BackendApi {
// This is the registration of the application




  static registration( {firstName,
      lastName,
      email,
      password,
      phone_number,
      date_of_birth,
      required File image,
      required File imageDocs
      }) async {

        final data ={"firstName":firstName,
        "lastName":lastName,
        "email": email, 
        "password": password,
        "tel":phone_number,
        "dob":date_of_birth
        };
    final response = await http.post(Uri.parse(AppUrls.signup),
        body: json.encode(data),
        headers: {"Content-Type":"Application/json"}
        );

    if (response.statusCode == 200)
      print("USER CREATED SUCCESSFULLY");
    else
      print("USER NOT CREATED ${response.body}");
  }

  static registration2(
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

    var request = http.MultipartRequest("POST", Uri.parse(AppUrls.signup));
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['tel'] = phone_number;
    request.fields['dob'] = date_of_birth;
    var multipartFile = await http.MultipartFile.fromPath("selfie", image.path);
    var multipartFileDocs =
        await http.MultipartFile.fromPath("docs", imageDocs.path);

    request.files.add(multipartFile);
    request.files.add(multipartFileDocs);

    http.StreamedResponse endpointResponse = await request.send();

    print("THE RESPONSED FORM THE ENDPOINT IS $endpointResponse");
  }

// This is for the login of the application

  static login({email, password}) async {
    final response = await http.post(Uri.parse(AppUrls.login),
        body: {"email": email, "password": password});

    if (response.statusCode == 200)
      print("USER LOGIN SUCCESSFULLY");
    else
      print("USER NOT LOGIN");
  }
}
