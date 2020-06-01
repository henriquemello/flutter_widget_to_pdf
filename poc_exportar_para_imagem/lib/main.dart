import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:poc_exportar_para_imagem/visualizaPDF.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart' as material;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  File _imageFile;

  bool inside = false;
  Uint8List imageInMemory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget to PDF"),
      ),
      body: SingleChildScrollView(
        child: Screenshot(
          controller: screenshotController,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(height: 100, width: 100, color: Colors.green),
                Text('# 1:'),
                FlutterLogo(),
                Text('# 2:'),
                FlutterLogo(),
                Text('# 3:'),
                FlutterLogo(),
                Text('# 4:'),
                FlutterLogo(),
                Text('# 5:'),
                FlutterLogo(),
                Text('# 6:'),
                FlutterLogo(),
                Text('# 7:'),
                FlutterLogo(),
                Text('# 8:'),
                FlutterLogo(),
                Text('# 9:'),
                FlutterLogo(),
                Text('# 10:'),
                FlutterLogo(),
                Text('# 11:'),
                FlutterLogo(),
                Text('# 12:'),
                FlutterLogo(),
                Text('# 13:'),
                FlutterLogo(),
                Text('# 14:'),
                FlutterLogo(),
                Text('# 15:'),
                FlutterLogo(),
                Text('# 16:'),
                FlutterLogo(),
                Text('# 17:'),
                FlutterLogo(),
                Text('# 18:'),
                FlutterLogo(),
                Text('# 19:'),
                FlutterLogo(),
                Text('# 20:'),
                FlutterLogo(),
                Container(height: 100, width: 100, color: Colors.red),
                Text('########### FIM #############'),
                //_imageFile != null ? Image.file(_imageFile) : Container(),
                Container(),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _imageFile = null;
          print('Tira screenshot e armazena na variável FILE');
          screenshotController.capture().then((File imageFile) async {
            //print("Capture Done");
            setState(() {
              _imageFile = imageFile;
            });
            final result = imageFile.readAsBytesSync(); // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver

            print('Converte a imagem para PDF');
            final pdf = pw.Document();
            final image = PdfImage.file(
              pdf.document,
              bytes: result, //File('test.webp').readAsBytesSync(),
            );

            print('Adiciona a imagem ao arquivo PDF');
            pdf.addPage(pw.Page(build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image),
              ); // Center
            })); // Page

            print('Salva o arquivo local no dispositivo');
            final String diretorio = (await getApplicationDocumentsDirectory()).path;
            final String path = '$diretorio/report.pdf';
            final File arquivo = File(path);
            await arquivo.writeAsBytes(pdf.save());

            print('Navega para visualização');
            material.Navigator.of(context).push(
              material.MaterialPageRoute(
                builder: (_) => VisualizaPDF(path: path),
              ),
            );
          }).catchError((onError) {
            print(onError);
          });
        },
        
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Future<Uint8List> createImageFromWidget(Widget widget, {Duration wait, Size logicalSize, Size imageSize}) async {
  //   final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

  //   logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
  //   imageSize ??= ui.window.physicalSize;

  //   assert(logicalSize.aspectRatio == imageSize.aspectRatio);

  //   final RenderView renderView = RenderView(
  //     window: null,
  //     child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
  //     configuration: ViewConfiguration(
  //       size: logicalSize,
  //       devicePixelRatio: 1.0,
  //     ),
  //   );

  //   final PipelineOwner pipelineOwner = PipelineOwner();
  //   final BuildOwner buildOwner = BuildOwner();

  //   pipelineOwner.rootNode = renderView;
  //   renderView.prepareInitialFrame();

  //   final RenderObjectToWidgetElement<RenderBox> rootElement = RenderObjectToWidgetAdapter<RenderBox>(
  //     container: repaintBoundary,
  //     child: widget,
  //   ).attachToRenderTree(buildOwner);

  //   buildOwner.buildScope(rootElement);

  //   if (wait != null) {
  //     await Future.delayed(wait);
  //   }

  //   buildOwner.buildScope(rootElement);
  //   buildOwner.finalizeTree();

  //   pipelineOwner.flushLayout();
  //   pipelineOwner.flushCompositingBits();
  //   pipelineOwner.flushPaint();

  //   final ui.Image image = await repaintBoundary.toImage(pixelRatio: imageSize.width / logicalSize.width);
  //   final ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  //   return byteData.buffer.asUint8List();
  // }
}
