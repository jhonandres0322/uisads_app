import 'package:uisads_app/src/constants/import_constants.dart';

List<Map<String, dynamic>> listDrawer = [
  {
    'icon': CustomUisIcons.advertising,
    'route': 'main',
    'label': 'Mis Publicaciones',
    'key': 'ads'
  },
  {
    'icon': CustomUisIcons.bi_bell,
    'route': 'notifications',
    'label': 'Notificaciones',
    'key': 'notifications'
  },
  {
    'icon': CustomUisIcons.favorite_outline,
    'route': 'favorites-ad',
    'label': 'Mis Favoritos',
    'key': 'favorites'
  },
  {
    'icon': CustomUisIcons.todo_list,
    'route': 'interest',
    'label': 'Mis Intereses',
    'key': 'interests'
  },
  {
    'icon': CustomUisIcons.history_return,
    'route': 'history-ad',
    'label': 'Historial',
    'key': 'history'
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
  },
];

Map<String, dynamic> logoutDrawerInfo = {
  'icon' : CustomUisIcons.log_out,
  'route': 'login',
  'label': 'Cerrar Sesión',
  'key': 'logout'
};
