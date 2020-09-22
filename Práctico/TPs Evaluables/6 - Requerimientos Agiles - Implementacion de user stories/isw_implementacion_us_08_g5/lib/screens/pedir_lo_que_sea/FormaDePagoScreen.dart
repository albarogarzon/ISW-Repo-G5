import 'package:flutter/material.dart';
import 'package:isw_implementacion_us_08_g5/components/ListoButton.dart';
import 'package:isw_implementacion_us_08_g5/models/CreditCardInformation.dart';
import 'package:isw_implementacion_us_08_g5/models/Direccion.dart';
import 'package:isw_implementacion_us_08_g5/models/PaymentMethod.dart';
import 'package:isw_implementacion_us_08_g5/providers/PaymentInformation.dart';
import 'package:isw_implementacion_us_08_g5/providers/PickupAddressInformation.dart';
import 'package:isw_implementacion_us_08_g5/resources/Strings.dart';
import 'package:isw_implementacion_us_08_g5/validators/PaymentInformationValidator.dart';
import 'package:provider/provider.dart';

class FormaDePagoScreen extends StatefulWidget {
  FormaDePagoScreen();

  @override
  _FormaDePagoScreenState createState() => _FormaDePagoScreenState();
}

class _FormaDePagoScreenState extends State<FormaDePagoScreen> {
  PaymentInformation _paymentInformation;
  PaymentInformationValidator _validator;

  PaymentMethod _selectedPaymentMethod;

  TextEditingController _amountFieldController;
  TextEditingController _cardNumberFieldController;
  TextEditingController _cardNameFieldController;
  TextEditingController _cardExpirationDateFieldController;
  TextEditingController _cardCodeFieldController;

  int selectedYear;
  int selectedMonth;
  var listYears = new List<int>.generate(10, (i) => i + 2020);
  var listMonths = new List<int>.generate(12, (i) => i + 01);

