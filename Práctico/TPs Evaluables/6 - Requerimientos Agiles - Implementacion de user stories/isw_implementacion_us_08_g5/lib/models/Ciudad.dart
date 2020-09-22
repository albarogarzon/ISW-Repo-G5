class Ciudad {
  String _nombre;

  Ciudad() {
    this._nombre = '';
  }
  Ciudad.withParameters(this._nombre);

  // Getters
  String get getNombre => this._nombre;

  // Setters

  set setNombre(String nombre) {
    this._nombre = nombre;
  }
}
