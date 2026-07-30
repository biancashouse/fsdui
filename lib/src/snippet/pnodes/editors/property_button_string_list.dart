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
///
/// If [options] is provided, rows/the add button pick from that fixed set of
/// values (e.g. page snippet names) instead of free-text entry, via
/// [MenuAnchor]. [MenuAnchor]'s popup renders through [OverlayPortal]
/// (inserts directly into the nearest `Overlay`), not a `Navigator` route —
/// unlike `DropdownButton`/`PopupMenuButton`/`showMenu`, which would hit the
/// same underneath-the-callout problem `showDialog` does.
///
/// If [secondaryValues] is also provided, each row additionally shows a
/// free-text field for a value paired 1:1 (by index) with the primary entry
/// — e.g. a display title to go with each picked page snippet name. The
/// pairing is kept by holding both values on the same row entry, so add/
/// remove/reorder always move the pair together.
class PropertyButtonStringList extends StatelessWidget {
  final CalloutId cId;
  final String label;
  final String? tooltip;
  final List<String> values;
  final ValueChanged<List<String>> onChangeF;
  final Size calloutButtonSize;
  final Size calloutSize;
  final List<String>? options;
  final List<String>? secondaryValues;
  final ValueChanged<List<String>>? onSecondaryChangeF;
  final String? secondaryHintText;

