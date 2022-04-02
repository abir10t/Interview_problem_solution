

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthApiProvider{

  Client client = Client();

  Future<dynamic>login({email, password})async
  {


    Map<dynamic,String> loginJsonData =
    {
      "login_id" : email,
      "password" : password,
    };

    final response = await client.post
      (
      Uri.parse("http://3.110.10.31/api/login"),body: jsonEncode(loginJsonData),
      headers: {"Content-Type" : "application/json"},

    );
    return response;

  }



}