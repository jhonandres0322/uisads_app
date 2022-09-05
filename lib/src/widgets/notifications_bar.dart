import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uisads_app/src/constants/import_constants.dart';


class NotificationsBar extends StatefulWidget {
  const NotificationsBar({Key? key}) : super(key: key);

  @override
  State<NotificationsBar> createState() => _NotificationsBarState();
}

class _NotificationsBarState extends State<NotificationsBar> {
  bool _isEnabled = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        CustomUisIcons.bi_bell,
        color: AppColors.titles,
      ),
      title: Text(
        _isEnabled ? 'Desactivar Notificaciones' : 'Activar Notificaciones',
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