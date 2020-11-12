class PicOfDayModel {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String title;
  final String url;

  PicOfDayModel(
      {this.copyright,
      this.date,
      this.explanation,
      this.hdurl,
      this.title,
      this.url});

  factory PicOfDayModel.fromJson(Map<String, dynamic> json) {
    return PicOfDayModel(
      copyright: json['copyright'],
      date: json['date'],
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      title: json['title'],
      url: json['url'],
    );
  }
}
