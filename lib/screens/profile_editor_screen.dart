import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum ImageSourceType { gallery, camera }

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

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploader();
}

class _ImageUploader extends State<ImageUploader> {
  File? userImage;

  final _picker = ImagePicker();
  // Handling image picking/filepath. 
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        userImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
            // Opens image picker. 
              child: ElevatedButton(
                onPressed: () {
                  _openImagePicker();
                },
                child: const Text('Upload Image'),
              ),
            ),
          ]),
      ),
    );
  }
}

// class ImageUpload extends StatelessWidget {
//   const ImageUpload({
//     super.key,
//   });

//   @override 
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               ImagePicker();
//             }, 
//             child: const Text('Upload Image')
//             )
//         ],
//         )
//     );
//   }
// }


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
