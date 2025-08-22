
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/constants.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';


abstract class AuthRemoteDataSource
{
  Future<void> createUser({required String name, required String avatar, required String createdAt});
  Future<List<UserModel>> getUsers();
}
const userListEndpoint = '/users';
const userCreateEndpoint = '/users';
class AuthRemoteDataSrcImpl implements AuthRemoteDataSource{
  AuthRemoteDataSrcImpl(this.client);

  final http.Client client;


  @override
  Future<void> createUser({required String name, required String avatar, required String createdAt}) async{
    // TODO: implement createUser
    try{
          final response = await client.post(Uri.parse('${baseUrl}${userCreateEndpoint}'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'createdAt':createdAt,'name':name,'avatar':avatar}));
        if(response.statusCode!=200&&response.statusCode!=201){
           throw ApiFailure(message: response.body, statusCode: response.statusCode);
        }
    }catch(e){
      throw ApiFailure(message: e.toString(), statusCode: 505);
    }
   
  }

  @override
  Future<List<UserModel>> getUsers() async{
    // TODO: implement getUsers
    try{
      final response = await client.get(Uri.parse('${baseUrl}${userListEndpoint}'));

      if(response.statusCode!=200){
        throw ApiFailure(message: response.body, statusCode: response.statusCode);
      }
       return List<DataMap>.from(jsonDecode(response.body) as List).map((userData)=>UserModel.fromMap(userData)).toList();
    }catch(e){
       throw ApiFailure(message: e.toString(), statusCode: 505);
    }
   
  
    }
  }