import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/routes.dart';
import 'package:uisads_app/src/constants/themes.dart';
import 'package:uisads_app/src/providers/ad_page_provider.dart';
import 'package:uisads_app/src/providers/bottom_navigation_provider.dart';
import 'package:uisads_app/src/providers/category_provider.dart';
import 'package:uisads_app/src/providers/create_ad_provider.dart';
import 'package:uisads_app/src/providers/edit_profile_provider.dart';
import 'package:uisads_app/src/providers/login_form_provider.dart';
import 'package:uisads_app/src/providers/main_page_provider.dart';
import 'package:uisads_app/src/providers/profile_provider.dart';
import 'package:uisads_app/src/providers/register_form_provider.dart';
import 'package:uisads_app/src/utils/screen_size.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => CreateAdProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => MainPageProvider()),
        ChangeNotifierProvider(create: (_) => AdPageProvider()),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Generando la aplicación");
    return LayoutBuilder(builder: ((context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ScreenSize().init(constraints, orientation);
        return ScreenUtilInit(
          designSize: const Size(360, 780),
          builder: () {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: RoutesApp.routes,
              initialRoute: 'home', //home por defecto
              theme: AppTheme.themePrimary,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: const [Locale('es', 'ES'), Locale('en', 'EN')],
              builder: (context, widget) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                  Widget error = Text(
                      "... Renderizando error....: ${errorDetails.summary}");
                  if (widget is Scaffold || widget is Navigator) {
                    error = Scaffold(body: Center(child: error));
                  }
                  return error;
                };
                return widget!;
              },
            );
          },
        );
      });
    }));
  }
}
