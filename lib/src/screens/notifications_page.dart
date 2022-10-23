import 'dart:developer';

import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_services.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
// import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationPageProvider>(context);
    notificationProvider.estadoNotificaciones = Preferences.isNotify;
    final Size size = MediaQuery.of(context).size;
    String notificacionTitle = notificationProvider.estadoNotificaciones
        ? 'Desactivar Notificaciones'
        : 'Activar Notificaciones';

    var dialog = UtilsOperations.mostrarDialogo(
        context, '¿Desea $notificacionTitle de sus intereses definidos?');
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
            value: notificationProvider.estadoNotificaciones,
            onChanged: (value) async {
              bool confirmacion = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => dialog);
              if (confirmacion) {
                final notificationProvider =
                    Provider.of<NotificationPageProvider>(context,
                        listen: false);
                _sendNotificationChoice(value, context);
                notificationProvider.estadoNotificaciones = value;
              }
            },
          ),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
        title: Text(
          notificacionTitle,
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
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.10,
            ),
            _InterestWidgetVacio(),
          ],
        ),
      )),
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

  // Enviar valor notificacion BD
  void _sendNotificationChoice(bool value, BuildContext context) async {
    final notificacionesService = NotificationService();
    Response response;
    if (value) {
      // Activar notificaciones
      response =
          await notificacionesService.activarDesactivarNotificaciones('active');
    } else {
      // Desactivar notificaciones
      response = await notificacionesService
          .activarDesactivarNotificaciones('inactive');
    }
    UtilsOperations.mostrarResultadoError(response, context);
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
