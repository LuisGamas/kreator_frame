# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

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
