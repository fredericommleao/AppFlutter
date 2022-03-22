// To parse this JSON data, do
//
//     final responsePost = responsePostFromJson(jsonString);

import 'dart:convert';

ResponsePost responsePostFromJson(String str) =>
    ResponsePost.fromJson(json.decode(str));

String responsePostToJson(ResponsePost data) => json.encode(data.toJson());

class ResponsePost {
  ResponsePost({
    required this.serviceName,
    required this.status,
    required this.pendingPrinting,
    required this.transactionId,
    required this.responseBody,
  });

  String serviceName;
  String status;
  String pendingPrinting;
  String transactionId;
  ResponseBody responseBody;

  factory ResponsePost.fromJson(Map<String, dynamic> json) => ResponsePost(
        serviceName: json["serviceName"],
        status: json["status"],
        pendingPrinting: json["pendingPrinting"],
        transactionId: json["transactionId"],
        responseBody: ResponseBody.fromJson(json["responseBody"]),
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "status": status,
        "pendingPrinting": pendingPrinting,
        "transactionId": transactionId,
        "responseBody": responseBody.toJson(),
      };
}

class ResponseBody {
  ResponseBody({
    required this.callId,
    required this.jsessionid,
    required this.idusu,
  });

  CallId callId;
  CallId jsessionid;
  CallId idusu;

  factory ResponseBody.fromJson(Map<String, dynamic> json) => ResponseBody(
        callId: CallId.fromJson(json["callID"]),
        jsessionid: CallId.fromJson(json["jsessionid"]),
        idusu: CallId.fromJson(json["idusu"]),
      );

  Map<String, dynamic> toJson() => {
        "callID": callId.toJson(),
        "jsessionid": jsessionid.toJson(),
        "idusu": idusu.toJson(),
      };
}

class CallId {
  CallId({
    required this.empty,
  });

  String empty;

  factory CallId.fromJson(Map<String, dynamic> json) => CallId(
        empty: json["\$"],
      );

  Map<String, dynamic> toJson() => {
        "\$": empty,
      };
}
