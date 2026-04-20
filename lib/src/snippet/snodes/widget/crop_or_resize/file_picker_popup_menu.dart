import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

import 'crop_image.dart';

class FilePickerPopupMenu extends StatefulWidget {
  const FilePickerPopupMenu({super.key});

  @override
  FilePickerPopupMenuState createState() => FilePickerPopupMenuState();
}

class FilePickerPopupMenuState extends State<FilePickerPopupMenu>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [fsdui.gap(50), ...getMenuItems()],
        ),
      ),
    );
  }

  List<Widget> getMenuItems() {
    List<Widget> menuItems = [];

    menuItems.add(
      // GALLERY
      Container(
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: TextButton.icon(
          onPressed: () async {
            pickImage(FileType.image, mounted: mounted);
          },
          label: fsdui.text16('pick from the image gallery'),
          icon: Icon(Icons.image, size: 28, color: Colors.purpleAccent),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            disabledForegroundColor: Colors.grey,
          ),
        ),
      ),
    );

    menuItems.add(
      // GALLERY
      Container(
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: TextButton.icon(
          onPressed: () async {
            pickImage(FileType.any, mounted: mounted);
          },
          label: fsdui.text16('pick from the file system'),
          icon: Icon(Icons.folder, size: 28, color: Colors.teal),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            disabledForegroundColor: Colors.grey,
          ),
        ),
      ),
    );

    return menuItems
        .map(
          (Widget mi) => Padding(padding: const EdgeInsets.all(8.0), child: mi),
        )
        .toList();
  }

  static Future<void> pickImage(FileType fType, {bool mounted = false}) async {
    fsdui.showCircularProgressIndicator(true, reason: 'Picking an Image');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: fType,
      withData: true,
    );
    fsdui.showCircularProgressIndicator(false, reason: 'Picking an Image');
    fsdui.showCircularProgressIndicator(true, reason: 'Picked an Image');
    if (result != null && result.files.isNotEmpty && mounted) {
      PlatformFile file = result.files.first;
      Uint8List? pickedFileBytes = file.bytes;
      if (pickedFileBytes != null && pickedFileBytes.lengthInBytes > 0) {
        ui.Image img = await fsdui.bytesToUiImage(file.bytes!);
        fsdui.logger.i(
          'actual size (${img.width} v ${img.height}) storage: ${file.bytes?.toList().length} bytes',
        );
        fsdui.dismissAll();
        await fsdui.zoomOrCropImage(
          originalImage: pickedFileBytes,
          calloutSize: Size(img.width.toDouble(), img.height.toDouble()),
          onImageChanged: (Uint8List? changedImage) {},
        );
      }
    }

    fsdui.showCircularProgressIndicator(false, reason: 'Picked an Image');
  }
}
