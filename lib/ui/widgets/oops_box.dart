import 'package:flutter/material.dart';

class OopsBox extends StatelessWidget {
  static Key retryButtonKey = UniqueKey();

  final void Function()? onRetry;
  final String? message;

  const OopsBox({
    Key? key,
    this.message,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: message ??
                      'The request cannot be completed. '
                          'Please double-check if you are '
                          'connected to the internet.',
                ),
              ),
            ),
            if (onRetry != null)
              ElevatedButton(
                key: retryButtonKey,
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
          ],
        ),
      ),
    );
  }
}
