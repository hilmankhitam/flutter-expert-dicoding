part of 'models.dart';

class ProductionCompanyModel extends Equatable {
  ProductionCompanyModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) =>
      ProductionCompanyModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}

class ProductionCountryModel extends Equatable {
  ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  final String iso31661;
  final String name;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };

  @override
  List<Object?> get props => [
        iso31661,
        name,
      ];
}