  const PropertyButtonStringList({
    required this.cId,
    required this.label,
    this.tooltip,
    required this.values,
    required this.onChangeF,
    required this.calloutButtonSize,
    this.calloutSize = const Size(320, 400),
    this.options,
    this.secondaryValues,
    this.onSecondaryChangeF,
    this.secondaryHintText,
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
        options: options,
        originalSecondaryValues: secondaryValues,
        onSecondaryChangedF: onSecondaryChangeF,
        secondaryHintText: secondaryHintText,
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
  String secondary;
  _Entry(this.value, [this.secondary = '']);
}

class _ReorderableStringListEditor extends HookWidget {
  final String title;
  final List<String> originalValues;
  final List<String>? options;
  final List<String>? originalSecondaryValues;
  final ValueChanged<List<String>>? onSecondaryChangedF;
  final String? secondaryHintText;
  final ValueChanged<List<String>> onChangedF;
  final VoidCallback onDoneF;

  const _ReorderableStringListEditor({
    required this.title,
    required this.originalValues,
    required this.options,
    required this.originalSecondaryValues,
    required this.onSecondaryChangedF,
    required this.secondaryHintText,
    required this.onChangedF,
    required this.onDoneF,
  });

  @override
  Widget build(BuildContext context) {
    final hasSecondary = originalSecondaryValues != null;
    final entries = useState<List<_Entry>>([
      for (var i = 0; i < originalValues.length; i++)
        _Entry(
          originalValues[i],
          hasSecondary && i < originalSecondaryValues!.length
              ? originalSecondaryValues![i]
              : '',
        ),
    ]);

    void commit() {
      onChangedF(entries.value.map((e) => e.value).toList());
      onSecondaryChangedF?.call(entries.value.map((e) => e.secondary).toList());
    }

    void removeEntry(_Entry entry) {
      entries.value = entries.value.where((e) => e != entry).toList();
      commit();
    }

    void addEntry([String value = '']) {
      entries.value = [...entries.value, _Entry(value)];
      commit();
    }

    void reorder(int oldIndex, int newIndex) {
      final list = [...entries.value];
      list.insert(newIndex, list.removeAt(oldIndex));
      entries.value = list;
      commit();
    }

    // Options not already used by another row (a row keeps its own current
    // value in the list it's shown, via `keep`).
    List<String> availableOptions({String? keep}) {
      final used = entries.value.map((e) => e.value).toSet();
      return (options ?? const <String>[])
          .where((o) => o == keep || !used.contains(o))
          .toList();
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
                        return options != null
                            ? _StringListPickerRow(
                                key: ValueKey(entry.id),
                                index: index,
                                value: entry.value,
                                options: availableOptions(keep: entry.value),
                                onSelectedF: (v) {
                                  entry.value = v;
                                  commit();
                                },
                                onRemoveF: () => removeEntry(entry),
                                secondaryValue:
                                    hasSecondary ? entry.secondary : null,
                                secondaryHintText: secondaryHintText,
                                onSecondaryLocalChangeF:
                                    (v) => entry.secondary = v,
                                onSecondaryCommitF: commit,
                              )
                            : _StringListTextRow(
                                key: ValueKey(entry.id),
                                index: index,
                                initialValue: entry.value,
                                // Per-keystroke: update the local value only.
                                // Do NOT propagate here — that would call
                                // refreshWithUpdate (and thus rebuild the
                                // snippet tree) on every character typed.
                                // Propagation happens on blur/submit/Done
                                // instead, same as StringPNode.
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
                if (options != null)
                  _AddFromOptionsButton(
                    options: availableOptions(),
                    onSelectedF: addEntry,
                  )
                else
                  TextButton.icon(
                    onPressed: () => addEntry(),
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

class _StringListTextRow extends HookWidget {
  final int index;
  final String initialValue;
  final ValueChanged<String> onLocalChangeF;
  final VoidCallback onCommitF;
  final VoidCallback onRemoveF;

  const _StringListTextRow({
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

class _StringListPickerRow extends StatefulWidget {
  final int index;
  final String value;
  final List<String> options;
  final ValueChanged<String> onSelectedF;
  final VoidCallback onRemoveF;

  // Optional paired free-text value (e.g. a display title for this entry's
  // picked snippet name). Null disables the secondary field for this row.
  final String? secondaryValue;
  final String? secondaryHintText;
  final ValueChanged<String>? onSecondaryLocalChangeF;
  final VoidCallback? onSecondaryCommitF;

  const _StringListPickerRow({
    required this.index,
    required this.value,
    required this.options,
    required this.onSelectedF,
    required this.onRemoveF,
    this.secondaryValue,
    this.secondaryHintText,
    this.onSecondaryLocalChangeF,
    this.onSecondaryCommitF,
    super.key,
  });

  @override
  State<_StringListPickerRow> createState() => _StringListPickerRowState();
}

class _StringListPickerRowState extends State<_StringListPickerRow> {
  final _menuController = MenuController();
  TextEditingController? _secondaryController;
  FocusNode? _secondaryFocusNode;

  @override
  void initState() {
    super.initState();
    if (widget.secondaryValue != null) {
      _secondaryController = TextEditingController(text: widget.secondaryValue);
      _secondaryFocusNode = FocusNode()
        ..addListener(() {
          if (_secondaryFocusNode!.hasFocus) return;
          widget.onSecondaryCommitF?.call();
        });
    }
  }

  @override
  void dispose() {
    _secondaryController?.dispose();
    _secondaryFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: widget.index,
            child: const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.drag_handle, color: Colors.white70, size: 18),
            ),
          ),
          Expanded(
            flex: _secondaryController != null ? 3 : 5,
            child: MenuAnchor(
              controller: _menuController,
              menuChildren: [
                for (final o in widget.options)
                  MenuItemButton(
                    onPressed: () => widget.onSelectedF(o),
                    child: Text(o),
                  ),
                if (widget.options.isEmpty)
                  const MenuItemButton(
                    onPressed: null,
                    child: Text('no other pages available'),
                  ),
              ],
              builder: (context, controller, child) => Material(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () =>
                      controller.isOpen ? controller.close() : controller.open(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.value.isEmpty ? 'select...' : widget.value,
                            style: TextStyle(
                              color: widget.value.isEmpty
                                  ? Colors.white54
                                  : Colors.white,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white70),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_secondaryController != null) ...[
            const SizedBox(width: 6),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _secondaryController,
                focusNode: _secondaryFocusNode,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.secondaryHintText,
                  hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: widget.onSecondaryLocalChangeF,
                onSubmitted: (_) => widget.onSecondaryCommitF?.call(),
              ),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70, size: 18),
            tooltip: 'remove',
            visualDensity: VisualDensity.compact,
            onPressed: widget.onRemoveF,
          ),
        ],
      ),
    );
  }
}

class _AddFromOptionsButton extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onSelectedF;

  const _AddFromOptionsButton({
    required this.options,
    required this.onSelectedF,
  });

  @override
  State<_AddFromOptionsButton> createState() => _AddFromOptionsButtonState();
}

class _AddFromOptionsButtonState extends State<_AddFromOptionsButton> {
  final _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    final disabled = widget.options.isEmpty;
    return MenuAnchor(
      controller: _menuController,
      menuChildren: [
        for (final o in widget.options)
          MenuItemButton(
            onPressed: () => widget.onSelectedF(o),
            child: Text(o),
          ),
      ],
      builder: (context, controller, child) => TextButton.icon(
        onPressed: disabled
            ? null
            : () => controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.add, color: Colors.white),
        label: fsdui.coloredText(
          disabled ? 'no more pages' : 'add',
          color: Colors.white,
        ),
      ),
    );
  }
}
