import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/dashboard.dart';
import '../../providers/user_info_provider.dart';
import 'interests.dart';
import '../../services/auth_service.dart';

class EducationDetailsScreen extends StatefulWidget {
  const EducationDetailsScreen({super.key});

  @override
  State<EducationDetailsScreen> createState() => _EducationDetailsScreenState();
}

class _EducationDetailsScreenState extends State<EducationDetailsScreen> {
  late String highestEdu;
  late String institution;
  late String roles;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final userInfo = context.read<UserInfoProvider>().userInfo;
    highestEdu = userInfo.educationLevel;
    institution = userInfo.institution;
    roles = userInfo.pastRoles;
    _controller = TextEditingController(text: roles);
  }


  @override
  Widget build(BuildContext context) {
    final auth_check = Provider.of<AuthService>(context).newUser;
    const primaryColor = Color(0xFF0B0073);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LinearProgressIndicator(
                  value: 0.5,
                  minHeight: 8.0,
                  backgroundColor: Colors.grey.shade200,
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text("Your Education Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
              ),
              const SizedBox(height: 20),
              const Text(
                "Highest Education Level",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200)
                  )
                ),
                items: ['', 'High School', 'Bachelor’s', 'Master’s', 'PhD']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: highestEdu.isEmpty ? '' : highestEdu,
                onChanged: (val) => setState(() { 
                  highestEdu = val!;
                  context.read<UserInfoProvider>().setEducationLevel(highestEdu);
                }),
              ),
              const SizedBox(height: 20),
              const Text(
                "Current Institution",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200)
                  )
                ),
                items: ['','Institution A', 'Institution B', 'Institution C']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: institution.isEmpty ? '' : institution,
                onChanged: (val) => setState(() { 
                  institution = val!;
                  context.read<UserInfoProvider>().setInstitution(institution);
                }),
              ),
              const SizedBox(height: 20),
              const Text(
                "Relevant Past Roles/Internships",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                maxLines: 3,
                maxLength: 100,
                onChanged: (_) => setState(() {
                  context.read<UserInfoProvider>().setPastRoles(_controller.text);
                }),
                decoration: InputDecoration(
                  counterText: '',
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          '${_controller.text.length}/100 words typed',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B0073),
                          ),
                        ),
                      ),
                    ],
                  ),
                  hintText: 'Write in 100 Words',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w100,
                    color: Colors.blueGrey.shade300,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  context.read<UserInfoProvider>().setEducationInfo(
                    highestEdu,
                    institution,
                    _controller.text,
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => auth_check == true ? const InterestsScreen() : const DashboardPage()));
                },
                child: Text(
                    auth_check == true ? "Continue" : "Save",
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => auth_check == true ? const InterestsScreen() : const DashboardPage())),
                child: Text(
                    auth_check == true ? "Skip" : "Back",
                    style: const TextStyle(color: Colors.blue)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

