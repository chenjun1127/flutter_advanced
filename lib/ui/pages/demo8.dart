import 'dart:io';
import 'dart:typed_data';

import 'package:common_lib/common_lib.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class Demo8 extends StatefulWidget {
  const Demo8({Key? key}) : super(key: key);

  @override
  State<Demo8> createState() => _Demo8State();
}

class _Demo8State extends State<Demo8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path Io'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: downloadImg,
              child: const Text('存储网络图片'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: readFile,
              child: const Text('读取图片'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadImg() async {
    const String url = 'https://live.staticflickr.com/65535/51509388947_4b5b9a36a4_b.jpg';
    final http.Response response = await http.get(Uri.parse(url));
    // Uint8List t= t.bodyBytes;
    final String imageName = path.basenameWithoutExtension(url);
    JLogger.i("图片名称=====$imageName");
    final Directory appDir = await path_provider.getApplicationSupportDirectory();
    final String localPath = path.join(appDir.path, '$imageName.bmp');
    JLogger.i("存储路径=====$appDir");
    // Downloading
    final File imageFile = File(localPath);
    final img.Image? imageData = img.decodeImage(response.bodyBytes);
    final List<int> a = img.encodeBmp(imageData!);
    await imageFile.writeAsBytes(a);
  }

  Future<void> readFile() async {
    final Directory appDir = await path_provider.getApplicationSupportDirectory();
    final Uint8List imageData = await File(path.join(appDir.path, '51509388947_4b5b9a36a4_b.bmp')).readAsBytes();
    if (context.mounted) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '读取保存的图片',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                color: Theme.of(context).primaryColor,
                letterSpacing: 1.1,
              ),
            ),
            content: Image.memory(Uint8List.view(imageData.buffer)),
          );
        },
      );
    }
  }
}
