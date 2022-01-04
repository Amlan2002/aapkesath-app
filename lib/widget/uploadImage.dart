import 'package:diabetes_app/screen/add_image.dart';
import 'package:diabetes_app/screen/myDocuments.dart';
import 'package:flutter/material.dart';
// import 'package:transparent_image/transparent_image.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: const Text('upload your data'),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 600,
                    color: Colors.amber,
                    child: AddImage(),
                  );
                });
          },
        ),
        ElevatedButton(
          child: const Text('My Uploaded Documents'),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 600,
                    color: Colors.amber,
                    child: MyDocuments(),
                  );
                });
          },
        ),
      ],
    );
  }
}
