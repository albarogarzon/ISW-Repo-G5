import 'package:isw_implementacion_us_08_g5/enums/times_enum.dart';

class TimeValue {
  final Times _timeKey;
  final String _timeValue;

  TimeValue(this._timeKey, this._timeValue);

  // Getters
  Times get getTimeKey => this._timeKey;
  String get getTimeValue => this._timeValue;

  bool operator ==(other) {
    return (other is TimeValue && other._timeKey == this._timeKey);
  }
}
