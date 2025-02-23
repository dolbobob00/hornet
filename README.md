# Hornet - Anime Image Gallery App

A Flutter application that demonstrates clean architecture, SOLID principles, and BLoC pattern while fetching and displaying anime images.

## Features

- Fetch and display anime images from [waifu.im](https://waifu.im) API
- Support for both static images and GIFs
- Image source and upload date display
- Multiple images loading support
- Share + Download different type's of media 
- Tag-based image filtering
- Quotes feature using [API Ninjas](https://api-ninjas.com)
- Responsive UI with custom app bar and drawer
- Cached network images for better performance

## Architecture & Design Patterns

- Clean Architecture
- SOLID Principles
- BLoC Pattern for state management
- Service Locator Pattern (using get_it)
- Repository Pattern

## Dependencies

  bloc: ^9.0.0
  share_plus: ^10.1.4
  cached_network_image: ^3.3.0
  flutter_file_downloader: ^2.0.0
  dio: ^5.8.0+1
  flutter_bloc: ^9.0.0
  get_it: ^8.0.3
  go_router: ^14.8.0
  http: ^1.3.0
  path_provider: ^2.1.2
  url_launcher: ^6.3.1

## Getting Started

1. Clone the repository:
```bash
git clone https://your-repository-url.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Update API keys in `constants.dart` if needed

4. Run the app:
```bash
flutter run

```
