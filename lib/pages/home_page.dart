import 'package:flutter/material.dart';
import 'package:wpandflutterconnect/services/shared_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wordpress Dashboard'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                SharedService.logout(context);
              },
              icon: Icon(Icons.logout, color: Colors.black,)
          ),
          SizedBox(width: 10,),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
