import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceSearchPage extends StatefulWidget {
  final List<Document> resources;
  const ResourceSearchPage({super.key, required this.resources});

  @override
  State<ResourceSearchPage> createState() => _ResourceSearchPageState();
}

class _ResourceSearchPageState extends State<ResourceSearchPage> {
  String? selectedDept;
  String? selectedSem;

  List<String> get departments => widget.resources
      .map((doc) => doc.data['dept'] as String? ?? '')
      .toSet()
      .where((e) => e.isNotEmpty)
      .toList();

  List<String> get semesters => widget.resources
      .map((doc) => doc.data['semester'] as String? ?? '')
      .toSet()
      .where((e) => e.isNotEmpty)
      .toList();

  List<Document> get filteredResources {
    return widget.resources.where((doc) {
      final dept = doc.data['dept'] as String? ?? '';
      final sem = doc.data['semester'] as String? ?? '';
      final matchesDept = selectedDept == null || selectedDept == dept;
      final matchesSem = selectedSem == null || selectedSem == sem;
      return matchesDept && matchesSem;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF2193b0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Resource Search',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
                ),
                SizedBox(width: 30,),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FILTER SECTION
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.withOpacity(0.15),
                        Colors.white.withOpacity(0.05)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedDept,
                          dropdownColor: const Color(0xFF1E1E1E),
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecorationDark('Select Department'),
                          items: departments
                              .map((dept) => DropdownMenuItem(
                            value: dept,
                            child: Text(dept),
                          ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedDept = value),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedSem,
                          dropdownColor: const Color(0xFF1E1E1E),
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecorationDark('Select Semester'),
                          items: semesters
                              .map((sem) => DropdownMenuItem(
                            value: sem,
                            child: Text(sem),
                          ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedSem = value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // RESOURCE LIST SECTION
            Expanded(
              child: filteredResources.isEmpty
                  ? const Center(
                child: Text(
                  'No resources found.',
                  style: TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
                  : ListView.builder(
                itemCount: filteredResources.length,
                itemBuilder: (context, index) {
                  final doc = filteredResources[index];
                  final dept = doc.data['dept'] ?? '';
                  final sem = doc.data['semester'] ?? '';
                  final link = doc.data['link'] ?? '';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dept,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          sem,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final url = Uri.parse(link);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Could not launch link")));
                              }
                            },
                            icon: const Icon(Icons.link),
                            label: const Text("Open Drive"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecorationDark(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.cyanAccent),
      ),
    );
  }
}
