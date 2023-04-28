import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/nut_response.dart';
import 'package:frontend/pages/error_screen.dart';
import 'package:frontend/pages/result/widget/nut_count.dart';
import 'package:frontend/provider/providers.dart';

import '../dashboard/dashboard_page.dart';

final predictNutsProvider = FutureProvider.autoDispose<NutResponse>((ref) async {
  final client = ref.watch(clientProvider);

  return client.predictImage(ref.watch(currentImageProvider));
});

class ResultPage extends ConsumerWidget {
  static const routeName = '/result';
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureNuts = ref.watch(predictNutsProvider);
    return WillPopScope(
      onWillPop: () {
        if (futureNuts.isLoading || futureNuts.hasError || futureNuts.hasValue) {
          ref.invalidate(predictNutsProvider);
          return Future.value(true);
        }

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: futureNuts.when(data: (data) {
          return Column(
            children: [
              Image.memory(data.image),
              Row(
                children: data.data.map((e) => NutCount(nut: e)).toList(),
              )
            ],
          );
        }, error: (e, stack) {
          return ErrorScreen(
            error: e,
            stackTrace: stack,
          );
        }, loading: () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 1,
                  child: Image.memory(ref.watch(currentImageProvider))),
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text('Predicting...'),
            ],
          );
        }),
      ),
    );
  }
}
