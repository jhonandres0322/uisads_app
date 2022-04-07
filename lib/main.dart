import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/routes.dart';
import 'package:uisads_app/src/utils/screen_size.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ScreenSize().init(constraints, orientation);
        return ScreenUtilInit(
          designSize: const Size(360, 780),
          builder: () {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              routes: appRoutes,
              initialRoute: 'home',
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.mainThirdContrast,
                textTheme: GoogleFonts.robotoTextTheme(),
                // ignore: prefer_const_constructors
                appBarTheme: AppBarTheme(
                  color: AppColors.primary,
                  elevation: 1,
                  // ignore: prefer_const_constructors
                  iconTheme: IconThemeData(
                    color: AppColors.logoSchoolOpaque,
                    
                  )
                )
              ),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              navigatorKey: Get.key,
              supportedLocales: const [Locale('es', 'ES'), Locale('en', 'EN')],
              builder: (context, widget) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails){
                  Widget error = Text("... Renderizando error....: ${errorDetails.summary}" );
                  if (widget is Scaffold || widget is Navigator){
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
