import 'package:flutter/cupertino.dart';
import 'package:flutter_api/model/model.dart';
import 'package:flutter_api/service/service.dart';

class Controller extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  bool? isLoading;
  List<UserModelData?> users = [];
  List<UserModelData?> saved = [];

  void getData() {
    Service.fetch().then((value) {
      if (value != null) {
        users = value.data!;
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void addSaved(UserModelData model) {
    saved.add(model);
    users.remove(model);
    notifyListeners();
  }

  notSavedButton() {
    pageController.animateToPage(0,
        duration: const Duration(microseconds: 500), curve: Curves.easeInExpo);
  }

  savedButton() {
    pageController.animateToPage(1,
        duration: const Duration(microseconds: 500), curve: Curves.easeInExpo);
  }
}
// controllerı olusturduk verımızı cagırdık....

