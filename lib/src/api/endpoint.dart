class Endpoint {
  final String host;
  final int port;
  final String baseurl;
  Endpoint({required this.host, required this.port})
      : baseurl = "http://$host:$port";
}
