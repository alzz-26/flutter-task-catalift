class UserInfoModel {
  String educationLevel = '';
  String institution = '';
  String pastRoles = '';
  Set<int> interests = {};

  UserInfoModel({
    required this.educationLevel,
    required this.institution,
    required this.pastRoles,
    required this.interests ,
  });

  bool get hasEducationInfo =>
      (educationLevel.isNotEmpty) || (institution.isNotEmpty) || (pastRoles.isNotEmpty);

  bool get hasInterests => interests.isNotEmpty;
}
