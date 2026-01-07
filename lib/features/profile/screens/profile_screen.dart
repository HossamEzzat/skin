import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skin/features/auth/presentation/bloc/auth_event.dart';
import 'package:skin/features/auth/presentation/bloc/auth_state.dart';
import 'package:skin/features/auth/screens/login_screen.dart';
import 'package:skin/features/profile/widgets/profile_list.dart';
import 'package:skin/features/scan_history/presentation/bloc/scan_history_bloc.dart';
import 'package:skin/features/scan_history/presentation/bloc/scan_history_event.dart';
import 'package:skin/features/scan_history/presentation/bloc/scan_history_state.dart';
import 'package:skin/features/scan_history/screens/scan_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            NoAnimationPageRoute(builder: (_) => const LoginScreen()),
            (_) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final userName = state is AuthAuthenticated
            ? (state.user.name ?? state.user.email)
            : "Guest User";

        return Scaffold(
          body: Stack(
            children: [
              // 1. Premium Gradient / Background
              _buildBackground(theme),

              // 2. Content
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildAppBar(context, theme),
                      const SizedBox(height: 20),
                      _ProfileAvatar(theme),
                      const SizedBox(height: 20),
                      _UserName(theme: theme, name: userName),
                      const SizedBox(height: 30),
                      _HealthStatsGrid(theme),
                      const SizedBox(height: 30),
                      _ProfileOptions(
                        theme: theme,
                        isLoading: state is AuthLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackground(ThemeData theme) {
    return Container(
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.8),
            theme.colorScheme.secondary.withOpacity(0.6),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Text(
        "Profile",
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// ================= Profile Avatar =================

class _ProfileAvatar extends StatelessWidget {
  final ThemeData theme;
  const _ProfileAvatar(this.theme);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: 5,
              color: Colors.black.withOpacity(0.15),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage("assets/icons/avatar.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/// ================= Username =================

class _UserName extends StatelessWidget {
  final ThemeData theme;
  final String name;

  const _UserName({required this.theme, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }
}

/// ================= Stats =================

class _HealthStatsGrid extends StatelessWidget {
  final ThemeData theme;
  const _HealthStatsGrid(this.theme);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanHistoryBloc, ScanHistoryState>(
      builder: (context, state) {
        int scanCount = 0;
        if (state is ScanHistoryLoaded) {
          scanCount = state.scans.length;
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.document_scanner_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "$scanCount",
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Scans",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ================= Profile Options =================

class _ProfileOptions extends StatefulWidget {
  final ThemeData theme;
  final bool isLoading;

  const _ProfileOptions({required this.theme, required this.isLoading});

  @override
  State<_ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<_ProfileOptions> {
  int scanCount = 0;

  @override
  void initState() {
    super.initState();
    _loadScanCount();
  }

  void _loadScanCount() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ScanHistoryBloc>().add(LoadScanHistory(authState.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanHistoryBloc, ScanHistoryState>(
      listener: (context, state) {
        if (state is ScanHistoryLoaded) {
          setState(() {
            scanCount = state.scans.length;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: widget.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 32),
            _option(
              context,
              icon: Icons.history_rounded,
              title: "My Scan History",
              onTap: () {
                Navigator.push(
                  context,
                  NoAnimationPageRoute(
                    builder: (_) => const ScanHistoryScreen(),
                  ),
                );
              },
            ),
            _divider(widget.theme),
            ProfileList(
              icon: Icons.logout_rounded,
              title: widget.isLoading ? "Logging out..." : "Log out",
              color: widget.theme.colorScheme.error,
              onTap: widget.isLoading ? null : () => _showLogoutDialog(context),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to exit your session?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: widget.theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(LogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.theme.colorScheme.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  Widget _option(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ProfileList(
      icon: icon,
      title: title,
      color: widget.theme.colorScheme.onSurface,
      onTap: onTap ?? () {},
    );
  }

  Widget _divider(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Divider(color: theme.dividerColor),
    );
  }
}
