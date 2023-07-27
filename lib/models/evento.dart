// To parse this JSON data, do
//
//     final evento = eventoFromJson(jsonString);

import 'dart:convert';

import 'package:labartola/models/reservacion.dart';

List<Evento> eventoFromJson(String str) => List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

String eventoToJson(List<Evento> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Evento {
    List<Reservacion> reservaciones;
    List<String> lineUp;
    String id;
    String nombre;
    DateTime fechaFin;
    DateTime fechaInicio;
    String cover;
    bool disponible;
    String descripcion;

    Evento({
        required this.reservaciones,
        required this.lineUp,
        required this.id,
        required this.nombre,
        required this.fechaFin,
        required this.fechaInicio,
        required this.cover,
        required this.disponible,
        required this.descripcion,
    });

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        reservaciones: List<Reservacion>.from(json["reservaciones"].map((x) => Reservacion.fromJson(x))),
        lineUp: List<String>.from(json["line_up"].map((x) => x)),
        id: json["_id"] ?? json["uid"],
        nombre: json["nombre"],
        fechaFin: DateTime.parse(json["fecha_fin"]),
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        cover: json["cover"],
        disponible: json["disponible"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "reservaciones": List<dynamic>.from(reservaciones.map((x) => x)),
        "line_up": List<dynamic>.from(lineUp.map((x) => x)),
        "_id": id,
        "nombre": nombre,
        "fecha_fin": fechaFin.toIso8601String(),
        "fecha_inicio": fechaInicio.toIso8601String(),
        "cover": cover,
        "disponible": disponible,
        "descripcion": descripcion,
    };
}
