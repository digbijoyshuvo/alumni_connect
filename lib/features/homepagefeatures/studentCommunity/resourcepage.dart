import 'package:alumni_connect/features/homepagefeatures/studentCommunity/resource_search.dart';
import 'package:alumni_connect/features/homepagefeatures/studentCommunity/resources_data.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({super.key});

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  List<Document> resources = [];
  bool isLoading = false;
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    setState(() => isLoading = true);
    resources = await getAllResources();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          if (isLoading)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator(
                color: Colors.cyanAccent,
              )),
            )
          else if (resources.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: const Center(
                child: Text(
                  "No file exists",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final doc = resources[index];
                    final dept = doc.data['dept'] ?? '';
                    final sem = doc.data['semester'] ?? '';
                    final driveLink = doc.data['link'] ?? '';
                    return _buildResourceBox(dept, sem, driveLink);
                  },
                  childCount: resources.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
  // Top Sliver AppBar
  Widget _buildAppBar() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "All Study Materials",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white,size: 30,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ResourceSearchPage(resources: resources,)),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  // Resource Box Widget
  Widget _buildResourceBox(String dept, String sem, String driveLink) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFe0c3fc), Color(0xFF8ec5fc)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.folder_special, size: 40, color: Colors.black),
          const SizedBox(height: 10),
          Text(
            dept,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            sem,
            style: const TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () async {
                final url = Uri.parse(driveLink);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  CustomSnackBar.showError(context, "Could not launch URL");
                }
              },
              icon: const Icon(Icons.link),
              label: const Text("Drive Link"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
