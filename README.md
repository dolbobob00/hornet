
# Hornet - Anime Image Gallery App

## Few screenshots. See all at bottom of readme
![Screenshot_3](https://github.com/user-attachments/assets/d1efb27d-91d3-4872-bde0-f888e33c7d25) ![Screenshot_2](https://github.com/user-attachments/assets/0fcf7e7d-f7cf-4529-a4e6-153586f9a967) ![1000145542](https://github.com/user-attachments/assets/815dfe4a-d0a2-435f-b6d4-71eede3d8abc)

## Overview
Hornet is a sophisticated Flutter application for browsing anime images, demonstrating modern Flutter development practices, clean architecture, and robust state management.





## Features

### Core Functionality
- Dynamic image fetching from multiple APIs (waifu.im, rule34)
- NSFW/SFW content toggle with animated transitions
- Cached image loading for better performance
- Multi-tag search functionality
- Random image generator
- Category-based browsing
- Last viewed content tracking
- Functionall sharing
- Uri launcher (when tap on url of image)
- Fullscreen image when tapped

### UI/UX Features
- Custom animated app bar with profile avatar
- Intelligent search with suggestions overlay
- Smooth transitions and animations
- Category carousel with cached previews
- Responsive layout adapting to different screen sizes
- Custom loading indicators
- Error handling with user-friendly messages

### Technical Features
- BLoC pattern for state management
- Dependency injection using GetIt
- Local storage with Hive
- Clean Architecture implementation
- SOLID principles adherence
- Custom network client abstraction
- Image caching system
- Route management with GoRouter

## Architecture

### Layer Organization
```
lib/
├── src/
│   ├── constants/
│   ├── data/
│   │   └── repositories/
│   ├── domain/
│   ├── presentation/
│   │   ├── cubit/
│   │   └── pages/
│   ├── routes/
│   └── theme/
└── widgets/
    ├── animations/
    ├── appbar/
    ├── search_field/
    └── top_categories/
```

### Key Components
- **Repositories**: Handle data fetching and caching
- **Cubits**: Manage state and business logic
- **UI Components**: Reusable widgets and screens
- **Services**: Handle dependencies and configurations

## Dependencies
```yaml
dependencies:
  bloc: ^9.0.0
  cached_network_image: ^3.3.1
  dio: ^5.8.0+1
  flutter_bloc: ^9.0.0
  get_it: ^8.0.3
  go_router: ^14.8.0
  hive_flutter: ^1.1.0
  // ...other dependencies
```

## State Management
The app uses BLoC pattern through flutter_bloc with the following key features:
- AnimationsCubit: Handles UI animations
- AnimePicsCubit: Manages image fetching and display
- AnimeInfoCubit: Handles category and tag information

## Navigation
Uses GoRouter for declarative routing with custom transitions:
- Fade transitions for modal pages
- Slide transitions for main navigation
- Scale transitions for details pages

## UI Components
- Custom AppBar with animated icons
- Cached network images with loading states
- Animated containers and transitions
- Custom search field with suggestions
- Category carousel with cached images

## Storage
- Hive for local storage
- Cached network images for media
- GetIt for dependency injection
- Custom repository implementations

## Styling
- Custom color schemes
- Typography system with Ubuntu font
- Consistent spacing and sizing
- Gradient backgrounds
- Custom animations

## Performance Optimizations
- Image caching
- Lazy loading
- Widget rebuilding optimization
- State management efficiency
- Network request optimization

## Contributing
Contributions are welcome!

## License
This project is licensed under the MIT License.

## Screenshots
[click on me to see all screenshots of app](https://imgur.com/a/bNtHoFH)

## Credits
- APIs used:
  - waifu.im
  - rule34 API
