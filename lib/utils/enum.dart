import 'assets.dart';

enum BottomNavigationBarEnum { search, notification, home, love, user }

extension BottomNavigationBarEnumExt on BottomNavigationBarEnum {
  String get icon {
    switch (this) {
      case BottomNavigationBarEnum.search:
        return Assets.search;
      case BottomNavigationBarEnum.notification:
        return Assets.notification;
      case BottomNavigationBarEnum.home:
        return Assets.home;
      case BottomNavigationBarEnum.love:
        return Assets.love;
      case BottomNavigationBarEnum.user:
        return Assets.user;
    }
  }
}
