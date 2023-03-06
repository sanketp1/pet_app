// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PetDetails {
  String? image_url;
  String? title;
  String? content_url;
  String? date_added;
  PetDetails({
    this.image_url,
    this.title,
    this.content_url,
    this.date_added,
  });
 
  

  PetDetails copyWith({
    String? image_url,
    String? title,
    String? content_url,
    String? date_added,
  }) {
    return PetDetails(
      image_url: image_url ?? this.image_url,
      title: title ?? this.title,
      content_url: content_url ?? this.content_url,
      date_added: date_added ?? this.date_added,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_url': image_url,
      'title': title,
      'content_url': content_url,
      'date_added': date_added,
    };
  }

  factory PetDetails.fromMap(Map<String, dynamic> map) {
    return PetDetails(
      image_url: map['image_url'] != null ? map['image_url'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content_url: map['content_url'] != null ? map['content_url'] as String : null,
      date_added: map['date_added'] != null ? map['date_added'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PetDetails.fromJson(String source) => PetDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PetDetails(image_url: $image_url, title: $title, content_url: $content_url, date_added: $date_added)';
  }

  @override
  bool operator ==(covariant PetDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.image_url == image_url &&
      other.title == title &&
      other.content_url == content_url &&
      other.date_added == date_added;
  }

  @override
  int get hashCode {
    return image_url.hashCode ^
      title.hashCode ^
      content_url.hashCode ^
      date_added.hashCode;
  }
}
