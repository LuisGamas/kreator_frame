// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
// import 'package:image/image.dart' as img;
// import 'package:path_provider/path_provider.dart';
import 'package:tex_markdown/tex_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

class DataSourceImpl extends DataSource {
  final dio = Dio();

  // * Set wallpaper as  home screen, lock screen, or both
  @override
  Future<bool> setWallpaper(String url, int location, Size size) async{

    var file = await DefaultCacheManager().getSingleFile(url);

    /* Uint8List? croppedImage = await getCroppedImage(file, size);

    if (croppedImage != null) {
      try {
        // Save the cropped image in a temporary file
        File tempFile = await File('${(await getTemporaryDirectory()).path}/temp_image.png').writeAsBytes(croppedImage);

        // Set the cropped image as the wallpaper
        bool result = await WallpaperManager.setWallpaperFromFile(tempFile.path, location);

        return result;
      } catch (e) {
        print('Error when setting the wallpaper: $e');
        return false;
      }
    } else {
      return false;
    } */

    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    return result;
    
  }

  // * Obtains a list of wallpapers from a remote API.
  @override
  Future<List<WallpaperEntity>> getListOfWallpapers() async {
    final response = await dio.get(Environment.wallpapersUrl);
    final wallpaperModel = WallpaperModel.fromJson(response.data);

    final List<WallpaperEntity> wallpapersEntities = wallpaperModel.wallpapers
        .map((wallpaper) => WallpaperMapper.wallpapersToEntity(wallpaper))
        .toList();

    return wallpapersEntities;
  }

  // * Obtains a list of widgets from the assets folder.
  //
  // The method loads widget files from the assets folder based on the specified
  // file extension and thumbnail name. It decodes the zip files and extracts
  // the necessary information to create WidgetEntity objects.
  @override
  Future<List<WidgetEntity>> getListOfWidgets(
      String filesExt, String thumbName) async {
    List<WidgetEntity> widgets = [];
    String folderAsset = '';

    // Get list of .zip files in the assets folder
    List<String> zipFiles = await _listZipFiles(filesExt);

    if (filesExt == 'kwgt') {
      folderAsset = 'widgets';
    } else if (filesExt == 'klwp') {
      folderAsset = 'wallpapers';
    }

    for (String zipFileName in zipFiles) {
      ByteData data = await rootBundle
          .load('android/app/src/main/assets/$folderAsset/$zipFileName');
      List<int> bytes = data.buffer.asUint8List();

      // Decode the .zip file
      Archive archive = ZipDecoder().decodeBytes(bytes);

      // Get preview image if it exists in the .zip file
      ArchiveFile? thumbFile =
          archive.firstWhere((file) => file.name == thumbName);

      // Uint8List thumbBytes = thumbFile.content as Uint8List;
      widgets.add(WidgetEntity(
        nameWidget: zipFileName.replaceAll('.$filesExt', ''),
        nameDeveloper: Environment.developerName,
        widgetThumbnail: thumbFile.content as Uint8List,
      ));
    }

    return widgets;
  }

  // * Launch an external app from the url
  @override
  Future<void> launchExternalApp(String url) async{

    if (!await launchUrl(
      Uri.parse(url),
    )) {
      throw Exception('Could not launch your url');
    }
  }

  // * Obtains official data from the assets folder and renders it using TexMarkdown.
  @override
  FutureBuilder<String> getOfficialData(String nameFolder, String nameFile) {
    return FutureBuilder(
        future: rootBundle.loadString('assets/$nameFolder/$nameFile'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return TexMarkdown(
                snapshot.data.toString(),
              );
            } else if (snapshot.hasError) {
              return const Text('''Well isn't this embarrassing? We can't seem to find what you're looking for''');
            }
          }
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
  }

  // * Obtains a list of .zip files in the assets folder with a specified file extension.
  Future<List<String>> _listZipFiles(String filesExt) async {
    // Get the list of application assets
    List<String> assetList = await rootBundle.loadStructuredData<List<String>>(
      'AssetManifest.json',
      (jsonStr) async {
        Map<String, dynamic> manifestMap = json.decode(jsonStr);
        return manifestMap.keys.toList();
      },
    );

    // Filter .zip files in the assets folder
    List<String> zipFiles =
        assetList.where((asset) => asset.endsWith('.$filesExt')).toList();

    // Remove path prefix and file extension
    zipFiles = zipFiles.map((zip) => zip.split('/').last).toList();

    return zipFiles;
  }

  // Get the centred image from a file
  /* Future<Uint8List?> getCroppedImage(File file, Size size) async {
    try {
      // Read the archive
      Uint8List imageData = await file.readAsBytes();

      // Decoding the image using the image library
      img.Image image = img.decodeImage(imageData)!;

      // Calculate the dimensions of the cutout
      int width = size.width.toInt();
      int height = size.height.toInt();
      int x = (image.width - width) ~/ 2;
      int y = (image.height - height) ~/ 2; // 0

      // Recortar la imagen desde el centro
      img.Image croppedImage = img.copyCrop(image, x: x, y: y, width: width, height: height);
      // img.Image croppedImage = img.copyCrop(image, x: x, y: y, width: width, height: image.height);

      // Encode the cropped image back to byte format
      Uint8List croppedImageData = Uint8List.fromList(img.encodePng(croppedImage));

      return croppedImageData;
    } catch (e) {
      print('Error getting the image: $e');
      return null;
    }
  } */
  
}
