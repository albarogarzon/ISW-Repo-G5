import 'package:flutter/material.dart';
import 'package:isw_implementacion_us_08_g5/components/ListoButton.dart';
import 'package:isw_implementacion_us_08_g5/enums/times_enum.dart';
import 'package:isw_implementacion_us_08_g5/models/Direccion.dart';
import 'package:isw_implementacion_us_08_g5/models/TimeValue.dart';
import 'package:isw_implementacion_us_08_g5/providers/DeliveryTimeInformation.dart';
import 'package:isw_implementacion_us_08_g5/providers/PickupAddressInformation.dart';
import 'package:isw_implementacion_us_08_g5/resources/Strings.dart';
import 'package:provider/provider.dart';

class CuandoQueresRecibirloScreen extends StatefulWidget {
  CuandoQueresRecibirloScreen();

  @override
  _CuandoQueresRecibirloScreenState createState() =>
      _CuandoQueresRecibirloScreenState();
}

class _CuandoQueresRecibirloScreenState
    extends State<CuandoQueresRecibirloScreen> {
  DeliveryTimeInformation _deliveryTimeInformation;
  TimeValue _selected;

  final List<TimeValue> _options = [
    TimeValue(Times.lo_antes_posible, Strings.LO_ANTES_POSIBLE),
    TimeValue(Times.diez, Strings.DIEZ_HS),
    TimeValue(Times.diez_treinta, Strings.DIEZ_TREINTA_HS),
    TimeValue(Times.once, Strings.ONCE_HS),
    TimeValue(Times.once_treinta, Strings.ONCE_TREINTA_HS),
    TimeValue(Times.doce, Strings.DOCE_HS),
    TimeValue(Times.doce_treinta, Strings.DOCE_TREINTA_HS),
    TimeValue(Times.trece, Strings.TRECE_HS),
    TimeValue(Times.trece_treinta, Strings.TRECE_TREINTA_HS),
    TimeValue(Times.catorce, Strings.CATORCE_TREINTA_HS),
    TimeValue(Times.catorce_treinta, Strings.CATORCE_TREINTA_HS),
    TimeValue(Times.quince, Strings.QUINCE_HS),
    TimeValue(Times.quince_treinta, Strings.QUINCE_TREINTA_HS),
    TimeValue(Times.dieciseis, Strings.DIECISEIS_HS),
    TimeValue(Times.dieciseis_treinta, Strings.DIECISEIS_TREINTA_HS),
    TimeValue(Times.diecisiete, Strings.DIECISIETE_HS),
    TimeValue(Times.diecisiete_treinta, Strings.DIECISIETE_TREINTA_HS),
    TimeValue(Times.dieciocho, Strings.DIECIOCHO_HS),
    TimeValue(Times.dieciocho_treinta, Strings.DIECIOCHO_TREINTA_HS),
    TimeValue(Times.diecinueve, Strings.DIECINUEVE_HS),
    TimeValue(Times.diecinueve_treinta, Strings.DIECINUEVE_TREINTA_HS),
    TimeValue(Times.veinte, Strings.VEINTE_HS),
    TimeValue(Times.veinte_treinta, Strings.VEINTE_TREINTA_HS),
    TimeValue(Times.veintiuno, Strings.VEINTIUNO_HS),
    TimeValue(Times.veintiuno_treinta, Strings.VEINTIUNO_TREINTA_HS),
    TimeValue(Times.veintidos, Strings.VEINTIDOS_HS),
  ];

  @override
  void initState() {
    _deliveryTimeInformation =
        Provider.of<DeliveryTimeInformation>(context, listen: false);
    _selected = _deliveryTimeInformation.getSelectedTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.CUANDO_QUERES_RECIBIRLO),
          backgroundColor: Color(0xffA42B36)),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _options.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 1,
                    height: 0,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile<TimeValue>(
                      activeColor: Color(0xffA42B36),
                      title: Text(_options[index].getTimeValue),
                      value: _options[index],
                      groupValue: _selected,
                      onChanged: (TimeValue value) {
                        setState(() {
                          _selected = value;
                        });
                      });
                },
              ),
            ),
            ListoButton(
              onPressed: _listo,
            ),
          ],
        ),
      ),
    );
  }

  _listo() {
    _saveData();
    Navigator.of(context).pop();
  }

  _saveData() {
    this._deliveryTimeInformation.setSelectedTime = this._selected;
  }
}

final Divider _divider = Divider(
  color: Colors.grey,
  indent: 10,
  height: 0,
);
