// ignore_for_file: file_names, unused_import, prefer_collection_literals
class Parametros {
  late String ip;
  late String porta;
  late bool status;

  Parametros({required this.ip, required this.porta, required this.status}) {
    ip = ip;
    porta = porta;
    status = status;
  }

  toJson() {
    return {"porta": porta, "ip": ip, "status": status};
  }

  fromJson(json) {
    return Parametros(
        ip: json['ip'], porta: json['porta'], status: json['status']);
  }
}
