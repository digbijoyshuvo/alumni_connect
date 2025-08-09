import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:http/http.dart' as http;
import '../../../data/database/user_information.dart';
import '../alumnimanagementsection/alumni_container.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController _searchLocationController =
  TextEditingController();
  final TextEditingController _searchWorkPlaceController =
  TextEditingController();

  List<models.Document> _results = [];
  bool _isLoading = false;

  // Mapbox Autocomplete
  List<MapboxSuggestion> _locationSuggestions = [];
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  // Control autocomplete after selection
  bool _allowSuggestions = true;
  String _lastSelectedLocation = '';

  late VoidCallback _locationFieldListener;

  @override
  void initState() {
    super.initState();
    _fetchAllAlumni();

    _locationFieldListener = () {
      if (!_allowSuggestions &&
          _searchLocationController.text != _lastSelectedLocation) {
        setState(() {
          _allowSuggestions = true;
        });
      }
      _onLocationChanged();
    };

    _searchLocationController.addListener(_locationFieldListener);
  }


  @override
  void dispose() {
    _searchLocationController.dispose();
    _searchWorkPlaceController.dispose();
    _debounce?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _fetchAllAlumni() async {
    setState(() => _isLoading = true);
    final results = await getAllAlumni();
    setState(() {
      _results = results ?? [];
      _isLoading = false;
    });
  }

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
    _removeOverlay();
  }

  void _onLocationChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Only trigger suggestions if allowed
    if (!_allowSuggestions) return;

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = _searchLocationController.text.trim();
      if (query.isNotEmpty) {
        _fetchLocationSuggestions(query);
      } else {
        _removeOverlay();
      }
    });
  }

  Future<void> _fetchLocationSuggestions(String query) async {
    const sessionToken = '066b2361-b900-44d8-8198-7b2a82ea0091';
    const accessToken =
        'Put Your MapBox Access Token Here'; // Replace with your Mapbox access token

    final url =
        'Your Mapbox API URL Here';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List suggestions = data['suggestions'];
      setState(() {
        _locationSuggestions =
            suggestions.map((json) => MapboxSuggestion.fromJson(json)).toList();
      });
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _onSuggestionSelected(MapboxSuggestion s) {
    // Temporarily remove listener to avoid triggering suggestions
    _searchLocationController.removeListener(_locationFieldListener);

    // Set text from suggestion
    _searchLocationController.text = s.name;
    _lastSelectedLocation = s.name;

    // Re-add listener
    _searchLocationController.addListener(_locationFieldListener);

    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Hide suggestions
    _removeOverlay();

    // Prevent showing suggestions again until text is changed
    setState(() {
      _allowSuggestions = false;
    });

    _onSearch();
  }


  void _showOverlay() {
    _removeOverlay();
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final width = renderBox.size.width;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: width - 32,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 60),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _locationSuggestions.length,
                itemBuilder: (context, index) {
                  final s = _locationSuggestions[index];
                  return ListTile(
                    title: Text(s.name),
                    subtitle: Text(s.placeFormatted),
                    onTap: () => _onSuggestionSelected(s),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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
              ),
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
                CompositedTransformTarget(
                  link: _layerLink,
                  child: TextField(
                    controller: _searchLocationController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter location...',
                      prefixIcon: Icon(Icons.location_on,
                          color: Theme.of(context).colorScheme.primary),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _searchWorkPlaceController,
                  onSubmitted: (value) => _onSearch(),
                  decoration: InputDecoration(
                    hintText: 'Enter Company/University...',
                    prefixIcon: Icon(Icons.person,
                        color: Theme.of(context).colorScheme.primary),
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
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                ? const Center(
                child: CircularProgressIndicator(color: Colors.blue))
                : _results.isEmpty
                ? const Center(
                child: Text("No results found.",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600)))
                : Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return AnimatedOpacity(
                          opacity: 1,
                          duration: Duration(
                              milliseconds: 300 + index * 100),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 12.0),
                            child: AlumniContainer(
                                data: _results[index]),
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

class MapboxSuggestion {
  final String name;
  final String placeFormatted;

  MapboxSuggestion({
    required this.name,
    required this.placeFormatted,
  });

  factory MapboxSuggestion.fromJson(Map<String, dynamic> json) {
    return MapboxSuggestion(
      name: json['name'] ?? '',
      placeFormatted: json['place_formatted'] ?? '',
    );
  }
}
