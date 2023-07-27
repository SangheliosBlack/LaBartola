// To parse this JSON data, do
//
//     final reservacion = reservacionFromJson(jsonString);

import 'dart:convert';

Reservacion reservacionFromJson(String str) => Reservacion.fromJson(json.decode(str));

String reservacionToJson(Reservacion data) => json.encode(data.toJson());

class Reservacion {
    String mesaId;
    String id;
    String administrador;
    String nombreAdminstrador;
    String numeroAdminstrador;
    List<String> listaInvitados;
    int consumoMinimo;
    int maximoPersonas;
    bool regular;
    bool regularMesa;
    bool vip;
    bool premium;

    Reservacion({
        required this.numeroAdminstrador,
        required this.nombreAdminstrador,
        required this.mesaId,
        required this.id,
        required this.administrador,
        required this.listaInvitados,
        required this.consumoMinimo,
        required this.maximoPersonas,
        required this.regular,
        required this.regularMesa,
        required this.vip,
        required this.premium,
    });

    factory Reservacion.fromJson(Map<String, dynamic> json) => Reservacion(
        nombreAdminstrador: json["nombre_administrador"] ?? "",
        mesaId: json["mesa_id"],
        id: json["_id"] ?? json["uid"],
        administrador: json["administrador"] ?? "" ,
        listaInvitados: List<String>.from(json["lista_invitados"].map((x) => x)),
        consumoMinimo: json["consumo_minimo"],
        maximoPersonas: json["maximo_personas"],
        regular: json["regular"],
        regularMesa: json["regular_mesa"],
        vip: json["vip"],
        premium: json["premium"], numeroAdminstrador: json["numero_administrador"] ?? '',
        
    );

    Map<String, dynamic> toJson() => {
        "mesa_id": mesaId,
        "_id": id,
        "administrador": administrador,
        "lista_invitados": List<dynamic>.from(listaInvitados.map((x) => x)),
        "consumo_minimo": consumoMinimo,
        "maximo_personas": maximoPersonas,
        "premium": premium,
    };
}
