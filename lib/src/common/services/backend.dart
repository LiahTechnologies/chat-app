import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class BackendApi {


  static const String url = "http://192.168.100.12:8000/api/user/";


// This is the registration of the application

  static registration(
      { 
      firstName,
      lastName,
      email,
      password,
      phone_number,
      date_of_birth,
      required File image,
      required File imageDocs
      
      }) async {
        
    var length = await image.length;

    var request = http.MultipartRequest("POST", Uri.parse(url+"register/"));
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['email'] = email;
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
    final response = await http.post(Uri.parse(url + "login"),
        body: {email: email, password: password});

    if (response.statusCode == 200)
      print("USER LOGIN SUCCESSFULLY");
    else
      print("USER NOT LOGIN");
  }



}
