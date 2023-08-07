import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';


class MyAppState extends ChangeNotifier {
  User currentUser = User();
  bool showAchievements = false;
  int selectedIndex = -1;

  void toggleAchievements() {
    showAchievements = !showAchievements;
    notifyListeners();
  }

  void setAchievements(bool value) {
    showAchievements = value;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    if (index == selectedIndex) {
      selectedIndex = -1;
    } else {
      selectedIndex = index;
    }
    notifyListeners();
  }

  void setCurrentUser(User user) {
    currentUser = user;
    notifyListeners();
  }
}
