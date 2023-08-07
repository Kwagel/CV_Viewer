import 'dart:ui';

import 'package:cv_viewer/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExperienceWidget extends StatefulWidget {
  const ExperienceWidget({super.key});

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    Set<Map<String, dynamic>> experience =
        context.watch<MyAppState>().currentUser.experience;
    var appState = context.read<MyAppState>();

    return Stack(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: experience.length,
          itemBuilder: (context, index) {
            final experienceItem = experience.elementAt(index);
            var startDate = DateFormat('MM/yyyy')
                .format(experienceItem['startDate'].toDate());
            var endDate = experienceItem['endDate']?.toDate();
            if (endDate != null) {
              endDate = DateFormat('MM/yyyy')
                  .format(experienceItem['endDate']?.toDate());
            } else {
              endDate = 'current ';
            }
            return InkWell(
              onTap: () {
                appState.setSelectedIndex(index);
                appState.toggleAchievements();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color:
                    appState.showAchievements && appState.selectedIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : null,
                child: ListTile(
                  title: Text(
                    experienceItem['company'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  subtitle: Text(
                    '$startDate - $endDate',
                    textAlign: TextAlign.right,
                  ),
                  leading: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, int) {
            return const Divider();
          },
        ),
        if (appState.showAchievements && appState.selectedIndex >= 0)
          Positioned.fill(
            child: AchievementsWidget(
              achievementsData: experience.elementAt(appState.selectedIndex),
            ),
          ),
      ],
    );
  }
}

class AchievementsWidget extends StatelessWidget {
  final Map<String, dynamic> achievementsData;

  const AchievementsWidget({required this.achievementsData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return GestureDetector(
      onTap: () {
        // Go back to the list of experiences
        appState.setAchievements(false);
        appState.setSelectedIndex(-1);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Blur effect color
              blurRadius: 10.0, // Adjust the blur radius as needed
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          // Adjust blur settings
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Achievements',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    achievementsData['achievements']
                            .map((item) => '\u2022 $item')
                            .join('\n') ??
                        '',
                  ),
                  // You can add more widgets to display additional achievement information
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
