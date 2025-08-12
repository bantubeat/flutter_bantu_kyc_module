import 'package:flutter/material.dart';

class KycStep6o2SelfieIdScreen extends StatelessWidget {
  const KycStep6o2SelfieIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use a Stack to layer the UI elements over the camera preview
      body: Stack(
        children: [
          // --- Camera Preview Placeholder ---
          // In a real app, this would be a camera preview widget (e.g., from the 'camera' package).
          // Here, we use the provided image as a background to simulate the view.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // NOTE: You'll need to add the image to your pubspec.yaml and assets folder.
                // For demonstration, I'm using a network image placeholder.
                // Replace this with AssetImage('assets/image_af9581.jpg') in a real project.
                image: NetworkImage('https://i.imgur.com/u8w5mQJ.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // --- Top Bar with Controls ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // Navigate back to the previous screen
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.flash_on, color: Colors.white),
                  onPressed: () {
                    // Handle flash toggle
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                  onPressed: () {
                    // Handle camera flip
                  },
                ),
              ],
            ),
          ),

          // --- Shutter Button ---
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  // Handle picture taking logic
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE8B33B),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
