// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  String address;
  String description;
  String fileName;
  String filePath;
  int lat;
  int lng;
  String postCode;
  String title;

  Ticket({
    required this.address,
    required this.description,
    required this.fileName,
    required this.filePath,
    required this.lat,
    required this.lng,
    required this.postCode,
    required this.title,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        address: json["address"],
        description: json["description"],
        fileName: json["fileName"],
        filePath: json["filePath"],
        lat: json["lat"],
        lng: json["lng"],
        postCode: json["postCode"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "description": description,
        "fileName": fileName,
        "filePath": filePath,
        "lat": lat,
        "lng": lng,
        "postCode": postCode,
        "title": title,
      };
}
