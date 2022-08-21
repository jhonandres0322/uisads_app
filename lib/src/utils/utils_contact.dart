import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UtilsContact {
  /// Metodo para contactar al usuario enviado
  static void contactarUsuario(String telefono, String mensaje) async {
    Uri uri = Uri(
        scheme: 'https',
        host: 'api.whatsapp.com',
        path: '/send',
        queryParameters: {
          'phone': _getPhoneNumber(telefono),
          'text': mensaje,
        });
    print(uri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo lanzar el llamado a $uri';
    }
  }

  static String _getPhoneNumber(String phoneNumber) {
    return '57' + phoneNumber;
  }
}
