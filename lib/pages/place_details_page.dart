import 'package:flutter/material.dart';
import 'ticket_booking_page.dart';

class PlaceDetailsPage extends StatelessWidget {
  final String placeName;

  const PlaceDetailsPage({
    super.key,
    required this.placeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(placeName),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: placeName == 'Statue of Unity'
                    ? const DecorationImage(
                        image: AssetImage('assets/images/statue_of_unity.jpg'),
                        fit: BoxFit.cover,
                      )
                    : null,
                ),
                child: placeName != 'Statue of Unity'
                  ? const Center(
                      child: Icon(
                        Icons.photo,
                        size: 80,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Description Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getPlaceDescription(placeName),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Highlights Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Highlights',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._getPlaceHighlights(placeName).map(
                          (highlight) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 8),
                                Expanded(child: Text(highlight)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Book Tickets Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketBookingPage(
                            selectedPlace: placeName,
                          ),
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
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getPlaceDescription(String name) {
    switch (name) {
      case 'Statue of Unity':
        return 'The Statue of Unity is the world\'s tallest statue, with a height of 182 metres. Dedicated to Indian independence movement leader Sardar Vallabhbhai Patel, it is located in the state of Gujarat, India, on the Narmada River.';
      case 'Somnath Temple':
        return 'The Somnath temple is one of the most sacred pilgrimage sites for Hindus and is believed to be the first among the twelve jyotirlinga shrines of Shiva. It has been destroyed and reconstructed several times in the past.';
      case 'Rann of Kutch':
        return 'The Rann of Kutch is a salt marsh in the Thar Desert in the Kutch District of Gujarat. This area is famous for its white salt desert and hosts the famous Rann Utsav festival.';
      default:
        return 'A beautiful tourist destination in Gujarat.';
    }
  }

  List<String> _getPlaceHighlights(String name) {
    switch (name) {
      case 'Statue of Unity':
        return [
          'World\'s tallest statue (182 meters)',
          'Viewing gallery at 153 meters',
          'Museum and audio-visual gallery',
          'Valley of Flowers garden',
        ];
      case 'Somnath Temple':
        return [
          'Ancient temple architecture',
          'Beautiful Arabian Sea views',
          'Sound and light show',
          'Rich historical significance',
        ];
      case 'Rann of Kutch':
        return [
          'Vast white salt desert',
          'Famous Rann Utsav festival',
          'Traditional Kutchi culture',
          'Stunning sunset views',
        ];
      default:
        return ['Beautiful location', 'Rich cultural heritage'];
    }
  }
}