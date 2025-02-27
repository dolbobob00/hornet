# Hornet - Anime Image Gallery App

A Flutter application that demonstrates clean architecture, SOLID principles, and BLoC pattern while fetching and displaying anime images.

![Screenshot_2025-02-27-19-49-22-946_com example restful_solid_bloc](https://github.com/user-attachments/assets/f1b2ebb3-ead4-47b3-895a-714c11a26ced) ![Screenshot_2025-02-27-19-50-32-504_com example restful_solid_bloc](https://github.com/user-attachments/assets/3623ebab-2a56-417e-82e6-debbab97b2f4) ![Screenshot_2025-02-27-19-51-26-700_com example restful_solid_bloc](https://github.com/user-attachments/assets/cd166336-4114-4711-a7e1-4e3c658d81ab) ![Screenshot_2025-02-27-19-49-26-377_com example restful_solid_bloc](https://github.com/user-attachments/assets/6b881986-80b5-4e5d-8bc8-f3f0a448d456)

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

 - bloc: ^9.0.0
 - share_plus: ^10.1.4
 - cached_network_image: ^3.3.0
 - flutter_file_downloader: ^2.0.0
 - dio: ^5.8.0+1
 - flutter_bloc: ^9.0.0
 - get_it: ^8.0.3
 - go_router: ^14.8.0
 - http: ^1.3.0
 - path_provider: ^2.1.2
 - url_launcher: ^6.3.1

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/dolbobob00/hornet.git
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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Third-Party Licenses

This project uses the following APIs and services:
- [waifu.im](https://waifu.im) - Image content API
- [API Ninjas](https://api-ninjas.com) - Quotes API

Dependencies are licensed under their respective licenses:
- flutter_bloc: MIT License
- get_it: MIT License
- dio: MIT License
- cached_network_image: MIT License
- share_plus: BSD License
- url_launcher: BSD License
- path_provider: BSD License

### Disclaimer

This application contains NSFW content and is intended for mature audiences only.
All images are provided by third-party APIs and we do not claim ownership of any content displayed in the application.
=======
