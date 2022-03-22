class User {
  int codusu;
  String nomeusu;
  int codparc;
  int codemp;
  String nomeusucplt;
  String email;
  String adWindowsad;
  String adStatus;
  int codvend;
  String urlimg;
  String token;

  User(
      {required this.codusu,
      required this.nomeusu,
      required this.codparc,
      required this.codemp,
      required this.nomeusucplt,
      required this.email,
      required this.adWindowsad,
      required this.adStatus,
      required this.codvend,
      required this.urlimg,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        codusu: json['CODUSU'],
        nomeusu: json['NOMEUSU'],
        codparc: json['CODPARC'],
        codemp: json['CODEMP'],
        nomeusucplt: json['NOMEUSUCPLT'],
        email: json['EMAIL'],
        adWindowsad: json['AD_WINDOWSAD'],
        adStatus: json['AD_STATUS'],
        codvend: json['CODVEND'],
        urlimg: json['URLIMG'],
        token: json['token']);
  }

  /*
  factory User.vazio(Map<String, dynamic> json) {
    return User(
        codusu : 0,
        nomeusu : null,
        codparc : 0,
        codemp : 0,
        nomeusucplt : null,
        email : null,
        adWindowsad : null,
        adStatus : null,
        codvend : 0,
        urlimg : null,
        token: null
    );
  }
  */

}
