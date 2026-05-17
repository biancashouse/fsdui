import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'widget_entry.dart';

const String kWidgetPickerCId = 'widget-picker';

sealed class _Item {}

class _Header extends _Item {
  _Header(this.label, this.color);
  final String label;
  final Color color;
}

class _EntryItem extends _Item {
  _EntryItem(this.entry);
  final WidgetEntry entry;
}

class _SnippetItem extends _Item {
  _SnippetItem(this.name);
  final String name;
}

/// Combined quick-pick chips + inline search panel.
/// Replaces the previous two-step quick→full flow.
class QuickPickPanel extends StatefulWidget {
  const QuickPickPanel({
    super.key,
    required this.action,
    required this.recommended,
    required this.candidates,
    required this.onTypeSelected,
    this.onSnippetSelected,
    this.snippetNames = const [],
    this.hasPaste = false,
    this.onPaste,
  });

  final NodeAction action;
  final List<WidgetEntry> recommended;
  final List<WidgetEntry> candidates;
  final void Function(Type type) onTypeSelected;
  final void Function(String snippetName)? onSnippetSelected;
  final List<String> snippetNames;
  final bool hasPaste;
  final VoidCallback? onPaste;

  @override
  State<QuickPickPanel> createState() => _QuickPickPanelState();
}

class _QuickPickPanelState extends State<QuickPickPanel> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<_Item> _buildItems() {
    final items = <_Item>[];
    if (_query.isEmpty) {
      final byCategory = <WidgetCategory, List<WidgetEntry>>{};
      for (final e in widget.candidates) {
        byCategory.putIfAbsent(e.category, () => []).add(e);
      }
      for (final cat in WidgetCategory.values) {
        final entries = byCategory[cat];
        if (entries == null || entries.isEmpty) continue;
        items.add(_Header(cat.displayName, cat.color));
        for (final e in entries) items.add(_EntryItem(e));
      }
      if (widget.snippetNames.isNotEmpty && widget.onSnippetSelected != null) {
        items.add(_Header('Snippets', WidgetCategory.snippet.color));
        for (final name in widget.snippetNames) items.add(_SnippetItem(name));
      }
    } else {
      final q = _query.toLowerCase();
      final matched = widget.candidates.where((e) => e.matches(_query)).toList()
        ..sort((a, b) {
          final aS = a.label.toLowerCase().startsWith(q) ? 0 : 1;
          final bS = b.label.toLowerCase().startsWith(q) ? 0 : 1;
          if (aS != bS) return aS - bS;
          return a.label.compareTo(b.label);
        });
      for (final e in matched) items.add(_EntryItem(e));
      if (widget.onSnippetSelected != null) {
        for (final name in widget.snippetNames.where(
          (s) => s.toLowerCase().contains(q),
        )) {
          items.add(_SnippetItem(name));
        }
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
          child: Row(
            children: [
              Text(
                widget.action.displayName,
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              if (widget.hasPaste && widget.onPaste != null)
                TextButton.icon(
                  onPressed: () {
                    fsdui.dismiss(kWidgetPickerCId);
                    widget.onPaste!();
                  },
                  icon: const Icon(Icons.paste, size: 14),
                  label: const Text('paste', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => fsdui.dismiss(kWidgetPickerCId),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        // Recommended chips (hidden while searching).
        if (_query.isEmpty && widget.recommended.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final entry in widget.recommended.take(5))
                  ActionChip(
                    label: Text(entry.label,
                        style: const TextStyle(fontSize: 13)),
                    backgroundColor:
                        entry.category.color.withValues(alpha: .35),
                    side: BorderSide.none,
                    onPressed: () {
                      fsdui.dismiss(kWidgetPickerCId);
                      widget.onTypeSelected(entry.type);
                    },
                  ),
              ],
            ),
          ),
        ],
        // Search field — stable key so Flutter reuses the element when the
        // chips section above is conditionally added/removed (which shifts
        // the Column slot index and would otherwise break focus).
        Padding(
          key: const ValueKey('widget-picker-search'),
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              hintText: 'Search widgets...',
              prefixIcon: Icon(Icons.search, size: 18),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        const Divider(height: 1),
        // Results list.
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is _Header) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                  color: item.color.withValues(alpha: .18),
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      letterSpacing: 0.8,
                    ),
                  ),
                );
              }
              if (item is _EntryItem) {
                final e = item.entry;
                return ListTile(
                  dense: true,
                  title: Text(e.label),
                  trailing: _query.isNotEmpty ? _CategoryBadge(e.category) : null,
                  onTap: () {
                    fsdui.dismiss(kWidgetPickerCId);
                    widget.onTypeSelected(e.type);
                  },
                );
              }
              if (item is _SnippetItem) {
                return ListTile(
                  dense: true,
                  leading: const Icon(Icons.widgets_outlined, size: 16),
                  title: Text(item.name),
                  onTap: () {
                    fsdui.dismiss(kWidgetPickerCId);
                    widget.onSnippetSelected?.call(item.name);
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge(this.category);
  final WidgetCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: category.color.withValues(alpha: .35),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        category.displayName,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
