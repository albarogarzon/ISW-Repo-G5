import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:isw_implementacion_us_08_g5/components/ListoButton.dart';
import 'package:isw_implementacion_us_08_g5/models/Direccion.dart';
import 'package:isw_implementacion_us_08_g5/providers/DeliveryAddressInformation.dart';
import 'package:isw_implementacion_us_08_g5/providers/PickupAddressInformation.dart';
import 'package:isw_implementacion_us_08_g5/resources/Strings.dart';
import 'package:isw_implementacion_us_08_g5/validators/DeliveryAddressInformationValidator.dart';
import 'package:isw_implementacion_us_08_g5/validators/PickupAddressInformationValidator.dart';
import 'package:provider/provider.dart';

class DondeLoEntregamosScreen extends StatefulWidget {
  DondeLoEntregamosScreen();

  @override
  _DondeLoEntregamosScreenState createState() =>
      _DondeLoEntregamosScreenState();
}

class _DondeLoEntregamosScreenState extends State<DondeLoEntregamosScreen> {
  TextEditingController _telefonoFieldController;
  TextEditingController _calleFieldController;
  TextEditingController _pisoFieldController;
  TextEditingController _departamentoFieldController;
  TextEditingController _referenciasFieldController;

  DeliveryAddressInformationValidator _validator;
  DeliveryAddressInformation _informacionEntrega;

  var currentSelectedCity = "Córdoba";
  var cities = ["Córdoba", "Rio Ceballos", "Villa Allende"];

  @override
  void initState() {
    _validator = Provider.of<DeliveryAddressInformationValidator>(context,
        listen: false);
    _validator.setErrorWithoutNotifyListeners = false;

    _informacionEntrega =
        Provider.of<DeliveryAddressInformation>(context, listen: false);

    // Text Field Controllers
    _calleFieldController =
        TextEditingController(text: _informacionEntrega.getDireccion.getCalle);
    _telefonoFieldController =
        TextEditingController(text: _informacionEntrega.getTelefono);
    _pisoFieldController =
        TextEditingController(text: _informacionEntrega.getDireccion.getPiso);
    _departamentoFieldController = TextEditingController(
        text: _informacionEntrega.getDireccion.getNumDepartamento);
    _referenciasFieldController = TextEditingController(
        text: _informacionEntrega.getDireccion.getReferencias);

    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers
    _calleFieldController.dispose();
    _pisoFieldController.dispose();
    _referenciasFieldController.dispose();
    _departamentoFieldController.dispose();
    _telefonoFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _validator = Provider.of<DeliveryAddressInformationValidator>(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.DONDE_LO_ENTREGAMOS),
          backgroundColor: Color(0xffA42B36)),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildForm(),
                ],
              ),
            ),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }

  _buildSubmitButton() {
    return ListoButton(
      onPressed: _listo,
    );
  }

  _buildForm() {
    return Column(
      verticalDirection: VerticalDirection.down,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: <Widget>[
            Flexible(
              child: Text('Ciudad: ',style: TextStyle(fontSize: 16) ,),
              flex: 1,
            ),
            Flexible(child:    DropdownButton<String>(
              hint: Text("Ciudad",),
              value: currentSelectedCity,
              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  currentSelectedCity = newValue;
                });
              },
              items: cities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            flex: 1,
            )
          ],
        ),
        _divider,
        Selector<DeliveryAddressInformationValidator, bool>(
          selector: (
            _,
            validator,
          ) =>
              validator.getCalleFieldError,
          builder: (_, error, __) => TextField(
            keyboardType: TextInputType.streetAddress,
            controller: _calleFieldController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.my_location),
                onPressed: _onPressedSelectAddress,
              ),
              labelText: Strings.CALLE_Y_NUMERO,
              errorText: error ? Strings.CALLE_Y_NUMERO_ERROR : null,
            ),
          ),
        ),
        TextField(
          decoration: InputDecoration(labelText: Strings.PISO),
        ),
        TextField(
          decoration: InputDecoration(labelText: Strings.DEPARTAMENTO),
        ),
        Selector<DeliveryAddressInformationValidator, bool>(
            selector: (
              _,
              validator,
            ) =>
                validator.getTelefonoFieldError,
            builder: (_, error, __) => TextField(
                  keyboardType: TextInputType.phone,
                  controller: _telefonoFieldController,
                  decoration: InputDecoration(
                      errorText: error ? Strings.TELEFONO_ERROR : null,
                      labelText: Strings.TELEFONO,
                      helperText: Strings.TELEFONO_HELPER_TEXT),
                )),
        TextField(
          decoration: InputDecoration(
              labelText: Strings.REFERENCIAS,
              helperText: Strings.REFERENCIAS_HELPER_TEXT),
        ),
      ],
    );
  }

  void _onPressedSelectAddress() {
    _validator.error = _validator.error ? false : false;
    print(_validator.error);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlacePicker(
        apiKey: 'AIzaSyCv8gS5tnyK0W2jQB1C3bbBC5Fa6NTKIik',
        initialPosition: LatLng(-31.4567844, -64.183108),
        useCurrentLocation: false,
        selectInitialPosition: false,
        onPlacePicked: (result) {
          _calleFieldController.text = result.formattedAddress;

          Navigator.of(context).pop();
        },
      );
    }));
  }

  void _listo() {
    String calle = this._calleFieldController.text;
    String telefono = this._telefonoFieldController.text;

    _validator.validateFields(calle, telefono);
    _saveData();
  }

  void _saveData() {
    String calle = this._calleFieldController.text;
    String telefono = this._telefonoFieldController.text;
    String piso = this._pisoFieldController.text;
    String departamento = this._departamentoFieldController.text;
    String referencias = this._referenciasFieldController.text;

    if (_validator.error) {
      return;
    } else {
      this
          ._informacionEntrega
          .saveData(calle, piso, departamento, telefono, referencias);
      Navigator.of(context).pop();
    }
  }
}

final Divider _divider = Divider(
  color: Colors.grey,
  indent: 10,
  height: 0,
);
