import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:frontend/model/nut_response.dart';

class Client {
  final Dio dio;
  const Client(this.dio);

  Future<NutResponse> predictImage(Uint8List image) async {
    String path = '/predict';
    try {
      final baseEncoded = base64.encode(image);
      final body = {'image': baseEncoded};
      final response = await dio.post(path, data: body);
      return NutResponse.fromMap(response.data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
