import 'dart:io';


class Server {

  start() async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8181);
    print("Server running on IP : "+server.address.toString()+" On Port : "+server.port.toString());
    await for (var request in server) {
      request.response
        ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
        ..write('Hello, world')
        ..close();
    }
  }

}

