import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final switchButtonProvider = StateProvider<bool>((ref) {
  return false;
});

class SwitchButton extends ConsumerWidget {
  const SwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.tonal(
        onPressed: () => ref.read(switchButtonProvider.notifier).update((state) => !state),
        child: Text("Raw"),
        style: FilledButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          backgroundColor: ref.watch(switchButtonProvider)
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
        ));
  }
}
