import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'enable_fingerprint_page.dart';

class ProfilePicturePage extends StatefulWidget {
  const ProfilePicturePage({Key? key}) : super(key: key);

  @override
  State<ProfilePicturePage> createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  String? selectedEmoji;
  File? customImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> emojiOptions = ['🤠', '🐶', '😊'];

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          customImage = File(image.path);
          selectedEmoji =
              null; // Clear emoji selection when custom image is selected
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Widget _buildEmojiOption(String emoji) {
    final bool isSelected = selectedEmoji == emoji;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmoji = emoji;
          customImage = null; // Clear custom image when emoji is selected
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
      ),
    );
  }

  Widget _buildMainAvatar() {
    if (customImage != null) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue, width: 3),
          image: DecorationImage(
            image: FileImage(customImage!),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (selectedEmoji != null) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.shade100,
          border: Border.all(color: Colors.blue, width: 3),
        ),
        child: Center(
          child: Text(selectedEmoji!, style: const TextStyle(fontSize: 50)),
        ),
      );
    } else {
      // Default temporary profile picture
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.shade100,
          border: Border.all(color: Colors.blue, width: 3),
        ),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
            image: const DecorationImage(
              // Using a placeholder image - you can replace with NetworkImage or AssetImage
              image: NetworkImage(
                'https://via.placeholder.com/100x100/E0E0E0/9E9E9E?text=👤',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }

  bool get _hasSelection => selectedEmoji != null || customImage != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Skip functionality
              Navigator.pop(context);
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.blue.shade400, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Progress indicator
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.3, // Assuming this is step 1/3
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Step indicator
            Text(
              'STEP 1/3',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            // Title
            const Text(
              'Profile Picture',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            // Main avatar display
            _buildMainAvatar(),

            const SizedBox(height: 32),

            // Emoji options
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: emojiOptions.map((emoji) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildEmojiOption(emoji),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // Description text
            Text(
              'You can select photo from one of\nthe emoji or add your own photo\nas profile picture',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // Add custom photo button
            TextButton.icon(
              onPressed: _pickImage,
              icon: Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.blue.shade600,
                size: 20,
              ),
              label: Text(
                'Add Custom Photo',
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _hasSelection
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EnableFingerprintPage(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  disabledBackgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Usage example - add this to your main.dart or routing
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Setup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display', // iOS-like font
      ),
      home: const ProfilePicturePage(),
      routes: {
        '/next_step': (context) => const NextStepPage(), // Your next page
      },
    );
  }
}

// Placeholder for the next step page
class NextStepPage extends StatelessWidget {
  const NextStepPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text('Next Step')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile picture selected!'),
            const SizedBox(height: 20),
            if (args?['emoji'] != null)
              Text('Selected emoji: ${args!['emoji']}'),
            if (args?['customImage'] != null)
              const Text('Custom image selected'),
          ],
        ),
      ),
    );
  }
}
