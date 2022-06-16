import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';

List<Map<String, dynamic>> listDrawer = [
  {
    'icon': CustomUisIcons.advertising,
    'route': 'main',
    'label': 'Mis Publicaciones',
    'key': 'ads'
  },
  {
    'icon': CustomUisIcons.message,
    'route': '',
    'label': 'Envia tus comentarios',
    'key': 'comments'
  },
  {
    'icon': CustomUisIcons.info,
    'route': '',
    'label': 'Acerca de la app',
    'key': 'about'
  }
];

Map<String, dynamic> logoutDrawerInfo = {
  'icon' : CustomUisIcons.log_out,
  'route': 'login',
  'label': 'Cerrar Sesión',
  'key': 'logout'
};
