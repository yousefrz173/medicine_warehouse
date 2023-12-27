class Medicine {
  String scientificName;
  String commercialName;
  String genre;
  String company;
  DateTime expirationDate;
  double price;
  int amount;
  int id;

  Medicine({
    required int this.id,
    required String this.scientificName,
    required String this.commercialName,
    required String this.genre,
    required String this.company,
    required DateTime this.expirationDate,
    required double this.price,
    required int this.amount,
  });

  Map<String, Object> get medicineInfo => {
        "id": id,
        "scientificName": scientificName,
        "commercialName": commercialName,
        "genre": genre,
        "company": company,
        "expirationDate": expirationDate,
        "price": price,
      };

  @override
  bool operator ==(Object rhs) {
    if (rhs is Medicine)
      return ((this.id == rhs.id) &&
          (this.commercialName == rhs.commercialName) &&
          (this.scientificName == rhs.scientificName) &&
          (this.genre == rhs.genre) &&
          (this.company == rhs.company) &&
          (this.expirationDate == rhs.expirationDate) &&
          (this.price == rhs.price));
    return this == rhs as Medicine;
  }
}
