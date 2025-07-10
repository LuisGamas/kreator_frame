// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

class DataSourceImpl extends DataSource {
  final dio = Dio();

  // * Set wallpaper as home screen, lock screen, or both
  @override
  Future<bool> setWallpaper(String url, int location, Size size) async{
    final File? croppedImage = await _cropAndSaveImage(url, size);

    if (croppedImage != null) {
      bool result = await WallpaperManager.setWallpaperFromFile(croppedImage.path, location);
      return result;
    }
    return false;
  }

  // * Obtains a list of wallpapers from a remote API.
  @override
  Future<List<WallpaperEntity>> getListOfWallpapers() async {
    final response = await dio.get(Environment.userWallpapersUrl);
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
  Future<List<WidgetEntity>> getListOfWidgets(String filesExt, String thumbName) async {
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
      ByteData data = await rootBundle.load('android/app/src/main/assets/$folderAsset/$zipFileName');
      List<int> bytes = data.buffer.asUint8List();
      // Decode the .zip file
      Archive archive = ZipDecoder().decodeBytes(bytes);
      // Get preview image if it exists in the .zip file
      ArchiveFile? thumbFile = archive.firstWhere((file) => file.name == thumbName);

      // Uint8List thumbBytes = thumbFile.content as Uint8List;
      widgets.add(WidgetEntity(
        nameWidget: zipFileName.replaceAll('.$filesExt', ''),
        nameDeveloper: Environment.userDeveloperName,
        widgetThumbnail: thumbFile.content,
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
  Future<String> getOfficialData(String nameFolder, String nameFile) async {
    try {
      return await rootBundle.loadString('assets/$nameFolder/$nameFile');
    } catch (e) {
      throw Exception("Error loading file: $e");
    }
  }

  // * Obtains a list of licenses in the project
  @override
  Future<List<LicenseEntity>> getLicenses() async {
    try {
      final licenses = await LicenseRegistry.licenses.toList();
      final Map<String, List<String>> consolidatedLicenses = {};

      for (var license in licenses) {
        for (var packageName in license.packages) {
          final licenseContent = license.paragraphs.map((e) => e.text).join('\n\n');

          if (consolidatedLicenses.containsKey(packageName)) {
            consolidatedLicenses[packageName]?.add(licenseContent);
          } else {
            consolidatedLicenses[packageName] = [licenseContent];
          }
        }
      }

      final licenseEntities = consolidatedLicenses.entries.map((entry) =>
      LicenseMapper.dataToEntity(
        packageName: entry.key,
        licenses: entry.value,
      )).toList();

      licenseEntities.sort((a, b) => a.name.compareTo(b.name));
      return licenseEntities;
    } catch (e) {
      return [];
    }
  }

  // * Obtains a list of .zip files in the assets folder with a specified file extension.
  Future<List<String>> _listZipFiles(String filesExt) async {
    // Get the list of application assets
    List<String> assetList = await rootBundle
      .loadStructuredData<List<String>>('AssetManifest.json', (jsonStr) async {
        Map<String, dynamic> manifestMap = json.decode(jsonStr);
        return manifestMap.keys.toList();
      },
    );
    // Filter .zip files in the assets folder
    List<String> zipFiles = assetList.where((asset) => asset.endsWith('.$filesExt')).toList();
    // Remove path prefix and file extension
    zipFiles = zipFiles.map((zip) => zip.split('/').last).toList();
    return zipFiles;
  }

  Future<File?> _cropAndSaveImage(String imageUrl, Size screenSize) async {
    try {
      // 1. Upload the image from the URL
      final ByteData data = await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
      final Uint8List bytes = data.buffer.asUint8List();
      // 2. Decoding the image
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final ui.Image originalImage = frame.image;
      // 3. Get screen dimensions
      final screenWidth = screenSize.width;
      final screenHeight = screenSize.height;
      // 4. Crop the image while maintaining its proportion
      final originalWidth = originalImage.width;
      final originalHeight = originalImage.height;

      final screenAspectRatio = screenWidth / screenHeight;
      final imageAspectRatio = originalWidth / originalHeight;

      double cropWidth;
      double cropHeight;

      if (imageAspectRatio > screenAspectRatio) {
        // The image is wider than the screen, we adjust the width proportionally.
        cropHeight = originalHeight.toDouble();
        cropWidth = cropHeight * screenAspectRatio;
      } else {
        // The image is higher than the screen, we adjust the height proportionally.
        cropWidth = originalWidth.toDouble();
        cropHeight = cropWidth / screenAspectRatio;
      }

      final left = (originalWidth - cropWidth) / 2;
      final top = (originalHeight - cropHeight) / 2;
      final srcRect = Rect.fromLTWH(left, top, cropWidth, cropHeight);

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final dstRect = Rect.fromLTWH(0, 0, screenWidth, screenHeight);
      // 5. Draw the cut-out image on the canvas
      canvas.drawImageRect(originalImage, srcRect, dstRect, Paint());

      final picture = recorder.endRecording();
      final ui.Image croppedImage = await picture.toImage(screenWidth.toInt(), screenHeight.toInt());
      // 6. Convert cropped image to PNG bytes
      final ByteData? byteData = await croppedImage.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      // 7. Saving PNG bytes as a temporary file
      final directory = await getTemporaryDirectory();
      final String filePath = '${directory.path}/cropped_image.png';
      final File file = File(filePath);
      // 8. Write the bytes to the file
      await file.writeAsBytes(pngBytes);
      return file;
    } catch (e) {
      return null;
    }
  }
  
}
