import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/camera/camera_screen.dart';
import 'package:frontend/pages/dashboard/widgets/dashboard_buttons.dart';
import 'package:frontend/pages/result/result_page.dart';
import 'package:frontend/utils/route.dart';
import 'package:frontend/utils/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../provider/providers.dart';

final currentImageProvider = StateProvider<Uint8List>((ref) {
  return Uint8List(0);
});

class DashboardPage extends ConsumerWidget {
  static const routeName = '/dashboard';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: NutCrackerTheme.appUiOverlayStyleLight,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Coming Soon !'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(LucideIcons.history)),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                  bottom: -50,
                  child: Opacity(
                    opacity: 0.25,
                    child: Image.asset(
                      'assets/bg.png',
                      fit: BoxFit.fitHeight,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'Select an Image from gallery or take a picture',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DashboardButton(
                          icon: FeatherIcons.image,
                          title: 'Gallery',
                          onTap: () async {
                            final image = await ref.read(imagePickerProvider).pickImage(
                                source: ImageSource.gallery, maxHeight: 640, maxWidth: 640);
                            if (image == null) return;

                            final byteImage = await image.readAsBytes();

                            ref.read(currentImageProvider.notifier).update((state) => byteImage);
                            ref.read(routerProvider).push(ResultPage.routeName);
                          },
                        ),
                        DashboardButton(
                          icon: FeatherIcons.camera,
                          title: 'Camera',
                          onTap: () {
                            ref.read(routerProvider).push(CameraScreen.routeName);
                          },
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
