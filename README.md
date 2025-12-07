# Magic Slide - Project Documentation

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Core Features](#core-features)
- [Code Explanation](#code-explanation)
- [Setup \u0026 Configuration](#setup--configuration)
- [Dependencies](#dependencies)

---

## Project Overview

**Magic Slide** is a cross-platform Flutter application that generates PowerPoint presentations automatically using AI. The app integrates with a presentation generation API and provides a comprehensive user interface for customizing presentation parameters, viewing generated PDFs, and managing user authentication.

### Key Capabilities
- 🎨 **AI-Powered Presentation Generation** - Create presentations from topics using GPT models
- 🔐 **User Authentication** - Secure email/password authentication via Supabase
- 📄 **PDF Viewing** - Built-in PDF viewer with download functionality
- 🌓 **Theme Support** - Dynamic light/dark mode switching
- 🎯 **Customizable Options** - Language, model selection, watermarks, and more

---

## 📱 Screenshots

<table>
  <tr>
    <td align="center">
      <img src="Home Light.png" alt="Home Screen Light Mode" width="250"/><br/>
      <b>Home Screen - Light Mode</b>
    </td>
    <td align="center">
      <img src="Home Dark.png" alt="Home Screen Dark Mode" width="250"/><br/>
      <b>Home Screen - Dark Mode</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="Pdf Light.png" alt="PDF Viewer" width="250"/><br/>
      <b>PDF Viewer</b>
    </td>
    <td align="center">
      <img src="Login with Error.png" alt="Login with Validation" width="250"/><br/>
      <b>Login with Validation</b>
    </td>
  </tr>
</table>

---

## 📥 Download

### Android APK
Download the latest release APK to install on your Android device:

**[Download Magic Slide APK](app-release.apk)** (86.9 MB)

> **Note**: You may need to enable "Install from Unknown Sources" in your Android device settings to install the APK.

---

## Architecture

Magic Slide follows a **clean architecture** pattern with clear separation of concerns:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (UI Screens, Widgets, Navigation)      │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│           Domain Layer                  │
│  (Models, Repository Interfaces)        │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│            Data Layer                   │
│  (API Services, Controllers, Models)    │
└─────────────────────────────────────────┘
```

### Architecture Principles
- **Separation of Concerns**: Feature-based module organization
- **Dependency Injection**: Services instantiated where needed
- **Repository Pattern**: Abstract data sources through interfaces
- **State Management**: StatefulWidget with controller pattern

---

## Folder Structure

```
magic_slide/
│
├── lib/
│   ├── main.dart                          # Application entry point
│   │
│   ├── core/                              # Core utilities and shared resources
│   │   ├── config/
│   │   │   └── supabase_config.dart       # Supabase client configuration
│   │   │
│   │   ├── constants/
│   │   │   ├── dir.dart                   # Directory and asset paths
│   │   │   └── user_info.dart             # User session data
│   │   │
│   │   └── helper/
│   │       ├── pref_services.dart         # SharedPreferences wrapper
│   │       ├── route_handler.dart         # Navigation utilities
│   │       ├── route_helper.dart          # GoRouter configuration
│   │       ├── route_name.dart            # Route name constants
│   │       └── theme_manager.dart         # Theme state management
│   │
│   ├── feature/                           # Feature modules
│   │   │
│   │   ├── login_signup/                  # Authentication feature
│   │   │   ├── data/
│   │   │   │   └── auth_controller.dart   # Auth business logic
│   │   │   ├── login_screen.dart          # Login UI
│   │   │   ├── signup_screen.dart         # Sign up UI
│   │   │   └── forgot_password_screen.dart # Password reset UI
│   │   │
│   │   ├── home_page/                     # Presentation generation feature
│   │   │   ├── data/
│   │   │   │   ├── model/
│   │   │   │   │   ├── generate_input_model.dart     # API request model
│   │   │   │   │   ├── generate_response_model.dart  # API response model
│   │   │   │   │   └── watermark_model.dart          # Watermark configuration
│   │   │   │   └── repository/
│   │   │   │       └── presentation_api_service.dart # API implementation
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   └── repository/
│   │   │   │       └── presentation_api.dart         # API interface
│   │   │   │
│   │   │   └── home_screen.dart           # Main presentation form UI
│   │   │
│   │   └── pdf_viewer/                    # PDF viewing feature
│   │       ├── data/
│   │       │   ├── model/
│   │       │   │   └── pdf_download_res_model_imp.dart # Download response
│   │       │   └── repository/
│   │       │       └── pdf_download_service.dart     # PDF download logic
│   │       │
│   │       ├── domain/
│   │       │   ├── model/
│   │       │   │   └── pdf_download_res_model.dart   # Download interface
│   │       │   └── repository/
│   │       │       └── pdf_download_repo.dart        # Repository interface
│   │       │
│   │       └── presentation/
│   │           └── pdf_viewer_screen.dart  # PDF viewer UI
│   │
│   └── presentation/
│       └── splash_screen.dart             # Initial splash screen
│
├── android/                               # Android platform code
├── ios/                                   # iOS platform code
├── linux/                                 # Linux platform code
├── macos/                                 # macOS platform code
├── web/                                   # Web platform code
├── windows/                               # Windows platform code
│
├── test/                                  # Unit and widget tests
│
├── pubspec.yaml                           # Dependencies configuration
├── analysis_options.yaml                  # Lint rules
├── README.md                              # Basic project info
├── API_INTEGRATION.md                     # API integration guide
└── SUPABASE_SETUP.md                      # Authentication setup guide
```

---

## Core Features

### 1. Authentication System

#### Files
- `lib/core/config/supabase_config.dart`
- `lib/feature/login_signup/data/auth_controller.dart`
- `lib/feature/login_signup/login_screen.dart`
- `lib/feature/login_signup/signup_screen.dart`
- `lib/feature/login_signup/forgot_password_screen.dart`

#### Functionality
The authentication system is powered by **Supabase** and provides:

**Sign Up**
```dart
await authController.signUp(email: email, password: password);
```
- Creates new user account
- Validates email format and password strength
- Stores user session in SharedPreferences

**Sign In**
```dart
await authController.signIn(email: email, password: password);
```
- Authenticates user credentials
- Persists login state locally
- Navigates to home screen on success

**Sign Out**
```dart
await authController.signOut();
```
- Clears user session
- Removes local preferences
- Returns to login screen

**Password Reset**
```dart
await authController.resetPassword(email: email);
```
- Sends password reset email via Supabase
- Secure email-based recovery

#### Error Handling
The `AuthController._handleAuthException()` method provides user-friendly error messages:
- Invalid credentials → "Invalid email or password"
- Unverified email → "Please verify your email address"
- Duplicate account → "An account with this email already exists"

---

### 2. Presentation Generator

#### Files
- `lib/feature/home_page/home_screen.dart`
- `lib/feature/home_page/data/repository/presentation_api_service.dart`
- `lib/feature/home_page/data/model/generate_input_model.dart`
- `lib/feature/home_page/data/model/generate_response_model.dart`
- `lib/feature/home_page/data/model/watermark_model.dart`

#### Functionality

The home screen is the core of the application, allowing users to generate presentations with extensive customization:

**User Input Fields**
1. **Topic** (Required) - Main subject of the presentation
2. **Email** (Auto-filled from user session)
3. **Mode** - Default or Editable presentation
4. **Language** - English or Arabic
5. **AI Model** - gpt-4, gpt-4o, gpt-4o-mini
6. **Presentation For** - Student, Teacher, or Business audience
7. **Slide Count** - Number of slides to generate
8. **Watermark Settings**:
   - Width and height (default: 48px)
   - Brand URL for logo
   - Position (TopRight, TopLeft, BottomRight, BottomLeft)

**Toggle Options**
- AI Images - Use AI-generated images
- Image on Each Page - Add images to every slide
- Google Image - Use Google Images
- Google Text - Use Google for content enhancement

**API Integration**

The `PresentationApiService` sends HTTP POST requests to the presentation API:

```dart
Future\u003cGenerateResponseModel\u003e generatePresentation(GenerateInputModel input) async {
  final url = Uri.parse('$baseUrl$generateEndpoint');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(input.toJson()),
  );
  
  if (response.statusCode == 200) {
    return GenerateResponseModel.fromJson(jsonDecode(response.body));
  } else {
    // Error handling
  }
}
```

**Request Flow**
1. User fills form and clicks "Generate"
2. Validation checks for required fields
3. `GenerateInputModel` created with all parameters
4. API call made via `PresentationApiService`
5. Loading indicator shown during request
6. On success: Shows dialog with presentation URL
7. On error: Shows error message via SnackBar

**Hardcoded Fallback**
The app includes a fallback mechanism for testing:
```dart
if (response.message.toLowerCase().contains("something is missing.")) {
  // Navigate to PDF viewer with sample PDF
  RouteHandler.navigateToNext(
    RouteName.pdfViewer,
    extra: "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
  );
}
```

---

### 3. PDF Viewer

#### Files
- `lib/feature/pdf_viewer/presentation/pdf_viewer_screen.dart`
- `lib/feature/pdf_viewer/data/repository/pdf_download_service.dart`

#### Functionality

**Viewing PDFs**
The PDF viewer uses `syncfusion_flutter_pdfviewer` to display presentations:

```dart
SfPdfViewer.network(pdfUrl)
```

Features:
- Network-based PDF loading
- Zoom and pan controls
- Page navigation
- Annotated viewing

**Download Functionality**
```dart
await PdfDownloadService().downloadPdf(pdfUrl)
```

The download service:
1. Fetches PDF from network URL
2. Saves to device's download directory
3. Returns file path on success
4. Shows confirmation SnackBar

---

### 4. Navigation \u0026 Routing

#### Files
- `lib/core/helper/route_helper.dart`
- `lib/core/helper/route_handler.dart`
- `lib/core/helper/route_name.dart`

#### Functionality

**GoRouter Configuration**

The app uses `go_router` for declarative routing:

```dart
static final router = GoRouter(
  initialLocation: RouteName.splash,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(path: RouteName.splash, builder: (context, state) =\u003e SplashScreen()),
    GoRoute(path: RouteName.home, builder: (context, state) =\u003e HomeScreen()),
    GoRoute(path: RouteName.login, builder: (context, state) =\u003e LoginScreen()),
    GoRoute(path: RouteName.signup, builder: (context, state) =\u003e SignUpScreen()),
    GoRoute(path: RouteName.forgotPassword, builder: (context, state) =\u003e ForgotPasswordScreen()),
    GoRoute(
      path: RouteName.pdfViewer,
      builder: (context, state) =\u003e PdfViewerScreen(pdfUrl: state.extra as String),
    ),
  ],
);
```

**Route Handler Utilities**

```dart
// Navigate to named route
RouteHandler.navigateTo(RouteName.home);

// Navigate with data
RouteHandler.navigateToNext(RouteName.pdfViewer, extra: pdfUrl);

// Go back
RouteHandler.pop();
```

---

### 5. Theme Management

#### Files
- `lib/core/helper/theme_manager.dart`

#### Functionality

The theme manager is a `ChangeNotifier` that controls app-wide theming:

```dart
class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  bool get isDarkMode =\u003e _themeMode == ThemeMode.dark;
  
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
```

**Integration**

```dart
// In main.dart
AnimatedBuilder(
  animation: themeManager,
  builder: (context, _) {
    final theme = themeManager.isDarkMode ? FThemes.zinc.dark : FThemes.zinc.light;
    return MaterialApp.router(
      theme: theme.toApproximateMaterialTheme(),
      themeMode: themeManager.themeMode,
      // ...
    );
  },
)
```

**User Control**

Home screen includes theme toggle button:
```dart
IconButton(
  icon: Icon(
    Theme.of(context).brightness == Brightness.light
        ? Icons.dark_mode
        : Icons.light_mode,
  ),
  onPressed: _toggleTheme,
)
```

---

### 6. Splash Screen \u0026 Session Management

#### Files
- `lib/presentation/splash_screen.dart`
- `lib/core/helper/pref_services.dart`
- `lib/core/constants/user_info.dart`

#### Functionality

**Splash Screen Flow**

```dart
Timer(const Duration(seconds: 2), () async {
  final isLoggedIn = await PrefServices.instance.isLoggedIn();
  UserInfo.email = await PrefServices.instance.getUserEmail() ?? '';
  UserInfo.uid = await PrefServices.instance.getUserUid() ?? '';
  
  if (isLoggedIn) {
    RouteHandler.navigateTo(RouteName.home);
  } else {
    RouteHandler.navigateTo(RouteName.login);
  }
});
```

**Session Persistence**

The app uses `SharedPreferences` to persist user session:
- `isLoggedIn` - Boolean login state
- `userEmail` - User's email address
- `userUid` - User's unique identifier

**PrefServices Wrapper**

```dart
class PrefServices {
  static final PrefServices instance = PrefServices._internal();
  
  Future\u003cbool\u003e isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
  
  Future\u003cvoid\u003e setIsLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }
  
  // Similar methods for email and uid
}
```

---

## Code Explanation

### Application Entry Point

**File**: `lib/main.dart`

```dart
Future\u003cvoid\u003e main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase client
  await SupabaseConfig.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeManager,
      builder: (context, _) {
        final theme = themeManager.isDarkMode 
            ? FThemes.zinc.dark 
            : FThemes.zinc.light;
            
        return MaterialApp.router(
          title: 'Magic Slide',
          routerConfig: RouteHelper.router,
          theme: theme.toApproximateMaterialTheme(),
          darkTheme: FThemes.zinc.dark.toApproximateMaterialTheme(),
          themeMode: themeManager.themeMode,
        );
      },
    );
  }
}
```

**Key Points**:
1. `ensureInitialized()` - Required before async operations in main
2. `SupabaseConfig.initialize()` - Sets up authentication backend
3. `AnimatedBuilder` - Rebuilds UI when theme changes
4. `MaterialApp.router` - Uses GoRouter for navigation

---

### Data Models

#### GenerateInputModel

**File**: `lib/feature/home_page/data/model/generate_input_model.dart`

This model structures all user inputs for the API request:

```dart
class GenerateInputModel {
  final String topic;
  final String extraInfoSource;
  final String email;
  final String accessId;
  final String template;
  final String language;
  final int slideCount;
  final bool aiImages;
  final bool imageForEachSlide;
  final bool googleImage;
  final bool googleText;
  final String model;
  final String presentationFor;
  final WatermarkModel watermark;
  