  bool _amoutTextFieldEnabled = false;
  bool _cardInformationEnabled = false;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod('Efectivo'),
    PaymentMethod('Tarjeta de credito')
  ];

  @override
  void initState() {
    _paymentInformation = Provider.of<PaymentInformation>(
      context,
      listen: false,
    );
    _validator =
        Provider.of<PaymentInformationValidator>(context, listen: false);
    _validator.setErrorWithoutNotifyListeners = false;

    _selectedPaymentMethod = _paymentInformation.getPaymentMethod;

    _amountFieldController =
        TextEditingController(text: _paymentInformation.getAmount);
    _cardNumberFieldController = TextEditingController(
        text: _paymentInformation.getCreditCardInformation.getCardNumber);
    _cardNameFieldController = TextEditingController(
        text: _paymentInformation.getCreditCardInformation.getName);
    _cardExpirationDateFieldController = TextEditingController(
        text: _paymentInformation.getCreditCardInformation.getExpirationDate
            .toString());
    _cardCodeFieldController = TextEditingController(
        text: _paymentInformation.getCreditCardInformation.getCvc);

    super.initState();
  }

  @override
  void dispose() {
    _amountFieldController.dispose();
    _cardCodeFieldController.dispose();
    _cardExpirationDateFieldController.dispose();
    _cardNumberFieldController.dispose();
    _cardNameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Formas De Pago"), backgroundColor: Color(0xffA42B36)),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          // verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildTitle("Seleccioná la forma de pago"),
                  _divider,
                  _buildPaymentMethodRadioButtons(),
                  _buildTitle("Información de pago"),
                  _divider,
                  _buildPaymentInformation(),
                ],
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

  _buildPaymentMethodRadioButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
            activeColor: Color(0xffA42B36),
            title: Text(Strings.EFECTIVO),
            value: _paymentMethods[0],
            groupValue: _selectedPaymentMethod,
            onChanged: (paymentMethod) {
              _setErrorsToFalse();
              setState(() {
                _selectedPaymentMethod = paymentMethod;
                _amoutTextFieldEnabled = true;
                _cardInformationEnabled = false;
                _emptyFields();
              });
            }),
        RadioListTile(
            activeColor: Color(0xffA42B36),
            title: Text(Strings.TARJETA_DE_CREDITO),
            value: _paymentMethods[1],
            groupValue: _selectedPaymentMethod,
            onChanged: (paymentMethod) {
              _setErrorsToFalse();
              setState(() {
                _selectedPaymentMethod = paymentMethod;
                _amoutTextFieldEnabled = false;
                _cardInformationEnabled = true;
                _emptyFields();
              });
            })
      ],
    );
  }

  _emptyFields() {
    _amountFieldController.text = "";
    _cardExpirationDateFieldController.text = "";
    _cardNameFieldController.text = "";
    _cardNumberFieldController.text = "";
    _cardCodeFieldController.text = "";
  }

  _buildPaymentInformation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Selector<PaymentInformationValidator, bool>(
          selector: (_, validator) => validator.getAmountError,
          builder: (_, error, __) => TextField(
            enabled: _amoutTextFieldEnabled,
            controller: _amountFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: Strings.CON_CUANTO_VAS_A_PAGAR,
                errorText: error ? "Debe ingresar el monto a pagar" : null),
          ),
        ),
        Selector<PaymentInformationValidator, bool>(
          selector: (_, validator) => validator.getCardNumberError,
          builder: (_, error, __) => TextField(
            maxLength: 16,
            enabled: _cardInformationEnabled,
            controller: _cardNumberFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: Strings.NUMERO_DE_TARJETA_DE_CREDITO,
                errorText:
                    error ? "Debe ingresar un número de tarjeta válido" : null),
          ),
        ),
        Selector<PaymentInformationValidator, bool>(
          selector: (_, validator) => validator.getCardNameError,
          builder: (_, error, __) => TextField(
            enabled: _cardInformationEnabled,
            controller: _cardNameFieldController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                labelText: Strings.NOMBRE_EN_LA_TARJETA,
                errorText: error
                    ? "Debe ingresar el nombre que aparece en la tarjeta"
                    : null),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          child: Text(
            "Fecha de vencimiento",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: DropdownButton<int>(
                  hint: new Text("Mes"),
                  value: selectedMonth,
                  onChanged: _cardInformationEnabled
                      ? (num newValue) {
                          setState(() {
                            selectedMonth = newValue;
                          });
                        }
                      : null,
                  items: listMonths.map((int month) {
                    return new DropdownMenuItem<int>(
                      value: month,
                      child: new Text(
                        month.toString(),
                        style: new TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList()),
            ),
            Expanded(
                child: DropdownButton<int>(
                    hint: new Text("Año"),
                    value: selectedYear,
                    onChanged: _cardInformationEnabled
                        ? (num newValue) {
                            setState(() {
                              selectedYear = newValue;
                            });
                          }
                        : null,
                    items: listYears.map((int year) {
                      return new DropdownMenuItem<int>(
                        value: year,
                        child: new Text(
                          year.toString(),
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList()))
          ],
        ),
        Selector<PaymentInformationValidator, bool>(
          selector: (_, validator) => validator.getCardCodeError,
          builder: (_, error, __) => TextField(
            maxLength: 3,
            enabled: _cardInformationEnabled,
            controller: _cardCodeFieldController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: Strings.CODIGO_DE_SEGURIDAD,
                errorText: error
                    ? "Debe Ingresar el código de seguridad de la tarjeta"
                    : null),
          ),
        ),
      ],
    );
  }

  _buildTitle(String titulo) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Text(
        titulo,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  _listo() {
    String amount = _amountFieldController.text;
    CreditCardInformation creditCardInformation = CreditCardInformation(
        _cardNumberFieldController.text,
        _cardNameFieldController.text,
        _cardExpirationDateFieldController.text,
        _cardCodeFieldController.text);

    if (_validator.validateInformation(
        _selectedPaymentMethod, amount, creditCardInformation)) {
      _paymentInformation.saveData(
          _selectedPaymentMethod, amount, creditCardInformation);
      Navigator.pop(context);
    } else {
      return;
    }
  }

  _setErrorsToFalse() {
    _validator.setErrorWithoutNotifyListeners = false;
  }

  final Divider _divider = Divider(
    height: 0,
    color: Colors.grey,
  );
}
