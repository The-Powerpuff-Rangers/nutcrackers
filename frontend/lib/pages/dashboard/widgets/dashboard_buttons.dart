import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardButton extends ConsumerWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const DashboardButton({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
            ),
            Text(
              title,
              style: textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
