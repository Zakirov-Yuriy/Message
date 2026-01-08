import 'package:flutter/material.dart';

class AudioMessageWidget extends StatelessWidget {
  final String fileName;

  const AudioMessageWidget({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.play_arrow, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            fileName,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}