class Club {
  final String clubLider;
  final String clubLogo;
  final String clubName;
  final String daniAd;
  final String daniMail;
  final String liderMail;
  final String liderTel;

  Club(
      {required this.clubLider,
      required this.clubLogo,
      required this.clubName,
      required this.daniAd,
      required this.daniMail,
      required this.liderMail,
      required this.liderTel});

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      clubLider: map['clubLider'],
      clubLogo: map['clubLogo'],
      clubName: map['clubName'],
      daniAd: map['daniAd'],
      daniMail: map['daniMail'],
      liderMail: map['liderMail'],
      liderTel: map['liderTel'],
    );
  }
}
