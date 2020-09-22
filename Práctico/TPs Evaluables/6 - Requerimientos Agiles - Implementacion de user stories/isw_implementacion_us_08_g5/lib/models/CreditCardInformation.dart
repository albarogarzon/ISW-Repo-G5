class CreditCardInformation {
  String _number;
  String _name;
  String _expirationDate;
  String _cvc;

  CreditCardInformation(
      this._number, this._name, this._expirationDate, this._cvc);

  // Getters
  String get getCardNumber => this._number;
  String get getName => this._name;
  String get getCvc => this._cvc;
  String get getExpirationDate => this._expirationDate;

  // Setters
  set setCardNumber(String number) {
    this._number = number;
  }

  set setName(String firstName) {
    this._name = firstName;
  }

  set setCvc(String cvc) {
    this._cvc = cvc;
  }

  set setExpirationDate(String expirationDate) {
    this._expirationDate = expirationDate;
  }
}
