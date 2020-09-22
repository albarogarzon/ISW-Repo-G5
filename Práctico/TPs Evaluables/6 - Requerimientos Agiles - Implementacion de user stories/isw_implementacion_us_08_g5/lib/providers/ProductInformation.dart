import 'dart:io';

import 'package:flutter/material.dart';

class ProductInformation extends ChangeNotifier {
  String _descripcion;
  String _value;
  File _image;
  bool _isReady;

  ProductInformation() {
    _descripcion = '';
    _value = '';
    _image = null;
    _isReady = false;
  }

  saveData(String descripcion, File image) {
    this._descripcion = descripcion;
    this._image = image;
    this._isReady = true;

    notifyListeners();
  }

  // Getters
  String get getDescripcion => this._descripcion;
  String get getValue => this._value;
  File get getImage => this._image;
  bool get isReady => _isReady;

  // Setters
  set setDescripcion(String descripcion) {
    this._descripcion = descripcion;
    notifyListeners();
  }

  set setImage(File image) {
    this._image = image;
    notifyListeners();
  }

  set setValue(String value) {
    this._value = value;
  }
}
