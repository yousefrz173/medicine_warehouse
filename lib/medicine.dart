class Medicine {
  late final Map<String, Object> _medicineInfo;
  late String _scientificName;
  late String _commercialName;
  late String _genre;
  late String _company;
  late DateTime _expirationDate;
  late double _price;
  late int _amount;

  Medicine({
    required scientificName,
    required commercialName,
    required genre,
    required company,
    required expirationDate,
    required price,
    required amount,
  })  : this._scientificName = scientificName,
        this._commercialName = commercialName,
        this._genre = genre,
        this._company = company,
        this._expirationDate = expirationDate,
        this._price = price,
        this._amount = amount {
    _medicineInfo = {
      'scientificName': scientificName,
      'commercialName': commercialName,
      'genre': genre,
      'company': company,
      'expirationDate': expirationDate,
      'price': price,
    };
  }

  Map<String, Object> get medicineInfo => _medicineInfo;

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
