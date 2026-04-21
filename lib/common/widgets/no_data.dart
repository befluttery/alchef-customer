import 'package:alchef/config/app_sizes.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(s.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.hourglass_empty,
              size: s.iconLg + 20,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: s.spacingMd - 4),
            Text(
              'No Data',
              style: TextStyle(
                fontSize: s.fontLg,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: s.spacingMd - 4),
            if (onRetry != null)
              SizedBox(
                height: s.buttonHeight,
                width: 124,
                child: ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
