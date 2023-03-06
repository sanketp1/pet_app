// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PetDetails {
  String? image_url;
  String? title;
  String? contentUrl;
  String? dateAdded;
  PetDetails({
    this.image_url,
    this.title,
    this.contentUrl,
    this.dateAdded,
  });
  

  PetDetails copyWith({
    String? image_url,
    String? title,
    String? contentUrl,
    String? dateAdded,
  }) {
    return PetDetails(
      image_url: image_url ?? this.image_url,
      title: title ?? this.title,
      contentUrl: contentUrl ?? this.contentUrl,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': image_url,
      'title': title,
      'contentUrl': contentUrl,
      'dateAdded': dateAdded,
    };
  }

  factory PetDetails.fromMap(Map<String, dynamic> map) {
    return PetDetails(
      image_url: map['image_url'] != null ? map['image_url'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      contentUrl: map['contentUrl'] != null ? map['contentUrl'] as String : null,
      dateAdded: map['dateAdded'] != null ? map['dateAdded'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PetDetails.fromJson(String source) => PetDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PetDetails(image_url: $image_url, title: $title, contentUrl: $contentUrl, dateAdded: $dateAdded)';
  }

  @override
  bool operator ==(covariant PetDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.image_url == image_url &&
      other.title == title &&
      other.contentUrl == contentUrl &&
      other.dateAdded == dateAdded;
  }

  @override
  int get hashCode {
    return image_url.hashCode ^
      title.hashCode ^
      contentUrl.hashCode ^
      dateAdded.hashCode;
  }
}
