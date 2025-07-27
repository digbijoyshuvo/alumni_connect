import 'package:alumni_connect/utils/formate_date&time.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  final Document data;
  const EventDetails({super.key, required this.data});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final event = widget.data.data;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E1F28), // dark base (soft black)
              Color(0xFF323044), // bluish slate
              Color(0xFF3A3F5C), // dark indigo blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Center(
                  child: Text(
                    event["name"] ?? "Unnamed Event",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF00F260), // Mint green
                          Color(0xFF0575E6), // Sky blue
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreenAccent.shade100,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  event["description"] ?? "No Description Available",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),
                Text(
                  "Special Guests",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent.shade100,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  event["special_guests"] ?? "None",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Text(
                      "Date: ${formatDate(event["date_time"])}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Text(
                      "Time: ${formatTime(event["date_time"])}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  event["location"] ?? "To Be Announced",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
