import 'package:flutter/cupertino.dart';
import 'package:isw_implementacion_us_08_g5/enums/times_enum.dart';
import 'package:isw_implementacion_us_08_g5/models/TimeValue.dart';
import 'package:isw_implementacion_us_08_g5/resources/Strings.dart';

class DeliveryTimeInformation extends ChangeNotifier {
  TimeValue _selectedTime;

  DeliveryTimeInformation() {
    this._selectedTime =
        TimeValue(Times.lo_antes_posible, Strings.LO_ANTES_POSIBLE);
  }

  // Getters
  TimeValue get getSelectedTime => this._selectedTime;

  // Setters
  set setSelectedTime(TimeValue selectedTime) {
    this._selectedTime = selectedTime;
    notifyListeners();
  }
}
