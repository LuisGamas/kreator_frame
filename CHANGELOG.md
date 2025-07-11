# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [v1.4.0] - 2025-07-11

### Added
- In App Update now available thanks to flutter_upgrade_version library.

### Changed
- Set minifyEnabled and shrinkResources to false in android/app/build.gradle file to maintain Kustom API recommended settings.
- Changed package_info_plus library to flutter_upgrade_version and improved use of app data for internal handling.

## [v1.3.0] - 2025-07-10

### Added
- The new flutter_markdown_plus library now controls the view widget for texts of type md.

### Changed
- Updated dependencies to the latest compatible versions.
- Removed obsolete riverpods that handled Theme and Color control and now use a customized riverpod optimized for proper loading and reading control.
- flutter_markdown library was discontinued and changed to flutter_markdown_plus.
- Terms & Conditions and Privacy Policy are now accessed via external links to the personal website.
- Now the access to the data sources is through the repository controlled by a read riverpod, allowing a better management of instances and declarations.
- Migrated the license list loading to a stateful riverpod class for better optimization of license loading and caching.

## [v1.2.1] - 2025-04-19

### Changed
- Updated dependencies to the latest compatible versions.
- Changes in the process for applying wallpaper to the device.
- Minor changes in app design and user experience (UI && UX).

## [v1.1.0] - 2024-10-18

### Added
- Added request for user permission to save downloaded images to device A13+ & A13-.
- Added a loading indicator for image previews.

### Changed
- Updated dependencies to the latest compatible versions.
- Change ofifical datala (Terms & Conditions and Privacy Policy).
- Change of method for applying the centred wallpaper.
- Changes in the design and representation of OSS licenses.
- Change widget to display image from URL with cache and loader.

## [v1.0.5] - 2024-08-06

### Added
- Improved error handling and logging for better debugging.
- Enhanced documentation and comments for better code readability.
- Refactored AppColorThemeProvider to initialize theme color state using a private method (_updateColorTheme).
- Refactored AppThemeModeProvider to initialize theme mode state using a private method (_updateThemeFromStorage).

### Changed
- Updated dependencies to the latest compatible versions.
- Refactored widget layout to improve performance and responsiveness.
- Fixed issues with state management in specific scenarios.
- Improved error handling and logging for better debugging.
- Enhanced documentation and comments for better code readability.
- The build method in AppColorThemeProvider now calls _updateColorTheme to initialize the theme color state.
- The build method in AppThemeModeProvider now calls _updateThemeFromStorage to initialize the theme mode state.
- Removed unnecessary calls to update methods in MyApp's build method.
- Simplified MyApp's build method to directly use theme and color state from providers.

## [v1.0.4] - 2024-05-29

### Added
- Support for KWGT and KLWP widgets.
- Adaptive icon support on Android.
- Support for image downloads on Android 14.
- Coupling for separate data handling between dashboard, dashboard developer, and widget package developer.

>[!IMPORTANT]
> ***Older versions not available***
