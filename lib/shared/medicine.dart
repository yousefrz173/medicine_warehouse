class Medicine {
  String scientificName;
  String commercialName;
  String genre;
  String company;
  DateTime expirationDate;
  double price;
  int id;
  int amount;
  Medicine({
    required this.id,
    required this.scientificName,
    required this.commercialName,
    required this.genre,
    required this.company,
    required this.expirationDate,
    required this.price,
    required this.amount,
  });

  Map<String, Object> get medicineInfoMap => {
        "id": id,
        "scientificName": scientificName,
        "commercialName": commercialName,
        "genre": genre,
        "company": company,
        "expirationDate": expirationDate,
        "price": price,
      };
}
