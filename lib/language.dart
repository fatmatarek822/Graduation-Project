import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Choose the Language',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Image(image: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/3898/3898840.png',

            ),
              height: 100,
              width: 100,
            ),

            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: MaterialButton(
                      onPressed: (){},
                      child: Text(
                          'Arabic',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: MaterialButton(
                      onPressed: (){},
                      child: Text(
                        'English',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
