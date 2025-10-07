import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'ticket_booking_page.dart';
import 'place_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gujarat Tourism'),
        backgroundColor: const Color.fromARGB(255, 4, 42, 73),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              final authService = AuthService();
              await authService.logout();
              
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 194, 196, 197), Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Welcome Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Welcome to Gujarat!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Discover the rich culture and heritage of Gujarat',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Popular Destinations Section
            const Text(
              'Popular Destinations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 160),
            
            // Destination Cards
            DestinationCard(
              title: 'Statue of Unity',
              description: 'World\'s tallest statue, dedicated to Sardar Vallabhbhai Patel',
              imageUrl: 'assets/images/state_of_unity.jpg',
              onTap: () => _navigateToPlaceDetails(context, 'Statue of Unity'),
            ),
            const SizedBox(height: 120),
            DestinationCard(
              title: 'Somnath Temple',
              description: 'Ancient temple with rich historical significance',
              imageUrl: 'assets/images/somnath.png',
              onTap: () => _navigateToPlaceDetails(context, 'Somnath Temple'),
            ),
            const SizedBox(height: 120),
            DestinationCard(
              title: 'Rann of Kutch',
              description: 'Beautiful white desert and cultural heritage',
              imageUrl: 'https://www.gujarattourism.com/content/dam/gujrattourism/images/weekend-get-aways/great-rann-of-kutch/gallery/Great%20Rann%20Of%20Kutch%20(14).jpg',
              onTap: () => _navigateToPlaceDetails(context, 'Rann of Kutch'),
            ),

            const SizedBox(height: 120),
            
            // Book Tickets Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicketBookingPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Book Tickets',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPlaceDetails(BuildContext context, String placeName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsPage(placeName: placeName),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const DestinationCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                image: imageUrl.startsWith('assets/')
                  ? DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : imageUrl.startsWith('http')
                    ? DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl.startsWith('assets/') || imageUrl.startsWith('http')
                ? null
                : const Center(
                    child: Icon(
                      Icons.photo,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}