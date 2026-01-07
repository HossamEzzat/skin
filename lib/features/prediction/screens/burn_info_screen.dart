import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skin/core/data/doctors_data.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/features/chat/screens/doctor_chatbot_screen.dart';

class Burninfoscreen extends StatefulWidget {
  final String prediction;
  final String imagePath;

  const Burninfoscreen({
    super.key,
    required this.prediction,
    required this.imagePath,
  });

  @override
  State<Burninfoscreen> createState() => _BurninfoscreenState();
}

class _BurninfoscreenState extends State<Burninfoscreen> {
  bool isLoading = true;

  String diseaseName = "Unknown";
  String aboutInfo = "No information available.";
  String symptoms = "No information available.";
  String prevention = "No information available.";
  String treatment = "No information available.";
  String dangerLevel = "No information available.";

  final Map<String, Map<String, String>> diseaseData = {
    'first-degree': {
      'about':
          'A mild burn affecting only the outer skin layer, causing redness and mild swelling.',
      'symptoms': 'Redness, pain, mild swelling, dry skin.',
      'prevention':
          'Avoid sun exposure, use sunscreen, protect from hot surfaces.',
      'treatment':
          'Cool with water, apply aloe vera, use over-the-counter pain relievers.',
      'dangerLevel': 'Low, heals within a week without scarring.',
    },
    'second-degree': {
      'about':
          'Affects both skin layers with blistering, intense pain, and swelling.',
      'symptoms': 'Blisters, redness, pain, swelling.',
      'prevention':
          'Avoid hot liquids, flames, and surfaces. Use protective gear.',
      'treatment':
          'Cool with running water, use a sterile bandage, take pain relievers.',
      'dangerLevel':
          'Moderate, heals in 2–3 weeks, may cause scarring if untreated.',
    },
    'third-degree': {
      'about':
          'Severe burn affecting all skin layers and deeper tissues, requiring urgent care.',
      'symptoms': 'Charred skin, numbness, swelling.',
      'prevention': 'Avoid flames, electrical sources, and hot liquids.',
      'treatment':
          'Seek medical attention, cover with a clean bandage, avoid ice.',
      'dangerLevel':
          'High, requires emergency treatment and may cause complications.',
    },
  };

  @override
  void initState() {
    super.initState();
    getDiseaseData(widget.prediction);
  }

  void getDiseaseData(String prediction) {
    setState(() {
      if (diseaseData.containsKey(prediction)) {
        diseaseName = prediction.toUpperCase();
        aboutInfo = diseaseData[prediction]!['about']!;
        symptoms = diseaseData[prediction]!['symptoms']!;
        prevention = diseaseData[prediction]!['prevention']!;
        treatment = diseaseData[prediction]!['treatment']!;
        dangerLevel = diseaseData[prediction]!['dangerLevel']!;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= App Bar =================
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/icons/left-arrow.png',
                              width: 15,
                              height: 15,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),

                    // ================= Image =================
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.file(
                          File(widget.imagePath),
                          width: double.infinity,
                          height: 210,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // ================= Content =================
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                diseaseName,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            const Text(
                              'About',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              aboutInfo,
                              style: const TextStyle(fontSize: 16),
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'Key Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                _buildCircularInfo(
                                  'Symptoms',
                                  symptoms,
                                  'assets/icons/diagnosis.png',
                                ),
                                _buildCircularInfo(
                                  'How to Reduce',
                                  prevention,
                                  'assets/icons/capsules.png',
                                ),
                                _buildCircularInfo(
                                  'Treatment',
                                  treatment,
                                  'assets/icons/medical.png',
                                ),
                                _buildCircularInfo(
                                  'Level of Danger',
                                  dangerLevel,
                                  'assets/icons/fire.png',
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Find a general physician or dermatologist
                                  final doctor = doctorsList.firstWhere(
                                    (d) => d.specialty.contains("General"),
                                    orElse: () => doctorsList.first,
                                  );
                                  Navigator.push(
                                    context,
                                    NoAnimationPageRoute(
                                      builder: (_) =>
                                          DoctorChatBotScreen(doctor: doctor),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.smart_toy_outlined),
                                label: const Text('Consult AI Assistant Now'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ================= Info Circle =================

  Widget _buildCircularInfo(String title, String content, String imagePath) {
    return Container(
      width: 155,
      height: 155,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 30, height: 30),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              content,
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }
}
