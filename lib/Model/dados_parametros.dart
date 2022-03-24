// ignore_for_file: camel_case_types

class ipParam {
  String? ip;

  ipParam(String text, {this.ip});

  ipParam.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    return data;
  }
}

class porta_param {
  String? porta;

  porta_param(String text, {this.porta});

  porta_param.fromJson(Map<String, dynamic> json) {
    porta = json['porta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['porta'] = porta;
    return data;
  }
}

class name_param {
  String? name;

  name_param(String text, {this.name});

  name_param.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class pass_param {
  String? senha;

  pass_param(String text, {this.senha});

  pass_param.fromJson(Map<String, dynamic> json) {
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senha'] = senha;
    return data;
  }
}
