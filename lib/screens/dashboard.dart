import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../providers/user_info_provider.dart';
import 'onboarding/education_details.dart';
import 'onboarding/interests.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.user;
    final userInfo = context.watch<UserInfoProvider>().userInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              //Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text("Welcome, ${user?.displayName ?? user?.email ?? 'User'}!",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _buildSection(
              context,
              title: "Education Details",
              content: userInfo.hasEducationInfo
                  ? "Education Level: ${userInfo.educationLevel}\n"
                  "Institution: ${userInfo.institution}\n"
                  "Past Roles: ${userInfo.pastRoles}"
                  : "No education information provided.",
              onEdit: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationDetailsScreen())),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              title: "Interests",
              content: userInfo.hasInterests
                  ? "Interests : ${userInfo.interests.join(", ")}"
                  : "No interests provided.",
              onEdit: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterestsScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required String content, required VoidCallback onEdit}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: onEdit, child: const Text("Edit")),
              ],
            ),
            const SizedBox(height: 10),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
