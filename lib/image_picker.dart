import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();

  return showModalBottomSheet<XFile?>(
    context: context,
    backgroundColor: Colors.black.withOpacity(0.9),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose Image Source",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading:
                    const Icon(Icons.camera_alt, color: Colors.greenAccent),
                title: const Text(
                  'Camera',
                  style: TextStyle(color: Colors.greenAccent),
                ),
                onTap: () async {
                  final picked =
                      await picker.pickImage(source: ImageSource.camera);
                  Navigator.pop(context, picked);
                },
              ),
              const Divider(color: Colors.greenAccent),
              ListTile(
                leading:
                    const Icon(Icons.photo_library, color: Colors.greenAccent),
                title: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.greenAccent),
                ),
                onTap: () async {
                  final picked =
                      await picker.pickImage(source: ImageSource.gallery);
                  Navigator.pop(context, picked);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
