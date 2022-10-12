import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isHotExpandedProvider = StateProvider<bool>((ref) => false);

class HotStationsTitle extends ConsumerWidget {
  final VoidCallback? onExpanded;
  const HotStationsTitle({Key? key, this.onExpanded}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text.rich(TextSpan(
            text: 'Hot',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: ' stations',
                style: TextStyle(fontWeight: FontWeight.w100),
              ),
            ],
          )),
          TextButton(
            onPressed: () {
              ref.read(isHotExpandedProvider.notifier).state = true;
              onExpanded?.call();
            },
            child: const Text('See all'),
          ),
        ],
      ),
    );
  }
}
