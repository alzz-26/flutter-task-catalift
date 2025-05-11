import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_info_provider.dart';
import '../dashboard.dart';
import '../../services/auth_service.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> interests = List.generate(24, (number) => 'Interest ${number+1}');
  late Set<int> selectedIndices ;

  @override
  Widget build(BuildContext context) {
    final auth_check = Provider.of<AuthService>(context).newUser;
    final userInfo = context.read<UserInfoProvider>().userInfo;
    selectedIndices = userInfo.hasInterests ? userInfo.interests : {};
    print(selectedIndices);
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
                  value: 0.75,
                  minHeight: 8.0,
                  backgroundColor: Colors.grey.shade200,
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Your Interests",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
              const SizedBox(height: 10),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(interests.length, (index) {
                  final isSelected = selectedIndices.contains(index);
                  return ChoiceChip(
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    label: Text(interests[index]),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        if (isSelected) {
                          selectedIndices.remove(index);
                          context.read<UserInfoProvider>().setInterests(selectedIndices);
                          print('removed');
                        } else {

                          selectedIndices.add(index);
                          context.read<UserInfoProvider>().setInterests(selectedIndices);
                          print(selectedIndices);
                          print(index);
                          print('added');
                        }
                      });
                    },
                    selectedColor: primaryColor,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.blue),
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.blue),
                  );
                }),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  print(selectedIndices);
                  context.read<UserInfoProvider>().setInterests(selectedIndices);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const DashboardPage()));
                },
                child: Text(
                    auth_check == true ? "Continue" : "Save",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage())),
                child: Text(
                    auth_check == true ? "Skip" : "Back",
                    style: TextStyle(color: Colors.blue)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}