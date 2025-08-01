import 'package:appwrite/models.dart';

import 'package:flutter/material.dart';

import '../../../utils/formate_date&time.dart';
import 'event_details.dart';

class EventContainer extends StatelessWidget {
  final Document data;
  const EventContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => EventDetails(data: data))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D3E),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color:Colors.greenAccent,
                    blurRadius: 0,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Image.asset('assets/images/eventbg.jpg',
              fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 70,
              left: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  data.data["name"],
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    // overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 16,
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    formatDate(data.data["date_time"]),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.access_time_rounded, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    formatTime(data.data["date_time"]),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                left: 16,
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      data.data["location"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}