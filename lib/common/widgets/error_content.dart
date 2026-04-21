import 'package:flutter/material.dart';


class ErrorContent extends StatelessWidget {
  const ErrorContent({super.key, required this.message, required this.onRetry});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_outlined,
              size: 52,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 12),
            Text(
              message ?? 'Unexpected error',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            if (onRetry != null) ...[
              SizedBox(
                height: 44,
                width: 124,
                child: ElevatedButton(onPressed: onRetry, child: Text('Retry')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
