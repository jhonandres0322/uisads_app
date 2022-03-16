class Env {
  String type = 'development';
  String endpointDev = 'http://localhost:5000/api';
  String endpointPrd = '';

  String getEndpoint() {
    if (type.contains('development')) {
      return endpointDev;
    } else {
      return endpointPrd;
    }
  }
}
