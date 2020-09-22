class PaymentMethod {
  String _name;

  PaymentMethod(this._name);

  // Getters
  String get getName => this._name;

  // Setters
  set setName(String name) {
    this._name = name;
  }

  bool operator ==(other) {
    return (other is PaymentMethod && other._name == this._name);
  }
}
