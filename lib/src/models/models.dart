// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    String password;
    String usuario;

    Login({
        required this.password,
        required this.usuario,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        password: json["password"],
        usuario: json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "usuario": usuario,
    };
}
