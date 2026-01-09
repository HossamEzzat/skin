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
    'Acne': {
      'about':
      'Acne is a common skin condition that occurs when hair follicles become clogged with oil and dead skin cells.',
      'symptoms': 'Pimples, blackheads, whiteheads, cysts.',
      'prevention':
      'Keep skin clean, avoid oily cosmetics, maintain a healthy diet.',
      'treatment': 'Topical retinoids, antibiotics, benzoyl peroxide.',
      'dangerLevel': 'Low to Moderate.',
    },
    'Atopic Dermatitis': {
      'about':
      'Atopic dermatitis is a chronic inflammatory skin condition causing itchy and inflamed skin.',
      'symptoms': 'Itching, redness, dry and cracked skin.',
      'prevention': 'Moisturize regularly, avoid allergens and harsh soaps.',
      'treatment': 'Topical corticosteroids, antihistamines.',
      'dangerLevel': 'Moderate.',
    },
    'Chicken Skin': {
      'about':
      'Chicken skin (keratosis pilaris) is a harmless condition where small bumps appear on the skin.',
      'symptoms': 'Rough, small bumps on arms, thighs, cheeks.',
      'prevention': 'Gentle exfoliation and moisturizing.',
      'treatment': 'Urea creams, lactic acid lotions.',
      'dangerLevel': 'Low.',
    },
    'Eczema': {
      'about': 'Eczema causes inflamed, itchy, and irritated skin.',
      'symptoms': 'Dry skin, redness, itching, scaling.',
      'prevention': 'Avoid triggers, moisturize frequently.',
      'treatment': 'Steroid creams, emollients.',
      'dangerLevel': 'Moderate.',
    },
    'Eruptive Xanthoma': {
      'about':
      'Eruptive xanthomas are yellowish skin lesions associated with high triglyceride levels.',
      'symptoms': 'Small yellow-red bumps, usually on arms and legs.',
      'prevention': 'Control cholesterol and blood sugar levels.',
      'treatment': 'Lipid-lowering medications, lifestyle changes.',
      'dangerLevel': 'Moderate (systemic risk).',
    },
    'Hansen`s Disease/Leprosy': {
      'about':
      'Leprosy is a chronic infectious disease caused by Mycobacterium leprae.',
      'symptoms': 'Skin lesions, numbness, nerve damage.',
      'prevention': 'Early diagnosis and treatment.',
      'treatment': 'Multi-drug antibiotic therapy.',
      'dangerLevel': 'High if untreated.',
    },
    'Hansen`s Disease/Leprosy- severe': {
      'about': 'Severe leprosy causes extensive nerve damage and deformities.',
      'symptoms': 'Severe numbness, ulcers, deformities.',
      'prevention': 'Early aggressive treatment.',
      'treatment': 'Long-term multidrug therapy and rehabilitation.',
      'dangerLevel': 'Very High.',
    },
    'Healthy Skin': {
      'about': 'Healthy skin shows no signs of disease or infection.',
      'symptoms': 'Normal color, smooth texture.',
      'prevention': 'Good hygiene, sun protection.',
      'treatment': 'No treatment required.',
      'dangerLevel': 'None.',
    },
    'Leukocytoclastic Vasculitis': {
      'about': 'A condition involving inflammation of small blood vessels in the skin.',
      'symptoms': 'Purpura, red spots, ulcers.',
      'prevention': 'Treat underlying cause.',
      'treatment': 'Steroids, immunosuppressants.',
      'dangerLevel': 'High.',
    },
    'Psoriasis': {
      'about':
      'Psoriasis is an autoimmune condition that causes rapid skin cell buildup.',
      'symptoms': 'Red patches with silvery scales.',
      'prevention': 'Avoid triggers, manage stress.',
      'treatment': 'Topical treatments, biologics.',
      'dangerLevel': 'Moderate to High.',
    },
    'Purpura': {
      'about': 'Purpura appears as purple spots due to bleeding under the skin.',
      'symptoms': 'Purple or red skin patches.',
      'prevention': 'Manage underlying conditions.',
      'treatment': 'Depends on cause.',
      'dangerLevel': 'Moderate.',
    },
    'Ringworm': {
      'about': 'Ringworm is a fungal infection affecting the skin.',
      'symptoms': 'Circular red rash, itching.',
      'prevention': 'Keep skin dry, avoid sharing personal items.',
      'treatment': 'Antifungal creams or oral medication.',
      'dangerLevel': 'Low.',
    },
    'Spider Angioma': {
      'about':
      'Spider angiomas are clusters of dilated blood vessels near the skin surface.',
      'symptoms': 'Red spot with radiating vessels.',
      'prevention': 'Avoid liver disease risk factors.',
      'treatment': 'Laser therapy if needed.',
      'dangerLevel': 'Low.',
    },
    'Vitiligo': {
      'about': 'Vitiligo causes loss of skin pigment.',
      'symptoms': 'White patches on the skin.',
      'prevention': 'No known prevention.',
      'treatment': 'Phototherapy, topical steroids.',
      'dangerLevel': 'Low.',
    },
    'Warts': {
      'about': 'Warts are caused by human papillomavirus (HPV).',
      'symptoms': 'Small rough skin growths.',
      'prevention': 'Avoid direct contact, maintain hygiene.',
      'treatment': 'Cryotherapy, salicylic acid.',
      'dangerLevel': 'Low.',
    },
    'Xanthelasma': {
      'about':
      'Xanthelasma are yellowish deposits of cholesterol around the eyes.',
      'symptoms': 'Soft yellow plaques near eyelids.',
      'prevention': 'Control cholesterol levels.',
      'treatment': 'Laser removal or surgery.',
      'dangerLevel': 'Low (but indicates lipid disorder).',
    },
  };

  // ---------- Case-insensitive + punctuation-tolerant lookup ----------

  String _normalizeKey(String s) {
    return s
        .trim()
        .toLowerCase()
        .replaceAll('`', "'") // handle backtick vs apostrophe
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ') // remove punctuation
        .replaceAll(RegExp(r'\s+'), ' ') // collapse spaces
        .trim();
  }

  String _toTitleCase(String s) {
    final cleaned = s.trim();
    if (cleaned.isEmpty) return cleaned;
    return cleaned
        .split(RegExp(r'\s+'))
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  @override
  void initState() {
    super.initState();
    _loadDiseaseData();
  }

  void _loadDiseaseData() {
    final normalizedPrediction = _normalizeKey(widget.prediction);

    // Build normalized map: normalizedKey -> originalKey
    final Map<String, String> normalizedToOriginalKey = {
      for (final originalKey in diseaseData.keys) _normalizeKey(originalKey): originalKey,
    };

    final originalKey = normalizedToOriginalKey[normalizedPrediction];

    if (originalKey != null) {
      final data = diseaseData[originalKey]!;

      diseaseName = originalKey; // keep nice display name
      aboutInfo = data['about'] ?? "No information available.";
      symptoms = data['symptoms'] ?? "No information available.";
      prevention = data['prevention'] ?? "No information available.";
      treatment = data['treatment'] ?? "No information available.";
      dangerLevel = data['dangerLevel'] ?? "No information available.";
    } else {
      // fallback if no match
      diseaseName = _toTitleCase(widget.prediction);
      aboutInfo = "No information available for this condition.";
      symptoms = "No information available.";
      prevention = "No information available.";
      treatment = "No information available.";
      dangerLevel = "No information available.";
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
