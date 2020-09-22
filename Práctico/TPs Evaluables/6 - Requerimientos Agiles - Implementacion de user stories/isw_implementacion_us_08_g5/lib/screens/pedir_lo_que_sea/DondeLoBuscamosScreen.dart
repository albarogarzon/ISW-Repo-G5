import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:isw_implementacion_us_08_g5/components/ListoButton.dart';
import 'package:isw_implementacion_us_08_g5/models/Direccion.dart';
import 'package:isw_implementacion_us_08_g5/providers/PickupAddressInformation.dart';
import 'package:isw_implementacion_us_08_g5/resources/Strings.dart';
import 'package:isw_implementacion_us_08_g5/validators/PickupAddressInformationValidator.dart';
import 'package:provider/provider.dart';

class DondeLoBuscamosScreen extends StatefulWidget {
  @override
  _DondeLoBuscamosScreenState createState() => _DondeLoBuscamosScreenState();
}

class _DondeLoBuscamosScreenState extends State<DondeLoBuscamosScreen> {
  PickResult selectedPlace;
  TextEditingController _telefonoFieldController;
  TextEditingController _calleFieldController;
  TextEditingController _pisoFieldController;
  TextEditingController _departamentoFieldController;
  TextEditingController _referenciasFieldController;

  PickupAddressInformationValidator _validator;
  PickupAddressInformation _informacionRetiro;

  @override
  void initState() {
    _validator =
        Provider.of<PickupAddressInformationValidator>(context, listen: false);
    _validator.setErrorWithoutNotifyListeners = false;
    _informacionRetiro =
        Provider.of<PickupAddressInformation>(context, listen: false);

    // Field controllers
    _calleFieldController =
        TextEditingController(text: _informacionRetiro.getDireccion.getCalle);
    _telefonoFieldController =
        TextEditingController(text: _informacionRetiro.getTelefono);
    _pisoFieldController =
        TextEditingController(text: _informacionRetiro.getDireccion.getPiso);
    _departamentoFieldController = TextEditingController(
        text: _informacionRetiro.getDireccion.getNumDepartamento);
    _referenciasFieldController = TextEditingController(
        text: _informacionRetiro.getDireccion.getReferencias);

    super.initState();
  }

  @override
  void dispose() {
    _calleFieldController.dispose();
    _telefonoFieldController.dispose();
    _referenciasFieldController.dispose();
    _pisoFieldController.dispose();
    _departamentoFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.DONDE_LO_BUSCAMOS),
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
                children: [_buildForm()],
              ),
            ),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }

  _buildForm() {
    return Column(
      verticalDirection: VerticalDirection.down,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Selector<PickupAddressInformationValidator, bool>(
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
        Selector<PickupAddressInformationValidator, bool>(
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

  _buildSubmitButton() {
    return ListoButton(
      onPressed: _listo,
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
          ._informacionRetiro
          .saveData(calle, piso, departamento, telefono, referencias);
      Navigator.of(context).pop();
    }
  }
}

final Divider _divider = Divider(
  color: Colors.grey,
);
