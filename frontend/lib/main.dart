import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutcracker/provider/providers.dart';
import 'package:nutcracker/utils/route.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  debugRepaintRainbowEnabled = false;

  // List of Camera attached to the device
  List<CameraDescription> cameras = [];

  cameras = await availableCameras();
  FlutterNativeSplash.remove();
  runApp(ProviderScope(overrides: [
    cameraDescriptionProvider.overrideWithValue(cameras),
  ], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);
    return MaterialApp.router(
      routeInformationParser: route.routeInformationParser,
      routerDelegate: route.routerDelegate,
      routeInformationProvider: route.routeInformationProvider,
      title: 'Nut Cracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }
}
