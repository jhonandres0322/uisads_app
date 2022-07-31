class Env {

  static const String _endpointDev = 'http://192.168.1.101:5000/api';  
  static const String _endpointPrd = 'https://uisads.herokuapp.com/api';

  static String getEndpoint(String type) {
    if (type == 'dev') {
      return _endpointDev;
    } else {
      return _endpointPrd;
    }
  }
}
