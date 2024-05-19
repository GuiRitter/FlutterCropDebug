import 'dart:math' show min;

import 'package:flutter/material.dart'
    show
        BuildContext,
        CircularProgressIndicator,
        FutureBuilder,
        MaterialApp,
        Scaffold,
        StatelessWidget,
        Widget,
        debugPrint,
        runApp;
import 'package:flutter/material.dart' as material_widget;
import 'package:flutter/widgets.dart' show ConnectionState;
import 'package:image/image.dart' show copyCrop, decodeJpg;
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return const MaterialApp(
      title: 'Flutter Crop Debug',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: FutureBuilder<material_widget.Image>(
        future: getFuture(),
        builder: (
          context,
          snapshot,
        ) {
          if ((snapshot.connectionState == ConnectionState.done) &&
              (snapshot.data != null)) {
            return snapshot.data!;
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<material_widget.Image> getFuture() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photoFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    final photoImage = decodeJpg(
      await photoFile!.readAsBytes(),
    )!;

    final x = (photoImage.width > photoImage.height)
        ? ((photoImage.width - photoImage.height) ~/ 2)
        : 0;

    final y = (photoImage.height > photoImage.width)
        ? ((photoImage.height - photoImage.width) ~/ 2)
        : 0;

    final dimension = min(
      photoImage.width,
      photoImage.height,
    );

    final photoImageSquared = copyCrop(
      photoImage,
      x: x,
      y: y,
      width: dimension,
      height: dimension,
    );

    debugPrint('works up to here');

    return material_widget.Image.memory(
      photoImageSquared.getBytes(),
    );
  }
}
