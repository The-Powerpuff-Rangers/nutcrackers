import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutcracker/model/nut_response.dart';
import 'package:nutcracker/pages/error_screen.dart';
import 'package:nutcracker/pages/result/widget/nut_count.dart';
import 'package:nutcracker/provider/providers.dart';
import 'package:lottie/lottie.dart';

import '../dashboard/dashboard_page.dart';

final predictNutsProvider = FutureProvider.autoDispose<NutResponse>((ref) async {
  final client = ref.watch(clientProvider);

  return client.predictImage(ref.watch(currentImageProvider));
  // return Future.delayed(const Duration(seconds: 100), () {
  //   return NutResponse(
  //     image: ref.watch(currentImageProvider),
  //     data: [
  //       Nut(label: 'Almond', count: 10),
  //       Nut(label: 'Cashew', count: 20),
  //       Nut(label: 'Peanut', count: 30),
  //     ],
  //   );
  // });
});

class ResultPage extends ConsumerWidget {
  static const routeName = '/result';
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureNuts = ref.watch(predictNutsProvider);
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        if (futureNuts.isLoading || futureNuts.hasError) {
          // ref.read(clientProvider).cancel('User Cancelled');

          return Future.value(true);
        }
        if (futureNuts.hasValue) return Future.value(true);
        return Future.value(false);
      },
      child: LayoutBuilder(builder: (context, size) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: futureNuts.when(data: (data) {
              return Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: size.maxHeight * 0.5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          data.image,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: size.maxHeight * 0.5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            ref.watch(currentImageProvider),
                          )),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Lottie.asset(
                      'assets/loading.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  Text('Fetching Results',
                      style: textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)),
                  const Spacer(),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
