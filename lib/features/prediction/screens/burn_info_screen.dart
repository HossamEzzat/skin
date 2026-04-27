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

  // Keys are normalized-friendly: first-degree, second-degree, third-degree
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

  // Optional: if your model ever returns class IDs or short labels
  // Adjust these if your dataset mapping differs.
  final Map<String, String> burnAliases = {
    '0': 'first-degree',
    '1': 'second-degree',
    '2': 'third-degree',
    'first degree burn': 'first-degree',
    'first degree': 'first-degree',
    '1st degree burn': 'first-degree',
    'second degree burn': 'second-degree',
    'second degree': 'second-degree',
    '2nd degree burn': 'second-degree',
    'third degree burn': 'third-degree',
    'third degree': 'third-degree',
    '3rd degree burn': 'third-degree',
    'first-degree burn': 'first-degree',
    'second-degree burn': 'second-degree',
    'third-degree burn': 'third-degree',
  };

  @override
  void initState() {
    super.initState();
    _loadBurnData(widget.prediction);
  }

  // Normalize prediction: lower, remove punctuation, unify separators
  String _normalize(String s) {
    return s
        .trim()
        .toLowerCase()
        .replaceAll('`', "'")
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  // Convert normalized phrase to our internal keys: first-degree / second-degree / third-degree
  String _normalizeToKey(String prediction) {
    final normalized = _normalize(prediction);

    // Try alias dictionary first (handles "First Degree Burn", "0", etc.)
    final aliasKey = burnAliases[normalized];
    if (aliasKey != null) return aliasKey;

    // Fallback heuristics
    if (normalized.contains('first')) return 'first-degree';
    if (normalized.contains('second')) return 'second-degree';
    if (normalized.contains('third')) return 'third-degree';

    return 'unknown';
  }

  String _displayNameFromKey(String key) {
    switch (key) {
      case 'first-degree':
        return 'First Degree Burn';
      case 'second-degree':
        return 'Second Degree Burn';
      case 'third-degree':
        return 'Third Degree Burn';
      default:
        return 'Unknown';
    }
  }

  void _loadBurnData(String prediction) {
    final key = _normalizeToKey(prediction);

    setState(() {
      if (diseaseData.containsKey(key)) {
        diseaseName = _displayNameFromKey(key);
        aboutInfo = diseaseData[key]!['about'] ?? aboutInfo;
        symptoms = diseaseData[key]!['symptoms'] ?? symptoms;
        prevention = diseaseData[key]!['prevention'] ?? prevention;
        treatment = diseaseData[key]!['treatment'] ?? treatment;
        dangerLevel = diseaseData[key]!['dangerLevel'] ?? dangerLevel;
      } else {
        // keep defaults, but show what backend predicted
        diseaseName = prediction.isEmpty ? "Unknown" : prediction;
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
                                label: const Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Consult AI Assistant Now',
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.teal.shade50.withValues(alpha: 0.8),
            Colors.white.withValues(alpha: 0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.teal.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.shade100.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Image.asset(imagePath, width: 24, height: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
