import 'package:flutter/cupertino.dart';

import 'package:uisads_app/src/constants/import_screens.dart';

class RoutesApp {

  static Map< String, WidgetBuilder> routes = {
    'home': ( BuildContext context ) => const HomePage(),
    'ad': ( BuildContext context ) => const AdPage(),
    'change-password': (BuildContext context ) => const ChangePasswordPage(),
    'login': (BuildContext context ) => const LoginPage(),
    'main': ( BuildContext context ) => const MainPage(),
    'profile': ( BuildContext context ) => const ProfilePage(),
    'recovery-password': ( BuildContext context ) => const RecoveryPasswordPage(),
    'register': ( BuildContext context ) => const RegisterPage(),
    'recovery-password-code' : ( BuildContext context ) => const RecoveryPasswordCode(),
    'create-ad' : (BuildContext context) => const CreateAdPage(),
    'edit-profile': (BuildContext context ) => const EditProfilePage(),
    'new-password' :(BuildContext context) => const NewPasswordPage(), 
    'search' : (BuildContext context) => const SearchPage(),
    'edit-ad': (BuildContext context ) => const EditAdPage()
  };

}


