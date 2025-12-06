# Magic Slide - Presentation Generator API Integration

## Overview
This Flutter app integrates with a presentation generation API to create PowerPoint presentations automatically based on user input.

## API Configuration

### Setting Up Your API Endpoint

1. Open `/lib/feature/home_page/data/api_service.dart`
2. Update the `baseUrl` constant with your actual API endpoint:

```dart
static const String baseUrl = 'https://your-actual-api-endpoint.com';
```

### API Request Format

The API expects a POST request to the `/api/generate` endpoint with the following JSON structure:

```json
{
  "topic": "Artificial Intelligence in Healthcare",
  "extraInfoSource": "Focus on recent developments",
  "email": "your-email@example.com",
  "accessId": "your-access-id",
  "template": "bullet-point1",
  "language": "en",
  "slideCount": 10,
  "aiImages": false,
  "imageForEachSlide": true,
  "googleImage": false,
  "googleText": false,
  "model": "gpt-4",
  "presentationFor": "healthcare professionals",
  "watermark": {
    "width": "48",
    "height": "48",
    "brandURL": "https://example.com/logo.png",
    "position": "BottomRight"
  }
}
```

### API Response Format

The API should return a JSON response in the following format:

**Success Response:**
```json
{
  "success": true,
  "data": {
    "url": "https://example.com/generated.pptx"
  },
  "message": "Presentation generated successfully"
}
```

**Error Response:**
```json
{
  "success": false,
  "data": null,
  "message": "Error description here"
}
```

## Features

### User Inputs
- **Topic**: Main subject of the presentation (required)
- **Email**: User's email address (required)
- **Access ID**: API access identifier (required)
- **Language**: Presentation language (English/Arabic)
- **Mode**: Default or Editable presentation
- **Model**: AI model selection (gpt-4, gpt-4o, gpt-4o-mini)
- **Presentation For**: Target audience (student, teacher, business)
- **Slide Count**: Number of slides to generate (default: 10)
- **Watermark Settings**:
  - Width and Height (default: 48)
  - Brand URL (default: https://example.com/logo.png)
  - Position (TopRight, TopLeft, BottomRight, BottomLeft)

### Toggle Options
- **AI Images**: Use AI-generated images
- **Image on Each Page**: Add images to every slide
- **Google Image**: Use Google Images
- **Google Text**: Use Google search for content

## File Structure

```
lib/
├── feature/
│   └── home_page/
│       ├── data/
│       │   └── api_service.dart          # API service
│       ├── domain/
│       │   └── model/
│       │       ├── generate_input_model.dart    # Request model
│       │       ├── generate_response_model.dart # Response model
│       │       └── watermark_model.dart         # Watermark config
│       └── home_screen.dart              # UI implementation
```

## Usage Flow

1. User fills in the required fields (Topic, Email, Access ID)
2. User configures optional settings (language, model, watermark, etc.)
3. User clicks the "Generate" button
4. App validates inputs and shows a loading indicator
5. App makes API call with all configured parameters
6. On success: Shows dialog with the presentation download URL
7. On error: Shows error message via SnackBar

## Error Handling

The app handles the following error scenarios:
- Empty required fields (topic, email, access ID)
- Invalid email format
- Network errors
- API errors (non-200 status codes)
- General exceptions

## Next Steps

1. Replace the placeholder API endpoint in `api_service.dart`
2. Test with your actual API
3. Optionally customize the default values and templates
4. Add any additional fields required by your API

## Models

### GenerateInputModel
Complete data model for API requests with all form inputs.

### GenerateResponseModel
Parses API responses including success status, data, and messages.

### WatermarkModel
Handles watermark configuration (size, position, brand URL).

## Dependencies

- `http: ^1.2.2` - For making HTTP requests
- `forui` - UI components library

---

**Note**: Remember to update the API endpoint URL before deploying or testing with a real API.
