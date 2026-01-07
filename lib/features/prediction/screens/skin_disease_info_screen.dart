import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skin/core/data/doctors_data.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/features/chat/screens/doctor_chatbot_screen.dart';

class SkinDiseaseInfoScreen extends StatefulWidget {
  final String prediction;
  final String imagePath;

  const SkinDiseaseInfoScreen({
    super.key,
    required this.prediction,
    required this.imagePath,
  });

  @override
  State<SkinDiseaseInfoScreen> createState() => _SkinDiseaseInfoScreenState();
}

class _SkinDiseaseInfoScreenState extends State<SkinDiseaseInfoScreen> {
  bool isLoading = true;

  String diseaseName = "Unknown";
  String aboutInfo = "No information available.";
  String symptoms = "No information available.";
  String prevention = "No information available.";
  String treatment = "No information available.";
  String dangerLevel = "No information available.";

  final Map<String, Map<String, String>> diseaseData = {
    'acne': {
      'about':
          'Acne is a common skin condition that occurs when hair follicles become clogged with oil and dead skin cells.',
      'symptoms': 'Pimples, blackheads, whiteheads, cysts.',
      'prevention':
          'Keep skin clean, avoid greasy cosmetics, eat a healthy diet.',
      'treatment': 'Topical creams, antibiotics, laser therapy.',
      'dangerLevel': 'Low, but can cause scarring if untreated.',
    },
    'atopic': {
      'about':
          'Atopic dermatitis (eczema) is a condition that makes your skin red and itchy.',
      'symptoms': 'Itchy, dry, inflamed skin, rash.',
      'prevention':
          'Use gentle skin products, moisturize regularly, avoid triggers.',
      'treatment': 'Steroid creams, antihistamines.',
      'dangerLevel': 'Moderate, affects quality of life.',
    },
    'chickenpox': {
      'about':
          'Chickenpox is a contagious viral infection that causes an itchy rash.',
      'symptoms': 'Blisters, fever, fatigue.',
      'prevention': 'Vaccination, avoid infected people.',
      'treatment': 'Antivirals, calamine lotion.',
      'dangerLevel': 'Low, higher risk in adults.',
    },
    'eczema': {
      'about': 'Eczema causes red, inflamed, and itchy skin.',
      'symptoms': 'Dry skin, rash, itching.',
      'prevention': 'Moisturize, avoid triggers.',
      'treatment': 'Steroid creams, antihistamines.',
      'dangerLevel': 'Moderate.',
    },
    'melanoma': {
      'about': 'Melanoma is a serious form of skin cancer.',
      'symptoms': 'Changing or irregular moles.',
      'prevention': 'Sun protection, regular skin checks.',
      'treatment': 'Surgery, immunotherapy.',
      'dangerLevel': 'High.',
    },
    'vitiligo': {
      'about': 'Vitiligo causes loss of skin pigment.',
      'symptoms': 'White skin patches.',
      'prevention': 'No known prevention.',
      'treatment': 'Phototherapy, topical steroids.',
      'dangerLevel': 'Low.',
    },
  };

  @override
  void initState() {
    super.initState();
    _loadDiseaseData();
  }

  void _loadDiseaseData() {
    final key = widget.prediction.toLowerCase();

    if (diseaseData.containsKey(key)) {
      final data = diseaseData[key]!;

      diseaseName = key.toUpperCase();
      aboutInfo = data['about']!;
      symptoms = data['symptoms']!;
      prevention = data['prevention']!;
      treatment = data['treatment']!;
      dangerLevel = data['dangerLevel']!;
    }

    setState(() => isLoading = false);
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
                  children: [
                    _buildAppBar(context),
                    _buildImage(),
                    _buildContent(theme),
                  ],
                ),
              ),
      ),
    );
  }

  // ================= AppBar =================

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  // ================= Image =================

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.file(
          File(widget.imagePath),
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ================= Content =================

  Widget _buildContent(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                diseaseName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _section("About", aboutInfo),
            const SizedBox(height: 20),
            _section("Key Information", ""),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _infoCircle("Symptoms", symptoms, Icons.warning),
                _infoCircle("Prevention", prevention, Icons.shield),
                _infoCircle("Treatment", treatment, Icons.medical_services),
                _infoCircle("Danger", dangerLevel, Icons.local_fire_department),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Find a dermatologist (e.g., Dr. Ahmed Mansour)
                  final doctor = doctorsList.firstWhere(
                    (d) => d.specialty.contains("Dermatologist"),
                    orElse: () => doctorsList.first,
                  );
                  Navigator.push(
                    context,
                    NoAnimationPageRoute(
                      builder: (_) => DoctorChatBotScreen(doctor: doctor),
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
    );
  }

  Widget _section(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (content.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16)),
        ],
      ],
    );
  }

  Widget _infoCircle(String title, String content, IconData icon) {
    return Container(
      width: 155,
      height: 155,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.teal),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              content,
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }
}
