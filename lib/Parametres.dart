import 'package:flutter/material.dart';

class Parametres extends StatefulWidget {
  const Parametres({super.key});
  @override
  State<Parametres> createState() => _Parametres();
}

class _Parametres extends State<Parametres> {
  bool toogle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              toogle ? const Color.fromARGB(255, 107, 108, 109) : Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          color:
              toogle ? const Color.fromARGB(255, 107, 108, 109) : Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16.00, top: 5.00, right: 16.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Parametres',
                  style:
                      TextStyle(fontSize: 27.00, fontWeight: FontWeight.w700),
                ),
                ListTile(
                  leading: Icon(
                    Icons.sunny,
                    color: toogle ? Colors.white : Colors.grey,
                  ),
                  title: const Text(
                    'Mode Sombre',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Switch(
                      activeColor: Colors.black,
                      value: toogle,
                      onChanged: (value) {
                        setState(() {
                          toogle = !toogle;
                        });
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
