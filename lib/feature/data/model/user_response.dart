// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    bool ok;
    Data data;

    UserResponse({
        required this.ok,
        required this.data,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        ok: json["ok"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String name;
    String phone;
    String email;
    String country;
    DateTime birthDay;
    String status;
    String profileImage;
    String nickName;
    String gender;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.name,
        required this.phone,
        required this.email,
        required this.country,
        required this.birthDay,
        required this.status,
        required this.profileImage,
        required this.nickName,
        required this.gender,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        country: json["country"],
        birthDay: DateTime.parse(json["birth_day"]),
        status: json["status"],
        profileImage: json["profile_image"],
        nickName: json["nick_name"],
        gender: json["gender"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "country": country,
        "birth_day": birthDay.toIso8601String(),
        "status": status,
        "profile_image": profileImage,
        "nick_name": nickName,
        "gender": gender,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
