import 'dart:ui';

import 'package:labartola/models/producto.dart';

class Statics {
  static String apiUrl = 'https://server-delivery-production.herokuapp.com/api';

  static Map<int, Color> color = {
    50: const Color.fromRGBO(255, 255, 255, .1),
    100: const Color.fromRGBO(255, 255, 255, .2),
    200: const Color.fromRGBO(255, 255, 255, .3),
    300: const Color.fromRGBO(255, 255, 255, .4),
    400: const Color.fromRGBO(255, 255, 255, .5),
    500: const Color.fromRGBO(255, 255, 255, .6),
    600: const Color.fromRGBO(255, 255, 255, .7),
    700: const Color.fromRGBO(255, 255, 255, .8),
    800: const Color.fromRGBO(255, 255, 255, .9),
    900: const Color.fromRGBO(255, 255, 255, 1),
  };

  static List<dynamic> listaRecargas = [
    {"cantidad": 100},
    {"cantidad": 200},
    {"cantidad": 300},
    {"cantidad": 400},
    {"cantidad": 500},
    {"cantidad": 600},
    {"cantidad": 800},
    {"cantidad": 900},
    {"cantidad": 1000},
  ];

  static List<Producto> listaProductoLakesFeel = [
    Producto(
        fechaVenta: DateTime.now(),
        id: 'id',
        precio: 100,
        nombre: 'Litros',
        descripcion: '',
        descuentoP: 0,
        descuentoC: 0,
        disponible: true,
        tienda: 'tienda',
        cantidad: 0,
        sku: 'sku',
        hot: 0,
        extra: 0,
        sugerencia: false,
        imagen: '',
        apartado: true,
        opciones: []),
    Producto(
        fechaVenta: DateTime.now(),
        id: 'id',
        precio: 45,
        nombre: 'Cerveza',
        descripcion: '',
        descuentoP: 0,
        descuentoC: 0,
        disponible: true,
        tienda: 'tienda',
        cantidad: 0,
        sku: 'sku',
        hot: 0,
        extra: 0,
        sugerencia: false,
        imagen: '',
        apartado: true,
        opciones: []),
    Producto(
        fechaVenta: DateTime.now(),
        id: 'id',
        precio: 50,
        nombre: 'Bebida Energetica',
        descripcion: '',
        descuentoP: 0,
        descuentoC: 0,
        disponible: true,
        tienda: 'tienda',
        cantidad: 0,
        sku: 'sku',
        hot: 0,
        extra: 0,
        sugerencia: false,
        imagen: '',
        apartado: true,
        opciones: []),
    Producto(
        fechaVenta: DateTime.now(),
        id: 'id',
        precio: 50,
        nombre: 'Agua Mineral 2lt',
        descripcion: '',
        descuentoP: 0,
        descuentoC: 0,
        disponible: true,
        tienda: 'tienda',
        cantidad: 0,
        sku: 'sku',
        hot: 0,
        extra: 0,
        sugerencia: false,
        imagen: '',
        apartado: true,
        opciones: []),
    Producto(
        fechaVenta: DateTime.now(),
        id: 'id',
        precio: 40,
        nombre: 'Coca Cola 1lt',
        descripcion: '',
        descuentoP: 0,
        descuentoC: 0,
        disponible: true,
        tienda: 'tienda',
        cantidad: 0,
        sku: 'sku',
        hot: 0,
        extra: 0,
        sugerencia: false,
        imagen: '',
        apartado: true,
        opciones: []),
    Producto(
        fechaVenta: DateTime.now(),
        id: 'id',
        precio: 40,
        nombre: 'Hielo',
        descripcion: '',
        descuentoP: 0,
        descuentoC: 0,
        disponible: true,
        tienda: 'tienda',
        cantidad: 0,
        sku: 'sku',
        hot: 0,
        extra: 0,
        sugerencia: false,
        imagen: '',
        apartado: true,
        opciones: []),
    Producto(
        fechaVenta: DateTime.now(),
        id: 'id',
        precio: 50,
        nombre: 'EcoVaso',
        descripcion: '',
        descuentoP: 0,
        descuentoC: 0,
        disponible: true,
        tienda: 'tienda',
        cantidad: 0,
        sku: 'sku',
        hot: 0,
        extra: 0,
        sugerencia: false,
        imagen: '',
        apartado: true,
        opciones: [])
  ];
}
