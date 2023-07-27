// To parse this JSON data, do
//
//     final amigo = amigoFromJson(jsonString);

import 'dart:convert';

List<Amigo> amigoFromJson(String str) => List<Amigo>.from(json.decode(str).map((x) => Amigo.fromJson(x)));

String amigoToJson(List<Amigo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Amigo {
    String nombre;
    String idUsuario;
    String id;
    String celular;

    Amigo({
        required this.nombre,
        required this.idUsuario,
        required this.id,
        required this.celular,
    });

    factory Amigo.fromJson(Map<String, dynamic> json) => Amigo(
        nombre: json["nombre"],
        idUsuario: json["id_usuario"],
        id: json["_id"],
        celular: json["celular"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "id_usuario": idUsuario,
        "_id": id,
    };
}
