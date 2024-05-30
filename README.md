<!------------------ [#####################] ------------------>
# Kreator Frame Dashboard

![GitHub License](https://img.shields.io/github/license/LuisGamas/kreator_frame?style=for-the-badge)	![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/LuisGamas/kreator_frame/total?style=for-the-badge)	[![FLUTTER](https://img.shields.io/badge/FLUTTER-FRAMEWORK-gray?labelColor=02569B&style=for-the-badge&logo=flutter)](https://flutter.dev/)  [![DART](https://img.shields.io/badge/DART-LANGUAGE-gray?labelColor=0175C2&style=for-the-badge&logo=dart/)](https://flutter.dev/)

Kreator Frame Dashboard is a Flutter-based project created to share your widget and wallpaper packs compatible with Kustom Apps (KWGT & KWLP) and share them on the Play Store.

This project is open source and ***still in beta phase***, possible bugs can be found but it means that they can be solved with proper identification of them.

I have developed Kreator Frame Dashboard solo, with a lot of effort and dedication, for all who wish to utilize it, provided they respect the rights established in the project's license. ***Users are welcome to contribute to its development, fostering a collaborative environment while upholding the rights outlined in the project's license.***


<!------------------ [#####################] ------------------>
# Support

If you like this project and want to support me to continue maintaining it or to extend, modify or update parts of it, consider sponsoring the cause, this project is for everyone and you can use it whenever you need it.

<a href="https://www.buymeacoffee.com/luisgamas"><img src="https://raw.githubusercontent.com/LuisGamas/buttons-design/main/buy-me-a-coffe.png" width="250" /></a>

<a href="https://www.paypal.com/donate/?hosted_button_id=NYCR5M6QHZ7JC"><img src="https://raw.githubusercontent.com/LuisGamas/buttons-design/main/paypal_donations.png" width="250" /></a>

***Thank you for your support, this is very important to me*** 🎉


<!------------------ [#####################] ------------------>
# Demo

You can try and use the **Kreator Frame Dashboard** app before you have to set up this whole project on your PC, consider downloading it directly from Google Play and leave your rating as it helps me improve my ratings and encourages me to continue with this work.

<a href='https://play.google.com/store/apps/details?id=io.github.luisgamas.kreator_frame&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width=250 /></a>


<!------------------ [#####################] ------------------>
# Installation and Setup

### Prerequisites:

 - Ensure you have Flutter and Dart installed on your system. If not, follow the official installation instructions [here](https://docs.flutter.dev/get-started/install).
 - Make sure you have an editor or IDE compatible with Flutter, either Visual Studio Code or its alternatives or Android Studio.


> [!NOTE]
> _I prefer to use Visual Studio Code so in these instructions you will find that I always mention this editor but you can use the IDE or editor of your choice._

### Importing into Visual Studio Code:

 - Clone or download the repository to your local machine.
 - Open Visual Studio Code.
 - Click on the "File" menu, then select "Open Folder" and choose the project folder.
 - Once the project is opened, you'll be prompted to get the dependencies. If not, you can manually run `flutter pub get` in the terminal within Visual Studio Code to update the project dependencies.

 > [!NOTE]
> If you are going to use the terminal to configure your project make sure you are in the correct path, something like this: C:\\...\\...\\...\\...\\...\\kreator_frame> 


<!------------------ [#####################] ------------------>
## Editing the Project

> [!TIP]
> _After each change you make be sure to save your progress, you can use CTRL + S to make or from your editor menu._


### Variables:

> [!IMPORTANT]
> Before starting the project you need to provide the environment variables, without this the project will not compile. Before starting the project it is necessary to provide the environment variables, without this the project will not compile. ***In case you don't want to add wallpapers to your app or any social network just change the link you see there for the word NA***.

#### JSON Example

To add the wallpapers you need to do it in a JSON format suitable for the project, for this you can use as an example this format

```
{
  "wallpapers": [
    {
      "name": "Fantasy Fall Nature Scenery with Small House and a Tree",
      "author": "Viktor Hanacek",
      "url": "https://i0.wp.com/picjumbo.com/wp-content/uploads/fantasy-fall-nature-scenery-with-small-house-and-a-tree-free-photo.jpg?w=2210&quality=100",
      "copyright": "Made with ♥ in 2013-2024 picjumbo, a project by Viktor Hanacek."
    },
    {
      "name": "Church of Saint John in Ranui, Italy Free Photo",
      "author": "Viktor Hanacek",
      "url": "https://i0.wp.com/picjumbo.com/wp-content/uploads/church-of-saint-john-in-ranui-italy-free-photo.jpg?w=2210&quality=100",
      "copyright": "Made with ♥ in 2013-2024 picjumbo, a project by Viktor Hanacek."
    }
  ]
}
```


 - Copy the `.env.template` file and paste into the same path
 - Rename the file to `.env`
 - Aggregates the required data in each variable
 - Go to -> `android/app/src/main/res/values/config.xml` and add your app data ***(This data is necessary for the Kustom Engine app to be able to display the name of your app and a short description)***


### Widgets

To add your widgets you need to have them already exported to a local or USB folder, the path where you should put your widgets is `android/app/src/main/assets/`

 - Inside the `widgets` folder you must add all your **.kwgt** files.
 - Inside the `wallpapers` folder you must add all your **.klwp** files.

> [!WARNING]
> ***If you are only going to add one of the two types of widgets then you should delete the widgets included in the project but keep the parent folder (`widgets` or `wallpapers`).***


### Change the name of the package:

By default the package name is `io.github.luisgamas.kreator_frame` but you must change this name to publish your app.

To change the package name you need to open the console of your choice and run the following command:
```
flutter pub run change_app_package_name:main com.new.package.name
```
Where ```com.new.package.name``` is the new package name that you want for your app, replace it with any name you want e.g. `com.developer.name`

> [!NOTE]
> More info -> https://pub.dev/packages/change_app_package_name


### Change the name of the app:

By default the name of the app (the name visible in the launcher) is `Kreator Frame`, this name must be changed in order to publish your app in the Google Play Store.

To change the name of the application you must execute the following command
> [!WARNING]
> Don't use a name that's too big or it could overwhelm the design of the app.
```
flutter pub run rename_app:main all="My App Name"
```
Where ```My App Name``` is the new name for the app

> [!NOTE]
> More info -> https://pub.dev/packages/rename_app


### Change the app icon

> [!IMPORTANT]
> I recommend using .png images for your app icons, this ensures good quality of the app icon.

By default the application needs 3 slightly different icons (512 x 512 px) to display them correctly both in the Google Play Store and in the phone launcher, these icons are located in the folder `assets/logo/`, ***for the app to take your icons correctly make sure you replace the existing icons with the new icons using exactly the same name.***

1. Replace the `app_logo.png` icon with your new icon, I recommend using a solid colour background, this will be used inside the app and will be visible every time you start the app.
2. Replace the `app_icon.png` icon with your new icon without background, this will be the basis for the icon displayed by the launcher. 
3. Go to -> https://icon.kitchen.
   - Change the icon type to **image** and select your icon without background.
   - Select and configure your icon to your liking and select **download**.
   - Go to your download directory and extract the compressed file with your new icon.
   - Go into the folder of the extracted file, then go into the **android** folder and replace the name of the **play_store_512** icon with **app_icon_foreground**.
4. Now you can replace the `app_icon_foreground.png` icon ***with your new icon***.

To change the application icon you must make sure you have the images correctly placed and named as indicated in previous steps, otherwise it will not come out as expected.

After setting up the configuration, all that is left to do is run the package.
```
flutter pub get
flutter pub run flutter_launcher_icons
```
> [!NOTE]
> More info -> https://docs.flutter.dev/deployment/android or -> https://pub.dev/packages/flutter_launcher_icons 


### Change the splash screen

To change the splash screen of the application you must make sure you have the logos and icons correctly placed and named as indicated in previous steps, otherwise it will not come out as expected.

Then you must run the following command:
```
dart run flutter_native_splash:create
```
> [!NOTE]
> more info -> https://pub.dev/packages/flutter_native_splash


### Running the Project:

> [!TIP]
> The easiest way to test the app is to open the `main.dart` file in `lib/` then press F5.

Before publishing your app you must verify that all the configuration has been done correctly, for that you can test your app in debug mode and verify that everything you just configured is according to what you require, to do this follow these steps:

 - Navigate to the project directory in the terminal within Visual Studio Code.
 - Run `flutter pub get` to ensure all dependencies are up to date.
 - **Testing on a Physical Device:**
   - ***Connect your device*** via USB and ensure USB debugging is enabled.
   - Run `flutter devices` in the terminal to ensure your device is detected.
   - Start the app with `flutter run`.
 - **Testing on a Virtual Device (Emulator):**
   - ***Open Android Studio*** and go to the ***AVD Manager***.
   - Create a new virtual device or select an existing one.
   - Start the virtual device.
   - Run `flutter devices` in the terminal to ensure your device is detected.
   - Start the app with `flutter run`.


### Build and release an Android app

The easiest way to sign our applications is using Android Studio, to do so, right click on the `android` folder and select "Open with Android Studio".

Now wait a moment for it to load the Android Studio components and you will be able to sign your App Bundle 

Here you can find an official tutorial on how to do it with Android Studio or directly from Visual Studio Code -> https://docs.flutter.dev/deployment/android#signing-the-app

## License

This project is licensed under the Mozilla Public License 2.0 (MPL 2.0). You can find the complete license text in the [LICENSE](LICENSE) file included in this repository.

    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/

<!------------------ [#####################] ------------------>