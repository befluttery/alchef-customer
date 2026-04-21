import 'package:alchef/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadOptions extends StatelessWidget {
  const ImageUploadOptions({super.key, required this.onSelectImage});

  final Function(String selectedImagePath) onSelectImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Upload Method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 24),
          ListTile(
            leading: Icon(
              Icons.camera_alt,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              chooseImage(context, isCamera: true);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.image,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Choose Image'),
            onTap: () {
              Navigator.pop(context);
              chooseImage(context, isCamera: false);
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> chooseImage(
    BuildContext context, {
    required bool isCamera,
  }) async {
    try {
      final image = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );

      if (image != null) {
        onSelectImage(image.path);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (context.mounted) {
        if (isCamera) {
          UiHelper.showCameraRestrictedAlert(context);
        } else {
          UiHelper.showGalleryRestrictedAlert(context);
        }
      }
    } catch (e) {
      //
    }
  }
}
