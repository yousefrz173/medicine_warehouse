class Medicine {
  String scientificName;
  String commercialName;
  String category;
  String company;
  DateTime expirationDate;
  double price;
  int id;
  int availableAmount;

  Medicine({
    required this.id,
    required this.scientificName,
    required this.commercialName,
    required this.category,
    required this.company,
    required this.expirationDate,
    required this.price,
    required this.availableAmount,
  });

  Map<String, Object> get medicineInfoMap => {
        "id": id,
        "scientificName": scientificName,
        "commercialName": commercialName,
        "category": category,
        "company": company,
        "expirationDate": expirationDate,
        "price": price,
        "availableAmount": availableAmount,
      };

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      scientificName: json['s_name'],
      commercialName: json['t_name'],
      category: json['category'],
      company: json['company'],
      availableAmount: json['amount'],
      expirationDate: DateTime.parse(json['end_date']),
      price: json['price'].toDouble(),
    );
  }
}
