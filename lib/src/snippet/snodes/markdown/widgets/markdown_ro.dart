import 'package:flutter/material.dart';
import 'package:markdown_editor_live/markdown_editor_live.dart';

class ReadOnlyMarkdown extends StatelessWidget {
  final String data;

  const ReadOnlyMarkdown(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Initialize the special markdown controller
    final controller = MarkdownEditingController(text: data);

    return TextField(
      controller: controller,
      readOnly: true, // 2. Set this to true to disable editing
      maxLines: null, // Allows the text to wrap and show multiple lines
      decoration: const InputDecoration(
        border: InputBorder.none, // Removes the input line for a "viewer" look
      ),
    );
  }
}
