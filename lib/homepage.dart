import 'package:dnd_roller/Single/single_page.dart';
import 'package:dnd_roller/Versus/versus_page.dart';
import 'package:flutter/material.dart';

class PlayerRollPage extends StatelessWidget {
  const PlayerRollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'DND Roller',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person, color: Colors.white,),
                child: Text(
                  "Single",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Tab(
                icon: Icon(Icons.people, color: Colors.white,),
                child: Text(
                  "Versus",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFEBE5F7),
        body: TabBarView(
          children: [
            SinglePage(),
            VersusPage()
          ],
        ),
      ),
    );
  }
}