  Map\u003cString, dynamic\u003e toJson() {
    return {
      'topic': topic,
      'extraInfoSource': extraInfoSource,
      'email': email,
      'accessId': accessId,
      'template': template,
      'language': language,
      'slideCount': slideCount,
      'aiImages': aiImages,
      'imageForEachSlide': imageForEachSlide,
      'googleImage': googleImage,
      'googleText': googleText,
      'model': model,
      'presentationFor': presentationFor,
      'watermark': watermark.toJson(),
    };
  }
}
```

**Usage**:
```dart
final inputModel = GenerateInputModel(
  topic: _controller.text,
  email: UserInfo.email,
  language: selectedLanguage,
  slideCount: int.tryParse(_pageController.text) ?? 10,
  // ... other fields
  watermark: watermark,
);

final response = await _apiService.generatePresentation(inputModel);
```

---

### UI Components

The app uses **Forui** UI library for consistent, beautiful components:

**Text Fields**
```dart
FTextField(
  controller: _controller,
  label: const Text('Topic'),
  hint: 'Enter your topic',
  minLines: 5,
  maxLines: 10,
)
```

**Select Menus**
```dart
FSelectMenuTile.fromMap(
  const {'English': 'en', 'Arabic': 'ar'},
  initialValue: 'en',
  title: const Text('Language'),
  detailsBuilder: (_, values, _) =\u003e Text(
    values.firstOrNull == 'en' ? 'English' : 'Arabic'
  ),
)
```

**Switches**
```dart
FSwitch(
  label: const Text('AI Image'),
  value: aiImage,
  onChange: (value) =\u003e setState(() =\u003e aiImage = value),
)
```

**Buttons**
```dart
FButton(
  onPress: _generatePresentation,
  child: const Text('Generate'),
)
```

---

## Setup \u0026 Configuration

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK
- Supabase account
- Code editor (VS Code, Android Studio, etc.)

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone \u003crepository-url\u003e
   cd magic_slide
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   
   a. Create a Supabase project at [app.supabase.com](https://app.supabase.com)
   
   b. Get your credentials:
      - Navigate to Settings → API
      - Copy Project URL and Anon key
   
   c. Update `lib/core/config/supabase_config.dart`:
   ```dart
   static const String supabaseUrl = 'https://your-project.supabase.co';
   static const String supabaseAnonKey = 'your-anon-key-here';
   ```
   
   d. Enable email authentication:
      - Go to Authentication → Providers
      - Enable Email provider

4. **Configure API Endpoint**
   
   Update `lib/feature/home_page/data/repository/presentation_api_service.dart`:
   ```dart
   static const String baseUrl = 'https://api.magicslides.app';
   ```

5. **Run the Application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

**Android**
- Minimum SDK: 21 (Android 5.0)
- Target SDK: Latest

**iOS**
- Minimum iOS: 12.0
- Requires Xcode for building

**Web**
- Supports Chrome, Firefox, Safari, Edge

**Desktop** (Windows, macOS, Linux)
- Flutter desktop support must be enabled

---

## Dependencies

### Core Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # UI Framework
  cupertino_icons: ^1.0.8
  forui: ^0.16.0              # Beautiful UI components
  forui_hooks: ^0.16.0
  forui_assets: ^0.16.0
  
  # Navigation
  go_router: ^17.0.0          # Declarative routing
  
  # Networking
  http: ^1.2.2                # HTTP requests
  cached_network_image: ^3.4.1 # Image caching
  
  # Authentication
  supabase_flutter: ^2.10.0   # Supabase client
  
  # PDF Viewing
  flutter_pdfview: ^1.4.3
  syncfusion_flutter_pdfviewer: ^31.2.16
  
  # Storage
  shared_preferences: ^2.5.3  # Local key-value storage
  path_provider: ^2.1.5       # File system paths
```

