// To parse this JSON data, do
//
//     final mensajeAmigo = mensajeAmigoFromJson(jsonString);

import 'dart:convert';

import 'package:labartola/models/amigo.dart';

MensajeAmigo mensajeAmigoFromJson(String str) => MensajeAmigo.fromJson(json.decode(str));

String mensajeAmigoToJson(MensajeAmigo data) => json.encode(data.toJson());

class MensajeAmigo {
    String msg;
    bool ok;
    Amigo usuario;

    MensajeAmigo({
        required this.msg,
        required this.ok,
        required this.usuario
    });

    factory MensajeAmigo.fromJson(Map<String, dynamic> json) => MensajeAmigo(
        msg: json["msg"],
        ok: json["ok"], 
        usuario: Amigo.fromJson(json['usuario']),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "ok": ok,
    };
}
