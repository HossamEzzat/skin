import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:skin/core/models/doctor_model.dart';
import 'dart:developer' as dev;

class AIService {
  final Doctor doctor;

  // WARNING: Set your Gemini API Key here or provide it via environment variables
  static const String _apiKey = "YOUR_GEMINI_API_KEY_HERE";

  AIService({required this.doctor});

  String get _systemPrompt =>
      """
You are a highly compassionate and professional medical AI assistant specialized in skin health. 
Your mission is to support users with concerns regarding skin cancer (melanoma), burns, and general dermatology.
You are representing ${doctor.name}, a distinguished ${doctor.specialty} specialist.

App Mission:
We exist to revolutionize skin health through early detection. We combine advanced AI diagnostics with expert human care to save lives and provide rapid relief for skin ailments.

Tone and Style:
- Professional yet deeply empathetic.
- Clear and clinical, but easy for a layperson to understand.
- Always supportive, never dismissive.

Guidelines:
1. ALWAYS introduce yourself clearly as ${doctor.name}'s virtual assistant.
2. If an image is provided: "I have received the image. While I am an AI and cannot provide a definitive medical diagnosis, I can analyze the visual patterns to assist ${doctor.name} in their review."
3. Skin Cancer/Moles: Look for "ABCDE" indicators (Asymmetry, Border, Color, Diameter, Evolving). If detected, gently urge them to use the "AI Skin Scanner" chip and book an appointment immediately.
4. Burns: Provide immediate first aid (cool running water for 20 mins, no ice/butter). For 2nd/3rd degree signs (blisters, charring), urge professional care.
5. NO DIAGNOSIS: Use "This appears consistent with..." or "This warrants a professional examination by ${doctor.name}."
6. MISSION: If asked, speak passionately about our goal of early detection and how AI empowers patients.
""";

  late final GenerativeModel _model;
  ChatSession? _chatSession;

  void _initModel() {
    if (_apiKey == "YOUR_GEMINI_API_KEY_HERE") {
      dev.log("Gemini API Key not set. Using simulator mode.");
      return;
    }
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 1024,
      ),
      systemInstruction: Content.system(_systemPrompt),
    );
    _chatSession = _model.startChat();
  }

  Future<String> getResponse(
    String userMessage, {
    Uint8List? imageBytes,
  }) async {
    if (_apiKey == "YOUR_GEMINI_API_KEY_HERE") {
      return _getSimulatedResponse(userMessage, hasImage: imageBytes != null);
    }

    try {
      if (_chatSession == null) _initModel();

      final response = await _chatSession!.sendMessage(
        imageBytes != null
            ? Content.multi([
                TextPart(
                  userMessage.isEmpty
                      ? "Please analyze this skin concern."
                      : userMessage,
                ),
                DataPart('image/jpeg', imageBytes),
              ])
            : Content.text(userMessage),
      );

      return response.text ??
          "I'm sorry, I couldn't process that. Please try again.";
    } catch (e) {
      dev.log("Error calling Gemini API: \$e");
      return "I'm having trouble connecting to my brain right now. Please try again in a moment.";
    }
  }

  /// Fallback simulator with vision-aware logic
  Future<String> _getSimulatedResponse(
    String userMessage, {
    bool hasImage = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final text = userMessage.toLowerCase();

    if (text.contains("hello") || text.contains("hi")) {
      return "Hello! I am \${doctor.name}'s assistant. How can I help you with your skin health today?";
    }

    if (hasImage) {
      return "I've received your photo. I'm analyzing the visual patterns now... \n\nBased on the image, I've noted some specific features. While I'm not a doctor, this warrants a closer look. I recommend using the 'AI Skin Scanner' for a detailed analysis and booking a consultation with ${doctor.name} for a definitive diagnosis.";
    }

    if (text.contains("mission")) {
      return "Our mission is to save lives through early detection. By combining AI with expert care from specialists like \${doctor.name}, we ensure no skin concern goes unaddressed.";
    }

    if (text.contains("cancer") || text.contains("mole")) {
      return "I understand your concern. Any change in a mole's size, shape, or color should be evaluated. Please use our 'AI Skin Scanner' and book an appointment with \${doctor.name} as soon as possible.";
    }

    if (text.contains("burn")) {
      return "For burns, please run cool tap water over the area for 20 minutes immediately. Avoid using ice or ointments. If you see blisters or charring, seek urgent care.";
    }

    return "I've noted your concern. ${doctor.name} will review this soon. Is there anything else I can clarify for you?";
  }
}
