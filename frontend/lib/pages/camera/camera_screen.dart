import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/camera/widgets/camera_icon_button.dart';
import 'package:frontend/pages/camera/widgets/focus_point_widget.dart';
import 'package:frontend/pages/camera/widgets/shutter_button.dart';
import 'package:frontend/pages/dashboard/dashboard_page.dart';
import 'package:frontend/pages/result/result_page.dart';
import 'package:frontend/utils/app_colors.dart';
import 'package:frontend/utils/route.dart';
import 'package:frontend/utils/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../provider/providers.dart';

/// Displays the focus point for the particular amount of duration
const Duration _kFocusPointDisplayDuration = Duration(seconds: 3);

/// Width of the focus point
const int _kFocusPointWidthFactor = 6;

/// Whether the flash is on or not.
final flashModeProvider = StateProvider.autoDispose<FlashMode>((ref) {
  return FlashMode.off;
});

/// Camera Screen that loads camera preview to take photos and videos
class CameraScreen extends ConsumerStatefulWidget {
  static const routeName = '/camera-screen';

  const CameraScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> with WidgetsBindingObserver {
  /// Camera controller to stream the camera preview
  late CameraController _controller;

  /// Get the scaleFactor
  double _scaleFactor = 1.0, _baseScaleFactor = 1.0;

  /// Future for intitalzing the controller in FutureBuilder
  Future<void>? _initializeControllerFuture;

  /// Save the current videoPreview state using
  final GlobalKey _videoPreviewKey = GlobalKey();

  /// Notifies the value for the last FocusPoint
  final ValueNotifier<Offset?> _lastFocusPointForWidget = ValueNotifier(null);

  /// Timer for the focusPoint to be displayed
  Timer? _focusPointDisplayTimer;

  /// Get the offset for the tapPoint
  Offset? _lastFocusPoint;

  ///Called Once when the widget is initialised in the [initState] method
  /// By defaults it points to back camera
  void initializeCamera() {
    /// Get the list of cameras available on the device
    final cameraList = ref.read(cameraDescriptionProvider);

    setCamera(cameraList.first);
  }

  /// Set the camera to the selected camera
  void setCamera(CameraDescription cameraDescription) {
    /// Set the resolution preset for the camera
    /// For IOS its max
    /// For Android its veryHigh
    ResolutionPreset preset = Platform.isIOS ? ResolutionPreset.max : ResolutionPreset.veryHigh;

    /// Get the last focuspointwidget
    if (_lastFocusPointForWidget.value != null) {
      _lastFocusPointForWidget.value = null;
    }

    /// Controller initialised with the camera and preset
    _controller = CameraController(cameraDescription, preset);

    /// Also added the Future here to wait for the camera to be initialized
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (mounted) {
        setState(() {});
        _controller.setFlashMode(ref.read(flashModeProvider));
        if (_lastFocusPoint != null) {
          _controller.setExposurePoint(_lastFocusPoint);
          _controller.setFocusPoint(_lastFocusPoint);
        }
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusPointDisplayTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Can be null while transitioning to the camera screen and fast hide app to the tray
    // ignore: unnecessary_null_comparison
    if (_controller == null || !_controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      setCamera(ref.read(cameraDescriptionProvider).first);
    }
  }

  /// Setting the Camera focus when tapped on the Screen
  void _setCameraFocus(TapUpDetails details) {
    final keyContext = _videoPreviewKey.currentContext;
    const double startY = 0;
    const int borderIndent = 10;

    if (keyContext == null) {
      return;
    }

    final box = keyContext.findRenderObject() as RenderBox;

    final pointHalfWidth = box.size.width / _kFocusPointWidthFactor / 2;
    final min = pointHalfWidth + borderIndent + 30;
    final max = box.size.height - (pointHalfWidth + borderIndent + 70);
    final local = details.localPosition;

    if (local.dy < min ||
        local.dy > max ||
        local.dx < pointHalfWidth + borderIndent ||
        local.dx > box.size.width - (pointHalfWidth + borderIndent)) {
      return;
    }

    final point = local.scale(1 / box.size.width, 1 / box.size.height);

    _lastFocusPointForWidget.value = local.translate(0, startY);
    _lastFocusPoint = point;

    try {
      _controller.setExposurePoint(point);
      _controller.setFocusPoint(point);
      _focusPointDisplayTimer?.cancel();
      _focusPointDisplayTimer = Timer(_kFocusPointDisplayDuration, () {
        _lastFocusPointForWidget.value = null;
      });
    } catch (e) {
      debugPrint('CameraScreen._setCameraFocus exception: $e');
    }
  }

  IconData _getFlashIcon(FlashMode flashMode) {
    switch (flashMode) {
      case FlashMode.auto:
        return FeatherIcons.zap;
      case FlashMode.always:
        return FeatherIcons.zap;
      case FlashMode.off:
        return FeatherIcons.zapOff;
      case FlashMode.torch:
        return FeatherIcons.zap;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Tells the camera flash mode settings
    final flashMode = ref.watch(flashModeProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: NutCrackerTheme.appUiOverlayStyleDark,
      child: Scaffold(
        backgroundColor: AppColors.youDarkDimmedBlack,
        body: WillPopScope(
          onWillPop: () async {
            context.pop();
            return false;
          },
          child: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(alignment: Alignment.center, children: [
                Positioned(
                  top: 0,
                  width: constraints.maxWidth,
                  child: _cameraPreview(),
                ),
                _buildFocusPointWidget(constraints),
                Positioned(
                    top: 8,
                    left: 16,
                    child: CameraIconButton(
                      icon: FeatherIcons.x,
                      onPressed: () {
                        context.pop();
                      },
                    )),
                Positioned(
                    top: 8,
                    right: 16,
                    child: CameraIconButton(
                      icon: _getFlashIcon(flashMode),
                      onPressed: () {
                        ref.read(flashModeProvider.notifier).update((state) {
                          if (state == FlashMode.off) {
                            _controller.setFlashMode(FlashMode.auto);
                            return FlashMode.auto;
                          } else if (state == FlashMode.auto) {
                            _controller.setFlashMode(FlashMode.always);
                            return FlashMode.always;
                          } else {
                            _controller.setFlashMode(FlashMode.off);
                            return FlashMode.off;
                          }
                        });
                      },
                    )),
                Positioned(
                    bottom: 8,
                    left: 16,
                    child: CameraIconButton(
                      icon: FeatherIcons.image,
                      onPressed: () async {
                        final XFile? file = await ref
                            .read(imagePickerProvider)
                            .pickImage(source: ImageSource.gallery);

                        if (file == null) {
                          return;
                        }
                        final compressedImage = await FlutterImageCompress.compressWithFile(
                          file.path,
                          minHeight: 640,
                          minWidth: 640,
                        );
                        final byteData = compressedImage ?? await file.readAsBytes();
                        ref.read(currentImageProvider.notifier).update((state) => byteData);
                        ref.read(routerProvider).push(ResultPage.routeName);
                      },
                    )),
                Positioned(bottom: 36, child: _cameraShutter()),
              ]);
            }),
          ),
        ),
      ),
    );
  }

