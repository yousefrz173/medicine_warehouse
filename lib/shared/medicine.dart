class Medicine {
  late final Map<String, Object> _medicineInfo;
  late String _scientificName;
  late String _commercialName;
  late String _genre;
  late String _company;
  late DateTime _expirationDate;
  late double _price;
  late int _amount;
  late int _id;

  Medicine({
    required int id,
    required String scientificName,
    required String commercialName,
    required String genre,
    required String company,
    required DateTime expirationDate,
    required double price,
    required int amount,
  })  : this._scientificName = scientificName,
        this._commercialName = commercialName,
        this._genre = genre,
        this._company = company,
        this._expirationDate = expirationDate,
        this._price = price,
        this._amount = amount,
        this._id = id {
    _medicineInfo = {
      "id": _id,
      "scientificName": _scientificName,
      "commercialName": _commercialName,
      "genre": _genre,
      "company": _company,
      "expirationDate": _expirationDate,
      "price": _price,
    };
  }

  Map<String, Object> get medicineInfo => _medicineInfo;

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  set price(double value) {
    _price = value;
  }

  set expirationDate(DateTime value) {
    _expirationDate = value;
  }

  set company(String value) {
    _company = value;
  }

  set genre(String value) {
    _genre = value;
  }

  set commercialName(String value) {
    _commercialName = value;
  }

  set scientificName(String value) {
    _scientificName = value;
  }

  double get price => _price;

  DateTime get expirationDate => _expirationDate;

  String get company => _company;

  String get genre => _genre;

  String get commercialName => _commercialName;

  String get scientificName => _scientificName;
}
