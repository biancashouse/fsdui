import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/property_callout_button.dart';

/// Button that opens a callout for editing a reorderable list of strings
/// (e.g. PageViewNode.childSnippetNames).
///
/// Uses the app's callout/overlay system (`fsdui.showOverlay`, via
/// [PropertyCalloutButton]) rather than a plain Flutter `showDialog`.
/// `showDialog` pushes a route onto the shared root `Navigator`'s
/// `OverlayState`, but this app's callouts (and the properties side panel
/// itself) insert their `OverlayEntry`s directly into that same
/// `OverlayState` outside of Navigator's route bookkeeping — so a
/// `showDialog` route ends up layered *underneath* the already-open
/// property panel/callouts instead of on top of them.
class PropertyButtonStringList extends StatelessWidget {
  final CalloutId cId;
  final String label;
  final String? tooltip;
  final List<String> values;
  final ValueChanged<List<String>> onChangeF;
  final Size calloutButtonSize;
  final Size calloutSize;

  const PropertyButtonStringList({
    required this.cId,
    required this.label,
    this.tooltip,
    required this.values,
    required this.onChangeF,
    required this.calloutButtonSize,
    this.calloutSize = const Size(320, 400),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PropertyCalloutButton(
      cId: cId,
      label: values.isEmpty ? '$label...' : '$label (${values.length})',
      tooltip: tooltip,
      calloutButtonSize: calloutButtonSize,
      initialCalloutAlignment: Alignment.bottomCenter,
      initialTargetAlignment: Alignment.topCenter,
      calloutContents: (ctx) => _ReorderableStringListEditor(
        title: label,
        originalValues: values,
        onChangedF: onChangeF,
        onDoneF: () => fsdui.dismiss(cId),
      ),
      calloutSize: calloutSize,
    );
  }
}

class _Entry {
  static int _nextId = 0;
  final int id = _nextId++;
  String value;
  _Entry(this.value);
}

class _ReorderableStringListEditor extends HookWidget {
  final String title;
  final List<String> originalValues;
  final ValueChanged<List<String>> onChangedF;
  final VoidCallback onDoneF;

  const _ReorderableStringListEditor({
    required this.title,
    required this.originalValues,
    required this.onChangedF,
    required this.onDoneF,
  });

  @override
  Widget build(BuildContext context) {
    final entries = useState<List<_Entry>>(
      originalValues.map(_Entry.new).toList(),
    );

    void commit() => onChangedF(entries.value.map((e) => e.value).toList());

    void removeEntry(_Entry entry) {
      entries.value = entries.value.where((e) => e != entry).toList();
      commit();
    }

    void addEntry() {
      entries.value = [...entries.value, _Entry('')];
      commit();
    }

    void reorder(int oldIndex, int newIndex) {
      final list = [...entries.value];
      list.insert(newIndex, list.removeAt(oldIndex));
      entries.value = list;
      commit();
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            fsdui.coloredText(
              title,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: entries.value.isEmpty
                  ? Center(
                      child: fsdui.coloredText(
                        'no entries',
                        color: Colors.white70,
                      ),
                    )
                  : ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      itemCount: entries.value.length,
                      onReorderItem: reorder,
                      itemBuilder: (context, index) {
                        final entry = entries.value[index];
                        return _StringListRow(
                          key: ValueKey(entry.id),
                          index: index,
                          initialValue: entry.value,
                          // Per-keystroke: update the local value only. Do NOT
                          // propagate here — that would call refreshWithUpdate
                          // (and thus rebuild the snippet tree) on every
                          // character typed. Propagation happens on blur/
                          // submit/Done instead, same as StringPNode.
                          onLocalChangeF: (v) => entry.value = v,
                          onCommitF: commit,
                          onRemoveF: () => removeEntry(entry),
                        );
                      },
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: addEntry,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: fsdui.coloredText('add', color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    // flush any edit still in progress (focus loss may not
                    // have fired yet if the field never lost focus before
                    // this tap was handled)
                    commit();
                    onDoneF();
                  },
                  child: fsdui.coloredText(
                    'Done',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StringListRow extends HookWidget {
  final int index;
  final String initialValue;
  final ValueChanged<String> onLocalChangeF;
  final VoidCallback onCommitF;
  final VoidCallback onRemoveF;

  const _StringListRow({
    required this.index,
    required this.initialValue,
    required this.onLocalChangeF,
    required this.onCommitF,
    required this.onRemoveF,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    final focusNode = useFocusNode();

    useEffect(() {
      void listener() {
        if (!focusNode.hasFocus) onCommitF();
      }

      focusNode.addListener(listener);
      return () => focusNode.removeListener(listener);
    }, [focusNode]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.drag_handle, color: Colors.white70, size: 18),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 8,
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: onLocalChangeF,
              onSubmitted: (_) => onCommitF(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70, size: 18),
            tooltip: 'remove',
            visualDensity: VisualDensity.compact,
            onPressed: onRemoveF,
          ),
        ],
      ),
    );
  }
}
