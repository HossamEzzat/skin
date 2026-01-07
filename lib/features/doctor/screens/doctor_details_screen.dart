import 'package:flutter/material.dart';
import 'package:skin/core/models/doctor_model.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/features/chat/screens/doctor_chatbot_screen.dart';
import 'package:skin/features/doctor/widgets/doctor_list_item.dart';

class DoctorDetails extends StatefulWidget {
  final Doctor doctor;
  const DoctorDetails({super.key, required this.doctor});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool showFullAbout = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(theme),
        body: Stack(
          children: [_buildContent(theme), _buildBottomBar(context, theme)],
        ),
      ),
    );
  }

  // ================= AppBar =================

  AppBar _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 100,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text("Doctor Details", style: theme.textTheme.headlineSmall),
    );
  }

  // ================= Main Content =================

  Widget _buildContent(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 110),
      child: Column(
        children: [
          const SizedBox(height: 10),

          DoctorListItem(doctor: widget.doctor),

          const SizedBox(height: 20),

          _buildAboutSection(theme),
        ],
      ),
    );
  }

  // ================= About =================

  Widget _buildAboutSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              showFullAbout
                  ? widget.doctor.about
                  : (widget.doctor.about.length > 120
                        ? "${widget.doctor.about.substring(0, 120)}..."
                        : widget.doctor.about),
              style: theme.textTheme.bodyMedium,
            ),
            if (widget.doctor.about.length > 120)
              GestureDetector(
                onTap: () => setState(() => showFullAbout = !showFullAbout),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    showFullAbout ? "Read less" : "Read more",
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ================= Bottom Bar =================

  Widget _buildBottomBar(BuildContext context, ThemeData theme) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 85,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    NoAnimationPageRoute(
                      builder: (_) =>
                          DoctorChatBotScreen(doctor: widget.doctor),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.smart_toy_outlined),
                    const SizedBox(width: 8),
                    const Text(
                      "Chat with Doctor",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
