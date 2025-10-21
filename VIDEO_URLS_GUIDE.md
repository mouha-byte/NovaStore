# Video URLs Configuration Guide

## How to Add Real Video URLs

### Location
File: `lib/screens/landing_sections/videos_section.dart`

### Current Video Cards

The videos section has 4 video cards. Currently, all videos use a placeholder YouTube URL. You need to replace them with your actual product video URLs.

### Step-by-Step Instructions

1. **Find the `_buildVideoCard` method** (around line 140)

2. **Current placeholder code:**
```dart
// Generate YouTube-like URL (these are placeholder URLs)
final videoUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'; // Replace with actual video URLs
```

3. **Option A - Individual URLs per video:**

Replace the method to accept a video URL parameter:

```dart
Widget _buildVideoCard(
  String title, 
  String views, 
  String thumbnailUrl, 
  Duration duration,
  String videoUrl  // Add this parameter
) {
  // ... rest of the code
}
```

Then update the GridView calls:

```dart
_buildVideoCard(
  'Unboxing & First Impressions',
  '2.4M views',
  'https://images.unsplash.com/photo-1611162616305-c69b3fa7fbe0?w=800&h=500&fit=crop',
  const Duration(minutes: 8, seconds: 24),
  'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_1',  // Add your URL
),
_buildVideoCard(
  '30-Day Transformation',
  '1.8M views',
  'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=500&fit=crop',
  const Duration(minutes: 12, seconds: 15),
  'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_2',  // Add your URL
),
_buildVideoCard(
  'Expert Review & Testing',
  '3.2M views',
  'https://images.unsplash.com/photo-1551033406-611cf9a28f67?w=800&h=500&fit=crop',
  const Duration(minutes: 15, seconds: 42),
  'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_3',  // Add your URL
),
_buildVideoCard(
  'Customer Success Stories',
  '2.1M views',
  'https://images.unsplash.com/photo-1552664730-d307ca884978?w=800&h=500&fit=crop',
  const Duration(minutes: 10, seconds: 33),
  'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_4',  // Add your URL
),
```

### Option B - Use a Map for Better Organization

At the top of the `VideosSection` class, define your videos:

```dart
class VideosSection extends StatelessWidget {
  const VideosSection({super.key});

  // Define your videos here
  final List<Map<String, dynamic>> videos = const [
    {
      'title': 'Unboxing & First Impressions',
      'views': '2.4M views',
      'thumbnail': 'https://images.unsplash.com/photo-1611162616305-c69b3fa7fbe0?w=800&h=500&fit=crop',
      'duration': Duration(minutes: 8, seconds: 24),
      'url': 'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_1',
    },
    {
      'title': '30-Day Transformation',
      'views': '1.8M views',
      'thumbnail': 'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=800&h=500&fit=crop',
      'duration': Duration(minutes: 12, seconds: 15),
      'url': 'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_2',
    },
    {
      'title': 'Expert Review & Testing',
      'views': '3.2M views',
      'thumbnail': 'https://images.unsplash.com/photo-1551033406-611cf9a28f67?w=800&h=500&fit=crop',
      'duration': Duration(minutes: 15, seconds: 42),
      'url': 'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_3',
    },
    {
      'title': 'Customer Success Stories',
      'views': '2.1M views',
      'thumbnail': 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=800&h=500&fit=crop',
      'duration': Duration(minutes: 10, seconds: 33),
      'url': 'https://www.youtube.com/watch?v=YOUR_VIDEO_ID_4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ... existing code
  }
}
```

Then use it in the GridView:

```dart
children: videos.map((video) {
  return _buildVideoCard(
    video['title'],
    video['views'],
    video['thumbnail'],
    video['duration'],
    video['url'],  // Now uses the URL from the map
  );
}).toList(),
```

### Video URL Formats Supported

- **YouTube:** `https://www.youtube.com/watch?v=VIDEO_ID`
- **YouTube Short:** `https://youtu.be/VIDEO_ID`
- **Vimeo:** `https://vimeo.com/VIDEO_ID`
- **Any direct video URL:** `https://example.com/video.mp4`

### Getting YouTube Video ID

From a YouTube URL like: `https://www.youtube.com/watch?v=dQw4w9WgXcQ`

The video ID is: `dQw4w9WgXcQ` (everything after `v=`)

### Thumbnail URLs

You can also use YouTube's auto-generated thumbnails:

```dart
'https://img.youtube.com/vi/VIDEO_ID/maxresdefault.jpg'
// or
'https://img.youtube.com/vi/VIDEO_ID/hqdefault.jpg'
```

Replace `VIDEO_ID` with your actual YouTube video ID.

### Testing

1. Update the URLs
2. Save the file
3. Run the app: `flutter run`
4. Navigate to the Videos section
5. Click on a video card
6. Video should open in your device's default browser or YouTube app

### Troubleshooting

**Video doesn't open:**
- Check that the URL is correct
- Verify url_launcher package is installed in pubspec.yaml
- Make sure the device has a browser or YouTube app installed

**Thumbnail not loading:**
- Check thumbnail URL is valid
- Use YouTube's auto-generated thumbnails
- Verify network connection

### Example with Real YouTube Video

```dart
_buildVideoCard(
  'iPhone 15 Pro Max Unboxing',
  '5.2M views',
  'https://img.youtube.com/vi/XKfgdkcIUxw/maxresdefault.jpg',
  const Duration(minutes: 12, seconds: 30),
  'https://www.youtube.com/watch?v=XKfgdkcIUxw',
),
```

## Quick Update Checklist

- [ ] Collect your product video URLs (YouTube, Vimeo, etc.)
- [ ] Update video URLs in the code
- [ ] Update thumbnail URLs (optional)
- [ ] Update video titles to match your content
- [ ] Update view counts (optional, for social proof)
- [ ] Update durations to match actual video length
- [ ] Test each video opens correctly
- [ ] Verify on both mobile and desktop

## Notes

- Videos open in external app for best user experience
- No need for video_player package (saves app size)
- Works on all platforms (iOS, Android, Web)
- Users need internet connection to play videos
- Consider adding analytics to track video views
