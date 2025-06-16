import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import '../../../data/database/user_information.dart'; // Import your separated logic
import '../alumnimanagementsection/alumni_container.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController _searchLocationController = TextEditingController();
  final TextEditingController _searchWorkPlaceController = TextEditingController();
  List<models.Document> _results = [];
  bool _isLoading = false;

  void _onSearch() async {
    final location = _searchLocationController.text.trim();
    final workplace = _searchWorkPlaceController.text.trim();

    setState(() => _isLoading = true);

    final results = await searchByLocationAndName(
      location: location.isEmpty ? "" : location,
      workplace: workplace.isEmpty ? "" : workplace,
    );

    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )
            ),
          ),
          title: const Text(
            'Search Alumni',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                TextField(
                  controller: _searchLocationController,
                  onSubmitted: (_) => _onSearch(),
                  decoration: InputDecoration(
                    hintText: 'Enter location...',
                    prefixIcon: Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _searchWorkPlaceController,
                  onSubmitted: (_) => _onSearch(),
                  decoration: InputDecoration(
                    hintText: 'Enter Company/University...',
                    prefixIcon: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16,
            vertical: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _results.isEmpty
                ? const Center(child: Text("No results found.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)))
                : Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return AnimatedOpacity(
                          opacity: 1,
                          duration: Duration(milliseconds: 300 + index * 100),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: AlumniContainer(data: _results[index]),
                          ),
                        );
                      },
                      childCount: _results.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
