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
        }
      },
      builder: (context, state) {
        final userName = state is AuthAuthenticated
            ? (state.user.name ?? state.user.email)
            : "Guest User";

        return Scaffold(
          body: Stack(
            children: [
              _HeaderBackground(theme),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _ProfileHeader(theme),
                      const SizedBox(height: 25),
                      _Avatar(),
                      const SizedBox(height: 15),
                      _UserName(name: userName),
                      const SizedBox(height: 30),
                      _ScanStatsCard(),
                      const SizedBox(height: 30),
                      _ProfileOptions(isLoading: state is AuthLoading),
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
}

/// ================= Gradient Header =================

class _HeaderBackground extends StatelessWidget {
  final ThemeData theme;
  const _HeaderBackground(this.theme);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.85),
            theme.colorScheme.secondary.withOpacity(0.6),
          ],
        ),
      ),
    );
  }
}

/// ================= AppBar Title =================

class _ProfileHeader extends StatelessWidget {
  final ThemeData theme;
  const _ProfileHeader(this.theme);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Profile",
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// ================= Avatar =================

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.15)),
        ],
        image: const DecorationImage(
          image: AssetImage("assets/icons/avatar.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// ================= Username =================

class _UserName extends StatelessWidget {
  final String name;
  const _UserName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

/// ================= Scan Stats =================

class _ScanStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ScanHistoryBloc, ScanHistoryState>(
      builder: (context, state) {
        final scans = state is ScanHistoryLoaded ? state.scans.length : 0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  color: Colors.black.withOpacity(0.06),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.document_scanner_rounded,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  "$scans",
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Total Scans",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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

/// ================= Options =================

class _ProfileOptions extends StatelessWidget {
  final bool isLoading;
  const _ProfileOptions({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          ProfileList(
            icon: Icons.history_rounded,
            title: "My Scan History",
            color: theme.colorScheme.onSurface,
            onTap: () {
              Navigator.push(
                context,
                NoAnimationPageRoute(builder: (_) => const ScanHistoryScreen()),
              );
            },
          ),
          _divider(theme),
          ProfileList(
            icon: Icons.logout_rounded,
            title: isLoading ? "Logging out..." : "Log out",
            color: theme.colorScheme.error,
            onTap: isLoading ? null : () => _showLogoutDialog(context),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(LogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("Confirm", maxLines: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10),
      child: Divider(color: theme.dividerColor),
    );
  }
}
