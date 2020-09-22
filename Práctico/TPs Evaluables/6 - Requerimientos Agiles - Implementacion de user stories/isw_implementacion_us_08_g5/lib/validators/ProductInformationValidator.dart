import 'package:flutter/material.dart';

class ProductInformationValidator extends ChangeNotifier {
  bool _state;
  bool _descripcionState;

  ProductInformationValidator() {
    this._state = true;
    this._descripcionState = true;
  }

  // Getters
  bool get getDescripcionState => _descripcionState;
  bool get getState => _state;

  bool validateInformation(String descripcion) {
    _validateDescripcion(descripcion);
    return _state;
  }

  validateImageSize() {}

  _validateDescripcion(String descripcion) {
    if (descripcion.isEmpty) {
      setState = false;
      setDescripcionState = false;
    } else {
      setState = true;
      setDescripcionState = true;
    }
  }

  // Setters
  set setDescripcionState(bool value) {
    this._descripcionState = value;
    notifyListeners();
  }

  set setState(bool value) {
    this._state = value;
    notifyListeners();
  }

  set setStateWithoutNotify(bool value) {
    this._state = value;
    this._descripcionState = value;
  }
}
