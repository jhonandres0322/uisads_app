class Env {

  final String _endpointDev = 'http://192.168.1.11:5000/api';  
  final String _endpointPrd = '';

  String getEndpoint(String type) {
    if (type == 'dev') {
      return _endpointDev;
    } else {
      return _endpointPrd;
    }
  }
}
