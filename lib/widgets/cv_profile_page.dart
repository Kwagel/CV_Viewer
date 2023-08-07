import 'package:cv_viewer/widgets/home_page.dart';
import 'package:cv_viewer/widgets/skills_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';
import 'education_widget.dart';
import 'experience_widget.dart';

class CVProfilePage extends StatelessWidget {
  const CVProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<MyAppState>().currentUser;

    if (user.name == '') {
      return const Center(
        child: Text('No user selected'),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .inversePrimary, // Set the border color
                width: 5.0, // Set the border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: generateColor(user.name),
              minRadius: 70,
              child: Text(
                  user.name.trim().split(' ').map((l) => l[0]).take(2).join()),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Text(
              user.phoneNumber.toString(),
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Text(
            user.emailAddress,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 20),
          DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor:
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      text: 'Experience',
                    ),
                    Tab(
                      text: 'Education',
                    ),
                    Tab(
                      text: 'Skills',
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Add spacing
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const TabBarView(
                      children: [
                        ExperienceWidget(),
                        EducationWidget(),
                        SkillsWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
