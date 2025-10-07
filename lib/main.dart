import 'package:flutter/material.dart';
import 'auth_check.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gujarat Tourist Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 4, 8, 11)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthCheck(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gujarat Tourist Guide'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Register/Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
                );
              },
              child: const Text('Register / Login'),
            ),
            const SizedBox(height: 20),
            
            // Tourist Places List
            const Text(
              'Popular Tourist Places',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TouristPlaceCard(
              name: 'Statue of Unity',
              description: 'World\'s tallest statue located in Kevadia',
            ),
            TouristPlaceCard(
              name: 'Somnath Temple',
              description: 'Ancient temple located in Saurashtra',
            ),
            
            // Book Tickets Button
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TicketPage()),
                );
              },
              child: const Text('Book Tickets'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tourist Place Card Widget
class TouristPlaceCard extends StatelessWidget {
  final String name;
  final String description;

  const TouristPlaceCard({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}

// Simple Registration Page
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Simple registration success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration successful!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Ticket Page
class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: const Text('Select Tourist Place'),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'statue_of_unity',
                  child: Text('Statue of Unity'),
                ),
                DropdownMenuItem(
                  value: 'somnath_temple',
                  child: Text('Somnath Temple'),
                ),
              ],
              onChanged: (value) {
                // Add selection logic here
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Simple booking success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ticket booked successfully!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
