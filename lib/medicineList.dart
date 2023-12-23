import 'package:flutter/material.dart';
import 'medicine.dart';

List<Medicine> PharamacistMedicineList = List.generate(
    12,
    (index) => Medicine(
        scientificName: 'a$index',
        commercialName: 'Aspirin',
        genre: 'anti-inflammatory',
        company: 'Bayer AG',
        expirationDate: DateTime(2026, 12, 4),
        price: 4.45, amount: 100));
List<Medicine> StorekeeperMedicineList = List.generate(
    12,
    (index) => Medicine(
        scientificName: 'acetylsalicylic',
        commercialName: 'Aspirin',
        genre: 'anti-inflammatory',
        company: 'Bayer AG',
        expirationDate: DateTime(2026, 12, 4),
        price: 4.45, amount: 100),
);

