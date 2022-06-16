import 'package:flutter/cupertino.dart';

// * Importación de las vistas
import 'package:uisads_app/src/screens/ad_page.dart';
import 'package:uisads_app/src/screens/change_password_page.dart';
import 'package:uisads_app/src/screens/home_page.dart';
import 'package:uisads_app/src/screens/login_page.dart';
import 'package:uisads_app/src/screens/main_page.dart';
import 'package:uisads_app/src/screens/profile_page.dart';
import 'package:uisads_app/src/screens/recovery_password.dart';
import 'package:uisads_app/src/screens/recovery_password_code.dart';
import 'package:uisads_app/src/screens/register_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  'home': ( BuildContext context ) => const HomePage(),
  'ad': ( BuildContext context ) => const AdPage(),
  'change-password': (BuildContext context ) => ChangePasswordPage(),
  'login': (BuildContext context ) => const LoginPage(),
  'main': ( BuildContext context ) => const MainPage(),
  'profile': ( BuildContext context ) => const ProfilePage(),
  'recovery-password': ( BuildContext context ) => RecoveryPasswordPage(),
  'register': ( BuildContext context ) => const RegisterPage(),
  'recovery-password-code' : ( BuildContext context ) => RecoveryPasswordCode(),
  // 'ad-description': ( BuildContext context ) => const AdPage(),
};
