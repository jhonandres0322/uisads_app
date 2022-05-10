class Env {
  final String _endpointDev = 'http://192.168.1.6:5000/api';
  final String _endpointPrd = '';

  String getEndpoint( String type ) {
    if (type.contains('dev')) {
      return _endpointDev;
    } else {
      return _endpointPrd;
    }
  }
}
