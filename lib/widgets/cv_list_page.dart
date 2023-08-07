import 'package:cv_viewer/models/user.dart';
import 'package:cv_viewer/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_state.dart';

class CVListPage extends StatefulWidget {
  const CVListPage({super.key});

  @override
  State<CVListPage> createState() => _CVListPageState();
}

class _CVListPageState extends State<CVListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  var appState = context.watch<MyAppState>();
                  return ListTile(
                      tileColor: Theme.of(context).colorScheme.secondary,
                      leading: CircleAvatar(
                        backgroundColor: generateColor(user.name),
                        child: Text(user.name
                            .trim()
                            .split(' ')
                            .map((l) => l[0])
                            .take(2)
                            .join()),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.emailAddress),
                      onTap: () {
                        appState.setCurrentUser(user);
                        DefaultTabController.of(context).animateTo(1);
                      });
                },
                itemCount: users.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildUser(User user) {
    var appState = context.watch<MyAppState>();
    return ListTile(
        tileColor: Theme.of(context).colorScheme.secondary,
        leading: CircleAvatar(
          backgroundColor: generateColor(user.name),
          child:
          Text(user.name.trim().split(' ').map((l) => l[0]).take(2).join()),
        ),
        title: Text(user.name),
        subtitle: Text(user.emailAddress),
        onTap: () {
          appState.setCurrentUser(user);
          DefaultTabController.of(context).animateTo(1);
        });
  }
}
