import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/provider/providers.dart';

import 'dashboard/dashboard_page.dart';

final predictNutsProvider = FutureProvider.autoDispose<Response>((ref) async {
  final client = ref.watch(clientProvider);
  return client.predictImage(ref.watch(currentImageProvider));
});

class ResultPage extends ConsumerWidget {
  static const routeName = '/result';
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentImage = ref.watch(currentImageProvider);
    return Column(
      children: [
        if (currentImage.isNotEmpty) Image.memory(currentImage),
      ],
    );
  }
}
