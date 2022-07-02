class Env {

  final _endpointDev = 'http://10.0.2.2:5000/api';  
  final String _endpointPrd = '';

  String getEndpoint(String type) {
    if (type == 'dev') {
      return _endpointDev;
    } else {
      return _endpointPrd;
    }
  }
}