### Development Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0       # Lint rules
```

---

## API Endpoints

### Presentation Generation API

**Endpoint**: `POST /public/api/ppt_from_topic`

**Base URL**: `https://api.magicslides.app`

**Request Body**:
```json
{
  "topic": "Artificial Intelligence in Healthcare",
  "extraInfoSource": "Generated from Magic Slide App",
  "email": "user@example.com",
  "accessId": "SinceIDontHaveOne",
  "template": "bullet-point1",
  "language": "en",
  "slideCount": 10,
  "aiImages": false,
  "imageForEachSlide": true,
  "googleImage": false,
  "googleText": false,
  "model": "gpt-4",
  "presentationFor": "student",
  "watermark": {
    "width": "48",
    "height": "48",
    "brandURL": "https://example.com/logo.png",
    "position": "BottomRight"
  }
}
```

**Success Response**:
```json
{
  "success": true,
  "data": {
    "url": "https://example.com/generated.pptx"
  },
  "message": "Presentation generated successfully"
}
```

**Error Response**:
```json
{
  "success": false,
  "data": null,
  "message": "Error description here"
}
```

---

## Best Practices \u0026 Conventions

### Code Organization
- **Feature-based structure**: Each feature is self-contained
- **Layer separation**: Presentation, Domain, Data layers are distinct
- **Reusable components**: Common widgets extracted to shared locations

