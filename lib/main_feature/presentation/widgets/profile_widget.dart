import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String name;

  const ProfileWidget({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, '+ name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Good Morning',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(width: 16),

        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage('https://avatar.iran.liara.run/username?username=$name&background=35A97A&color=FFFFFF'),
        ),
      ],
    );
  }
}
