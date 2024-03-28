
import 'dart:html';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:njadia/src/features/authentication/data/data_sources/user-data-source.dart';
import 'package:njadia/src/features/authentication/domain/repositories/user-repository.dart';

@GenerateMocks(  
   [

    UserRepository,
    UserRemoteDataSource,
  ],

  customMocks:[MockSpec<http.Client>(as:#MockHttpClient)],
  

)

void main(){}

