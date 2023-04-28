import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/camera/camera_screen.dart';
import 'package:frontend/pages/dashboard/widgets/dashboard_buttons.dart';
import 'package:frontend/pages/result_page.dart';
import 'package:frontend/utils/route.dart';
import 'package:frontend/utils/theme.dart';
import 'package:image_picker/image_picker.dart';

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
        body: SafeArea(
          child: Padding(
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
                        final image = await ref
                            .read(imagePickerProvider)
                            .pickImage(source: ImageSource.gallery);
                        final byteImage = await image?.readAsBytes();
                        if (image != null) {
                          ref.read(currentImageProvider.notifier).update((state) => byteImage!);
                          ref.read(routerProvider).push(ResultPage.routeName);
                        }
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
        ),
      ),
    );
  }
}