### Naming Conventions
- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `camelCase` (though `SCREAMING_SNAKE_CASE` is also acceptable)

### State Management
- Uses StatefulWidget for local UI state
- Controller classes for business logic
- ChangeNotifier for global state (theme)

### Error Handling
- Try-catch blocks around async operations
- User-friendly error messages via SnackBar
- Graceful fallbacks for API failures

---

## Future Enhancements

### Potential Features
- [ ] Social authentication (Google, Apple, GitHub)
- [ ] Presentation history and favorites
- [ ] Offline mode with local storage
- [ ] Advanced customization (fonts, colors, layouts)
- [ ] Collaboration features (sharing, commenting)
- [ ] Multiple language support for UI
- [ ] Analytics and usage tracking
- [ ] Export to different formats (PDF, PPTX, Google Slides)

### Technical Improvements
- [ ] State management with Riverpod or Bloc
- [ ] Unit and integration tests
- [ ] CI/CD pipeline
- [ ] Performance optimization
- [ ] Accessibility improvements
- [ ] Internationalization (i18n)

---

## Troubleshooting

### Common Issues

**Issue**: Supabase initialization fails
- **Solution**: Verify URL and anon key in `supabase_config.dart`
- Check network connection
- Ensure Supabase project is active

**Issue**: API returns "something is missing"
- **Cause**: Missing or invalid access credentials
- **Solution**: Check API key configuration or use the hardcoded fallback for testing

**Issue**: PDF viewer not loading
- **Solution**: Verify PDF URL is valid and accessible
- Check network permissions in platform-specific configs

**Issue**: Theme not updating
- **Solution**: Ensure `AnimatedBuilder` is wrapping MaterialApp
- Check `themeManager.notifyListeners()` is called

---

## Contributing

### Guidelines
1. Follow the existing code structure
2. Write clear commit messages
3. Test on multiple platforms
4. Update documentation for new features
5. Use meaningful variable and function names

### Pull Request Process
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit PR with clear description

---

## License

This project is private and not licensed for public use.

---

## Contact \u0026 Support

For questions or issues, please contact the development team or create an issue in the repository.

---

**Last Updated**: December 2025
**Version**: 1.0.0
