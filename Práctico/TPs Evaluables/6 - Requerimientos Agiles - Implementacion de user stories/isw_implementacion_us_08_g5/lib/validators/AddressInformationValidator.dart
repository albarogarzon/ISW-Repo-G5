import 'package:flutter/material.dart';

class AddressInformationValidator extends ChangeNotifier {
  bool _validatorError;
  bool _validatorCalleError;
  bool _validatorTelefonoError;

  AddressInformationValidator() {
    this._validatorError = false;
    this._validatorCalleError = false;
    this._validatorTelefonoError = false;
  }

  void validateFields(String calle, String telefono) {
    _validateCalleField(calle);
    _validateTelefonoField(telefono);
    if (_validatorCalleError || _validatorTelefonoError) {
      this._validatorError = true;
      notifyListeners();
    } else {
      this._validatorError = false;
      notifyListeners();
    }
  }

  void _validateCalleField(String calle) {
    if (calle.isEmpty) {
      this._validatorCalleError = true;
    } else {
      this._validatorCalleError = false;
    }
  }

  void _validateTelefonoField(String telefono) {
    if (telefono.isEmpty) {
      this._validatorTelefonoError = true;
    } else {
      this._validatorTelefonoError = false;
    }
  }

  bool get getTelefonoFieldError => this._validatorTelefonoError;
  bool get getCalleFieldError => this._validatorCalleError;

  set error(bool value) {
    this._validatorError = value;
    notifyListeners();
  }

  set setErrorWithoutNotifyListeners(bool value) {
    this._validatorError = value;
    this._validatorCalleError = value;
    this._validatorTelefonoError = value;
  }

  bool get error => this._validatorError;
}
