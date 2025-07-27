import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import '../../../data/database/user_information.dart';
import '../alumnimanagementsection/alumni_container.dart';

class SearchBySeries extends StatefulWidget {
  const SearchBySeries({super.key});

  @override
  State<SearchBySeries> createState() => _SearchBySeriesState();
}

class _SearchBySeriesState extends State<SearchBySeries> {
  final TextEditingController _searchSeriesController = TextEditingController();
  List<models.Document> seriesResults = [];
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    _fetchAllAlumni();
  }
  void _fetchAllAlumni() async{
    setState(() => _isLoading = true);
    final results = await getAllAlumni();
    setState(() {
      seriesResults = results ?? [];
      _isLoading = false;
    });
  }

  void _onSearch() async {
    final series = _searchSeriesController.text.trim();
    if (series.isEmpty) return;

    setState(() => _isLoading = true);
    final results = await searchBySeries(series);
    setState(() {
      seriesResults = results ?? [];
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
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),  // deep navy
                  Color(0xFF203A43),  // blue-gray
                  Color(0xFF2C5364),  // steel blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          title: const Text(
            'Find Your Batch mates',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.1,
            ),
          ),
          centerTitle: true,
        ),
      ),

      body: Column(
        children: [
          // Search Box
          // Search Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TextField(
              controller: _searchSeriesController,
              onSubmitted: (_) => _onSearch(),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Enter Your Series...',
                hintStyle:
                TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Divider Line
          // Gradient Divider Line
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),

          // Body Section
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : seriesResults.isEmpty
                ? const Center(child: Text("No results found.",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),))
                : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 8),
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
                            child:
                            AlumniContainer(data: seriesResults[index]),
                          ),
                        );
                      },
                      childCount: seriesResults.length,
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
