import 'dart:convert';

import 'package:flutter/foundation.dart';

enum Label {
  washers,
  nuts,
  bolts,
}

Label fromString(String label) {
  switch (label) {
    case 'Type A':
      return Label.washers;
    case 'Type B':
      return Label.nuts;
    case 'Type C':
      return Label.bolts;
    default:
      throw Exception('Invalid label: $label');
  }
}

class Nut {
  final Label label;
  final int count;
  Nut({
    required this.label,
    required this.count,
  });

  Nut copyWith({
    Label? label,
    int? count,
  }) {
    return Nut(
      label: label ?? this.label,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'count': count,
    };
  }

  factory Nut.fromMap(Map<String, dynamic> map) {
    return Nut(
      label: fromString(map['label']),
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Nut.fromJson(String source) => Nut.fromMap(json.decode(source));

  @override
  String toString() => 'Nut(label: $label, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Nut && other.label == label && other.count == count;
  }

  @override
  int get hashCode => label.hashCode ^ count.hashCode;
}

class NutResponse {
  final Uint8List image;
  final List<Nut> data;
  NutResponse({
    required this.image,
    required this.data,
  });

  NutResponse copyWith({
    Uint8List? image,
    List<Nut>? data,
  }) {
    return NutResponse(
      image: image ?? this.image,
      data: data ?? this.data,
    );
  }

  factory NutResponse.fromMap(Map<String, dynamic> map) {
    return NutResponse(
      image: base64.decode(map['image']),
      data: List<Nut>.from(map['data']?.map((x) => Nut.fromMap(x))),
    );
  }

  factory NutResponse.fromJson(String source) => NutResponse.fromMap(json.decode(source));

  @override
  String toString() => 'NutResponse(image: $image, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NutResponse && other.image == image && listEquals(other.data, data);
  }

  @override
  int get hashCode => image.hashCode ^ data.hashCode;
}
