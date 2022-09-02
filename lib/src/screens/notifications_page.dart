import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

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
          IconButton(
            icon: Icon(CustomUisIcons.settings_bold), 
            color: AppColors.mainThirdContrast,
            onPressed: () {},  
          ),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
        title: const Text(
          'Notificaciones',
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
                ]
            )
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            // Widget de favoritos
            _NotificationBar(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
    );
  }
}

///  Widget que muestra la barra de encender o apagar las notificaciones
class _NotificationBar extends StatefulWidget {
  const _NotificationBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<_NotificationBar> {
  bool _isEnabled = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        CustomUisIcons.bi_bell,
        color: AppColors.titles,
      ),
      title: Text(
        _isEnabled ? 'Desactivar Notificaciones': 'Activar Notificaciones',
        style: TextStyle(
          fontFamily: GoogleFonts.robotoSlab().fontFamily,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: AppColors.logoSchoolPrimary,
        ),
      ),
      trailing: CupertinoSwitch(
        activeColor: AppColors.third,
        value: _isEnabled,
        onChanged: (value) {
          setState(() {
            _isEnabled = value;
          });
        },
      ),
    );
  }
}