import 'package:flutter/cupertino.dart';
import 'package:isw_implementacion_us_08_g5/models/Direccion.dart';

class AddressInformation extends ChangeNotifier {
  Direccion _direccion;
  String _telefono;
  bool _isReady;

  AddressInformation() {
    this._direccion = Direccion();
    this._telefono = '';
    this._isReady = false;
  }

  void saveData(String calle, String piso, String departamento, String telefono,
      String referencias) {
    this._direccion.setCalle = calle;
    this._direccion.setPiso = piso;
    this._direccion.setNumDepartamento = departamento;
    this._direccion.setReferencias = referencias;
    this._telefono = telefono;
    _isReady = true;
    notifyListeners();
  }

  // Getters
  Direccion get getDireccion => _direccion;
  String get getTelefono => _telefono;
  bool get isReady => _isReady;

  // Setters

  setDireccion(Direccion direccion) {
    this._direccion = direccion;
    notifyListeners();
  }

  set setCalle(String calle) {
    this._direccion.setCalle = calle;
    this._isReady = true;
    notifyListeners();
  }

  set setTelefono(String telefono) {
    this._telefono = telefono;
    notifyListeners();
  }
}
