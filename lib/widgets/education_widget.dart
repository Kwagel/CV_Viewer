import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';

class EducationWidget extends StatefulWidget {
  const EducationWidget({super.key});

  @override
  State<EducationWidget> createState() => _EducationWidgetState();
}

class _EducationWidgetState extends State<EducationWidget> {
  @override
  Widget build(BuildContext context) {
    Set<Map<String, dynamic>> education =
        context.watch<MyAppState>().currentUser.education;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: education.length,
      itemBuilder: (context, index) {
        final educationItem = education.elementAt(index);

        List<Map<String, dynamic>> achievements =
        List<Map<String, dynamic>>.from(
            educationItem['achievements'] ?? []);

        return ListTile(
          title: Text(educationItem['institute'] ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var achievement in achievements)
                Row(
                  children: [
                    Text(
                      achievement['qualification'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    const Spacer(),
                    Text(
                      '${(achievement['grade'] != null && (achievement['grade'].toString().length < 10)) ? achievement['grade'] : 'N/A'}',
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
