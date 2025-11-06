import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LangugeScreen extends StatefulWidget {
   LangugeScreen({Key? key}) : super(key: key);

  @override
  State<LangugeScreen> createState() => _LangugeScreenState();
}

class _LangugeScreenState extends State<LangugeScreen> {
   String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        title:Text('اللغة ',
          style: GoogleFonts.tajawal(
              fontWeight: FontWeight.bold,
              fontSize: 16

          ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [


            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                trailing: Radio<String>(
                  value: 'male',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                title: const Text('العربية'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                trailing: Radio<String>(
                  value: 'female',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                title: const Text('الانجليزية'),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
