import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/features/doctor/screens/doctor_details_screen.dart';
import 'package:skin/features/doctor/widgets/doctor_list_item.dart';
import 'package:skin/core/models/doctor_model.dart';
import 'package:skin/core/data/doctors_data.dart';

class DoctorSearch extends StatefulWidget {
  final String? initialQuery;
  const DoctorSearch({super.key, this.initialQuery});

  @override
  State<DoctorSearch> createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {
  final TextEditingController _searchController = TextEditingController();

  List<Doctor> _filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _filteredDoctors = List.from(doctorsList);
    if (widget.initialQuery != null) {
      _searchController.text = widget.initialQuery!;
      _filterDoctors(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredDoctors = List.from(doctorsList);
      } else {
        _filteredDoctors = doctorsList
            .where(
              (doctor) =>
                  doctor.name.toLowerCase().contains(query.toLowerCase()) ||
                  doctor.specialty.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 100,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Top Doctors", style: theme.textTheme.headlineSmall),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildSearchBar(theme),
              SizedBox(height: 2.h),
              Expanded(child: _buildDoctorList(context)),
            ],
          ),
        ),
      ),
    );
  }

  // ================= Search Bar =================

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TextField(
        controller: _searchController,
        onChanged: _filterDoctors,
        decoration: InputDecoration(
          hintText: "Search doctor, specialty...",
          prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _searchController.clear();
                    _filterDoctors("");
                  },
                )
              : null,
          filled: true,
          fillColor: theme.cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= Doctor List =================

  Widget _buildDoctorList(BuildContext context) {
    if (_filteredDoctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            SizedBox(height: 16),
            Text(
              "No doctors found",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 1.h),
      itemCount: _filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = _filteredDoctors[index];

        return DoctorListItem(
          doctor: doctor,
          onTap: () {
            Navigator.push(
              context,
              NoAnimationPageRoute(
                builder: (_) => DoctorDetails(doctor: doctor),
              ),
            );
          },
        );
      },
    );
  }

  ThemeData get theme => Theme.of(context);
}
