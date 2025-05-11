import 'package:flutter/material.dart';
import '../models/user_info_model.dart';

class UserInfoProvider extends ChangeNotifier {
  final UserInfoModel _userInfo = UserInfoModel(interests: {}, educationLevel: '', institution: '', pastRoles: '');

  UserInfoModel get userInfo => _userInfo;

  void setEducationInfo(String level, String institution, String roles) {
    _userInfo.educationLevel = level;
    _userInfo.institution = institution;
    _userInfo.pastRoles = roles;
    notifyListeners();
  }

  void setInterests(Set<int> interests) {
    _userInfo.interests = interests;
    notifyListeners();
  }

  void setEducationLevel(String edu) {
    _userInfo.educationLevel = edu;
    notifyListeners();
  }

  void setInstitution(String inst) {
    _userInfo.institution = inst;
    notifyListeners();
  }

  void setPastRoles(String roles) {
    _userInfo.pastRoles = roles;
  }

}
