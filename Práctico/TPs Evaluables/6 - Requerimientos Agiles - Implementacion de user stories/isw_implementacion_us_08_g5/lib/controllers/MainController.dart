import 'package:flutter/cupertino.dart';
import 'package:isw_implementacion_us_08_g5/enums/screens_enum.dart';
import 'package:isw_implementacion_us_08_g5/providers/DeliveryAddressInformation.dart';
import 'package:isw_implementacion_us_08_g5/providers/PaymentInformation.dart';
import 'package:isw_implementacion_us_08_g5/providers/PickupAddressInformation.dart';
import 'package:isw_implementacion_us_08_g5/providers/ProductInformation.dart';

class MainController extends ChangeNotifier {
  final DeliveryAddressInformation _deliveryAddressInformation;
  final PickupAddressInformation _pickupAddressInformation;
  final ProductInformation _productInformation;
  final PaymentInformation _paymentInformation;
  bool _isAllOk;

  MainController(
      this._deliveryAddressInformation,
      this._pickupAddressInformation,
      this._productInformation,
      this._paymentInformation) {
    _isAllOk = false;
  }

  void validate() {
    if (_deliveryAddressInformation.isReady &&
        _pickupAddressInformation.isReady) {}
  }

  bool isValid() {
    if (_deliveryAddressInformation.isReady &&
        _pickupAddressInformation.isReady &&
        _productInformation.isReady &&
        _paymentInformation.isReady) {
      return true;
    } else {
      return false;
    }
  }

  Screens whoIsNotReady() {
    if (!isValid()) {
      if (!_pickupAddressInformation.isReady) {
        return Screens.DondeLoBuscamosScreen;
      } else {
        if (!_deliveryAddressInformation.isReady) {
          return Screens.DondeLoEntregamosScreen;
        } else {
          if (!_productInformation.isReady) {
            return Screens.QueBuscamosScreen;
          } else {
            return Screens.FormaDePagoScreen;
          }
        }
      }
    } else {
      return Screens.DefaultScreen;
    }
  }

  // Getters
  bool get isAllOk => this._isAllOk;

  // Setters
  set isAllOk(bool value) {
    _isAllOk = value;
  }
}
