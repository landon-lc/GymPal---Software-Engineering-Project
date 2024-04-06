import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileEditorScreen extends StatefulWidget {
  const ProfileEditorScreen ({super.key});

  @override 
  State<ProfileEditorScreen> createState() => _ProfileEditorScreen();
}

class _ProfileEditorScreen extends State<ProfileEditorScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              // Implement sub-screens.
              ImageUploader(),
              ProfileEditorBackButton(),
            ])
          )
        )
    );
  }
}

// Getting the users profile picture. Not database integreated yet. 
// Using code from https://flutterone.com/how-to-implement-an-image-picker-and-uploader-in-flutter/
class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override 
  State<ImageUploader> createState() => _ImageUploader();
}

class _ImageUploader extends State<ImageUploader> {
  File? userImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        userImage = File(pickedImage.path);
      }
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Editor'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (userImage != null)
                Image.file(
                  userImage!,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery), 
                child: const Text('Upload Image from Gallery'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera), 
                child: const Text('Use Camera')
              ),
            ]
          )
          )
      )
    );
  }
}

// Code for the profile editor back button. WILL BECOME SAVE BUTTON
class ProfileEditorBackButton extends StatelessWidget {
  const ProfileEditorBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfileScreen()));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('TAKE ME BACK RIGHT THIS INSTANT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ));
  }
}
