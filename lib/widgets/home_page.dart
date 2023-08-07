import 'package:cv_viewer/widgets/cv_list_page.dart';
import 'package:cv_viewer/widgets/cv_profile_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text('CV Viewer',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  shadows: [
                    BoxShadow(
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      color: Theme.of(context).colorScheme.shadow,
                      offset: const Offset(2.0, 2.0),
                    ),
                    BoxShadow(
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      color: Theme.of(context).colorScheme.shadow,
                      offset: const Offset(-2.0, -2.0),
                    ),
                  ],
                )),
            bottom: TabBar(
              unselectedLabelColor:
              Theme.of(context).colorScheme.onPrimaryContainer,
              labelColor: Theme.of(context).colorScheme.onPrimary,
              indicatorColor: Theme.of(context).colorScheme.onPrimary,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.assignment)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CVListPage(),
              CVProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}
Color generateColor(String name) {
  int hashCode = name.hashCode;
  int r = (hashCode & 0xFF0000) >> 16;
  int g = (hashCode & 0x00FF00) >> 8;
  int b = (hashCode & 0x0000FF);
  return Color.fromARGB(255, r, g, b);
}
