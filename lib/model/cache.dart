class CacheModel {
  final CacheImages cacheImages;

  CacheModel({
    this.cacheImages,
  });

  factory CacheModel.fromJson(Map<String, dynamic> json) {
    return CacheModel(
      cacheImages: CacheImages.fromJson(json['links']),
    );
  }
}

class CacheImages {
  String title;
  String explanation;
  String url;
  String date;

  CacheImages({
    this.title,
    this.explanation,
    this.url,
    this.date,
  });

  factory CacheImages.fromJson(Map<String, dynamic> json) {
    return CacheImages(
      title: json['title'],
      explanation: json['explanation'],
      url: json['url'],
      date: json['date'],
    );
  }
}

// datos.date: {
//         'title': 'datos.title',
//         'explanation': 'datos.explanation',
//         'image': 'datos.url',
//         'date': 'date'
//       },
