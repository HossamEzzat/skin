import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/models/doctor_model.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/features/chat/data/services/ai_service.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/features/prediction/screens/skin_cancer_prediction_screen.dart';
import 'package:skin/features/prediction/screens/burn_prediction_screen.dart';

class DoctorChatBotScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorChatBotScreen({super.key, required this.doctor});

  @override
  State<DoctorChatBotScreen> createState() => _DoctorChatBotScreenState();
}

class _DoctorChatBotScreenState extends State<DoctorChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Static cache for session persistence
  static final Map<String, List<Map<String, dynamic>>> _sessionCache = {};

  List<Map<String, dynamic>> get _messages =>
      _sessionCache[widget.doctor.id] ??= [];

  bool _isTyping = false;
  late final AIService _aiService;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _aiService = AIService(doctor: widget.doctor);
    if (_messages.isEmpty) {
      _addBotMessage(
        "Hello! I am ${widget.doctor.name}'s virtual assistant. I specialize in skin health and diagnostic support. How can I help you today?",
      );
    }
  }

  void _addBotMessage(String text, {String? imagePath}) {
    setState(() {
      _isTyping = true;
    });

    // Simulate thinking/typing delay
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'text': text,
            'imagePath': imagePath,
            'isMe': false,
            'time': DateTime.now(),
          });
        });
        _scrollToBottom();
      }
    });
  }

  void _sendMessage({String? imagePath}) {
    final text = _messageController.text.trim();
    if (text.isEmpty && imagePath == null) return;

    setState(() {
      _messages.add({
        'text': text,
        'imagePath': imagePath,
        'isMe': true,
        'time': DateTime.now(),
      });
      _messageController.clear();
    });

    _scrollToBottom();
    _handleBotResponse(text, imagePath: imagePath);
  }

  void _handleBotResponse(String userText, {String? imagePath}) async {
    Uint8List? imageBytes;
    if (imagePath != null) {
      imageBytes = await File(imagePath).readAsBytes();
    }
    final response = await _aiService.getResponse(
      userText,
      imageBytes: imageBytes,
    );
    _addBotMessage(response);
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _sendMessage(imagePath: image.path);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList(theme)),
          _buildQuickActions(theme),
          if (_isTyping) _buildTypingIndicator(theme),
          _buildInputBar(theme),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeData theme) {
    final actions = [
      {
        'label': 'AI Skin Scanner',
        'icon': Icons.shutter_speed,
        'screen': const SkinDiseaseClassifier(),
      },
      {
        'label': 'AI Burn Scanner',
        'icon': Icons.local_fire_department,
        'screen': const BurnPredictionScreen(),
      },
      {
        'label': 'Book Appointment',
        'icon': Icons.calendar_month,
        'action': 'book',
      },
    ];

    return Container(
      height: 45,
      margin: EdgeInsets.only(bottom: 1.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final action = actions[index];
          return ActionChip(
            avatar: Icon(
              action['icon'] as IconData,
              size: 16,
              color: theme.colorScheme.primary,
            ),
            label: Text(
              action['label'] as String,
              style: theme.textTheme.labelMedium,
            ),
            onPressed: () {
              if (action.containsKey('screen')) {
                Navigator.push(
                  context,
                  NoAnimationPageRoute(
                    builder: (_) => action['screen'] as Widget,
                  ),
                );
              } else if (action['action'] == 'book') {
                _messageController.text = "I'd like to book an appointment.";
                _sendMessage();
              }
            },
            backgroundColor: theme.colorScheme.surfaceContainerHighest
                .withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide.none,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AppImage(
                imagePath: widget.doctor.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "AI Assistant",
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(ThemeData theme) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        final isMe = msg['isMe'];

        return _MessageBubble(
          message: msg['text'],
          imagePath: msg['imagePath'],
          isMe: isMe,
        );
      },
    );
  }

  Widget _buildTypingIndicator(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: _AnimatedTypingIndicator(),
      ),
    );
  }

  Widget _buildInputBar(ThemeData theme) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: _pickImage,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest
                      .withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.5.h,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 25,
              backgroundColor: theme.colorScheme.primary,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final String? imagePath;
  final bool isMe;

  const _MessageBubble({
    required this.message,
    this.imagePath,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 80.w),
            margin: EdgeInsets.only(
              bottom: 0.5.h,
              left: isMe ? 15.w : 0,
              right: isMe ? 0 : 5.w,
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              gradient: isMe
                  ? LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withBlue(220),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isMe
                  ? null
                  : theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isMe ? const Radius.circular(20) : Radius.zero,
                bottomRight: isMe ? Radius.zero : const Radius.circular(20),
              ),
              boxShadow: [
                if (isMe)
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(imagePath!),
                        width: 50.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (message.isNotEmpty)
                  isMe
                      ? Text(
                          message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        )
                      : MarkdownBody(
                          data: message,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            p: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                            strong: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
              ],
            ),
          ),
          if (!isMe)
            Padding(
              padding: EdgeInsets.only(left: 2.w, bottom: 1.5.h),
              child: Row(
                children: [
                  _FeedbackIcon(icon: Icons.thumb_up_outlined),
                  const SizedBox(width: 8),
                  _FeedbackIcon(icon: Icons.thumb_down_outlined),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _FeedbackIcon extends StatefulWidget {
  final IconData icon;
  const _FeedbackIcon({required this.icon});

  @override
  State<_FeedbackIcon> createState() => _FeedbackIconState();
}

class _FeedbackIconState extends State<_FeedbackIcon> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => setState(() => _isSelected = !_isSelected),
      child: Icon(
        widget.icon,
        size: 16,
        color: _isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withOpacity(0.3),
      ),
    );
  }
}

class _AnimatedTypingIndicator extends StatefulWidget {
  const _AnimatedTypingIndicator();

  @override
  State<_AnimatedTypingIndicator> createState() =>
      _AnimatedTypingIndicatorState();
}

class _AnimatedTypingIndicatorState extends State<_AnimatedTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final delay = index * 0.2;
              final value =
                  (sin((_controller.value * 2 * pi) - (delay * 2 * pi)) + 1) /
                  2;
              return Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(
                    0.3 + (value * 0.7),
                  ),
                  shape: BoxShape.circle,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
