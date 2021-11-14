part of 'entities.dart';

class CreatedBy extends Equatable {
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String? profilePath;

  Map<String, dynamic> toJson() => {
        'id': id,
        'credit_id': creditId,
        'name': name,
        'gender': gender,
        'profile_path': profilePath,
      };

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        gender,
        profilePath,
      ];
}
