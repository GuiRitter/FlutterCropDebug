import 'package:flutter/material.dart'
    show
        BuildContext,
        CircularProgressIndicator,
        FutureBuilder,
        MaterialApp,
        Scaffold,
        StatelessWidget,
        Widget,
        runApp;
import 'package:flutter/material.dart' as material_widget;
import 'package:flutter/widgets.dart' show ConnectionState;
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

    return material_widget.Image.memory(
      await photoFile!.readAsBytes(),
    );
  }
}
