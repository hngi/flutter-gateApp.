class VisitorTileModel{
  String _name, _address, _time;

  //VisitorTileModel(this._name, this._address, this._time);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  get address => _address;

  get time => _time;

  set time(value) {
    _time = value;
  }

  set address(value) {
    _address = value;
  }


}