import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../api/client.dart';

final cameraDescriptionProvider = Provider<List<CameraDescription>>((ref) {
  return [];
});

final imagePickerProvider = Provider<ImagePicker>((ref) {
  return ImagePicker();
});

final clientProvider = Provider<Client>((ref) {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.100.40.135:3545',
    contentType: 'application/json',
    receiveTimeout: const Duration(seconds: 15),
    connectTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 10),
  ));
  return Client(dio);
});
