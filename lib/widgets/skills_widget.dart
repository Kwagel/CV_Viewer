

import 'package:cv_viewer/my_app_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SkillsWidget extends StatefulWidget {
  const SkillsWidget({super.key});

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> skills =
        context.watch<MyAppState>().currentUser.skills;
    List<dynamic> technicalSkills = skills['technical'];
    List<dynamic> languages = skills['languages'];

    return DefaultTabController(
      length: 2,
      initialIndex: 0, // Set the initial tab index
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).colorScheme.secondary,
            tabs: const [
              Tab(text: 'Technical'),
              Tab(text: 'Languages'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTechnicalSkillsView(technicalSkills),
                _buildLanguageSkillsView(languages),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalSkillsView(List<dynamic> skills) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 4.0,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final skill = skills[index];
        return Card(
          color: Theme.of(context).colorScheme.background,
          elevation: 1.0,
          shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(8.0)), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(skill),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageSkillsView(List<dynamic> languages) {
    return ListView.separated(
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final language = languages[index]['language'];
        final languageProficiency =
        (languages[index]['languageProficiency']).toDouble();
        String proficiencyText = '';
        switch (languageProficiency.toInt()) {
          case 1:
            proficiencyText = 'Proficient';
            break;
          case 2:
            proficiencyText = 'Fluent';
            break;
          case 3:
            proficiencyText = 'Native';
            break;
          default:
            proficiencyText = 'N/A';
        }
        return ListTile(
            title: Row(
              children: [
                Text(language),
                const Spacer(),
                RatingBar(
                  itemCount: 3,
                  initialRating: languageProficiency,
                  allowHalfRating: false,
                  ignoreGestures: true,
                  itemSize: 30,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.circle,
                        color: Theme.of(context).colorScheme.primary),
                    half: Icon(Icons.circle_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    empty: Icon(Icons.circle_outlined,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  onRatingUpdate: (rating) {
                    if (kDebugMode) {
                      print(rating);
                    }
                  },
                ),
              ],
            ),
            subtitle: Text(
              proficiencyText,
              textAlign: TextAlign.right,
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
