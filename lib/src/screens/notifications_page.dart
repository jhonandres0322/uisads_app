import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
// import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/widgets/notifications_bar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  
  bool _isEnabled = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.mainThirdContrast),
        centerTitle: true,
        actions: [
          CupertinoSwitch(
            activeColor: AppColors.titles,
            trackColor: AppColors.subtitles,
            thumbColor: AppColors.logoSchoolSecondary,
            value: _isEnabled,
            onChanged: (value) {
              setState(() {
                _isEnabled = value;
              });
            },
          ),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
        title: Text(
          _isEnabled ? 'Desactivar Notificaciones' : 'Activar Notificaciones',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFF67B93E),
                Color(0xFF3EB96B),
                Color(0xFFA9B93E)
              ])),
        ),
      ),
      body:Container(
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.10,
              ),
              _InterestWidgetVacio(),
            ],
          ),
        )
      ),
      drawer: const DrawerCustom(),
      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: const BottomNavigatonBarUisAds(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn_navigation',
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pushNamed(context, 'create-ad');
        },
        child: const Icon(
          CustomUisIcons.megaphone,
          color: AppColors.mainThirdContrast,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/// Widget que contendra el elemento de los intereses
class _InterestWidgetVacio extends StatelessWidget {
  const _InterestWidgetVacio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Condicionar este container a la hora de mostrar los intereses guardados
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Icon(
              Icons.warning,
              color: AppColors.subtitles,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'No se han encontrado notificaciones en base a los intereses seleccionados',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.subtitles),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            )
          ])),
    );
  }
}