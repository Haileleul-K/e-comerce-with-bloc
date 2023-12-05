// To parse this JSON data, do
//
//     final failure = failureFromJson(jsonString);

import 'dart:convert';

Failure failureFromJson(String str) => Failure.fromJson(json.decode(str));

String failureToJson(Failure data) => json.encode(data.toJson());

class Failure {
    bool ok;
    Error error;

    Failure({
        required this.ok,
        required this.error,
    });

    factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        ok: json["ok"],
        error: Error.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "error": error.toJson(),
    };
}

class Error {
    int? code;
    String? message;
    String? description;
    String? stackTrace;

    Error({
         this.code,
         this.message,
         this.description,
         this.stackTrace,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
        description: json["description"],
        stackTrace: json["stack_trace"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "description": description,
        "stack_trace": stackTrace,
    };
}
