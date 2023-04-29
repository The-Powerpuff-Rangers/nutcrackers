import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/nut_response.dart';

class NutCount extends ConsumerWidget {
  final Nut nut;
  const NutCount({super.key, required this.nut});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        children: [
          Text(
            nut.label.name.toUpperCase(),
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            nut.count.toString(),
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