  Widget _cameraShutter() {
    return GestureDetector(
        onTap: () async {
          /// Do nothing if capture in progress;
          if (_controller.value.isTakingPicture) {
            return;
          }

          final scaffoldMessenger = ScaffoldMessenger.of(context);

          try {
            final file = await _controller.takePicture();
            final compressedImage = await FlutterImageCompress.compressWithFile(
              file.path,
              minHeight: 640,
              minWidth: 640,
            );
            final image = compressedImage ?? await file.readAsBytes();
            ref.read(currentImageProvider.notifier).update((state) => image);
            ref.read(routerProvider).push(ResultPage.routeName);

            // final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(image);
            // final ImageDescriptor descriptor = await ImageDescriptor.encoded(buffer);

            // final option = ImageEditorOption()
            //   ..addOption(
            //     ClipOption(
            //       width: descriptor.width,
            //       height: descriptor.width / _kPortraitAspectRatio_4_3,
            //     ),
            //   )
            //   ..outputFormat = const OutputFormat.png(90);

            // image = await ImageEditor.editImage(
            //   image: image,
            //   imageEditorOption: option,

            //   /// Wrong return type in [image_editor] package
            // ) as Uint8List;
            ///  Would not save in API 33
            // final entity = await PhotoManager.editor.saveImage(
            //   image,
            //   title: 'Photo${DateTime.now().toUtc().millisecondsSinceEpoch}',
            //   relativePath: file.path,
            // );
            // if (entity != null) {
            //   ref.read(currSelectedMediaProvider.notifier).update((state) => {
            //         ...state,
            //         entity: image,
            //       });
            //   router.push(MediaEditor.routename);
            // } else {
            //   final entity = AssetEntity(id: DataUtils.getNewGuid(), typeInt: 1, width: 0, height: 0);
            //   ref.read(currSelectedMediaProvider.notifier).update((state) => {
            //         ...state,
            //         entity: image,
            //       });
            //   router.pushReplacement(MediaEditor.routename);
            // }
          } on Exception catch (e) {
            scaffoldMessenger.showSnackBar(SnackBar(
              content: Text('Something went wrong: $e'),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        child: const ShutterButton());
  }

  /// Builds the Camera Screen
  Widget _cameraPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Align(
              key: _videoPreviewKey,
              heightFactor: 1,
              alignment: Alignment.center,
              child: GestureDetector(
                onScaleStart: (details) => _baseScaleFactor = _scaleFactor,
                onScaleUpdate: (details) {
                  _scaleFactor = _baseScaleFactor * details.scale > 1.0
                      ? _baseScaleFactor * details.scale
                      : 1.0;
                  _controller.setZoomLevel(_scaleFactor);
                },
                onTapUp: _setCameraFocus,
                child: CameraPreview(_controller),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }

  /// Builds the Focus Point Widget
  Widget _buildFocusPointWidget(BoxConstraints constraints) {
    return ValueListenableBuilder<Offset?>(
      valueListenable: _lastFocusPointForWidget,
      builder: (_, point, __) {
        if (point == null) {
          return const Positioned.fill(child: SizedBox.shrink());
        }

        final double width = constraints.maxWidth / _kFocusPointWidthFactor;

        final double effectiveLeft = min(
          constraints.maxWidth - width,
          max(0, point.dx - width / 2),
        );
        final double effectiveTop = min(
          constraints.maxHeight - width,
          max(0, point.dy - width / 2),
        );

        return Positioned(
          left: effectiveLeft,
          top: effectiveTop,
          width: width,
          height: width,
          child: FocusPointWidget(
            key: ValueKey<int>(DateTime.now().millisecondsSinceEpoch),
            size: width,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
