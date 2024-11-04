import 'package:flutter/material.dart';
import 'package:koodiarana/services/Provider.dart';
import 'package:koodiarana/delayed_animation.dart';
import 'package:provider/provider.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});
  @override
  State<Page1> createState() => _Page1();
}

class _Page1 extends State<Page1> {
  int? selectionRadio;

  List<Widget> icons = [
    const Icon(
      Icons.map,
      size: 55,
    ),
    const Icon(
      Icons.add_task,
      size: 55,
    ),
    const Icon(
      Icons.person,
      size: 55,
    )
  ];
  List<String> names = ['Maps', 'Activite', 'Compte'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30.00, left: 16.00, right: 16.00),
        child: Column(
          children: [
            DelayedAnimation(
              delay: 100,
              child: GestureDetector(
                onTap: () {
                  Provider.of<BottomTabManager>(context, listen: false)
                      .changeTab(1);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 16.00),
                  padding: const EdgeInsets.all(16.00),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 129, 126, 126),
                      borderRadius: BorderRadius.circular(20.00)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Où allez-vous?',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                //  color: Colors.black,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.grey,
                      ),
                      timeGo()
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.00),
                itemCount: 3,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, i) {
                  return DelayedAnimation(
                      delay: 600,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<BottomTabManager>(context, listen: false)
                              .changeTab(i + 1);
                        },
                        child: Recipe(icon: icons[i], nom: names[i]),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeGo() {
    return Container(
      padding: const EdgeInsets.all(05.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.00),
        color: const Color.fromARGB(255, 97, 94, 94),
      ),
      width: 100,
      height: 220,
      child: const Row(children: [
        Icon(
          Icons.watch_later,
          size: 15,
        ),
        SizedBox(
          width: 5.00,
        ),
        Text('Quand?',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                //  color: Colors.black,
                fontSize: 15)),
      ]),
    );
  }
}

class Recipe extends StatelessWidget {
  final Widget? icon;
  final String? nom;
  const Recipe({super.key, this.icon, this.nom});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: icon,
            )),
            // const SizedBox(
            //   height: 10.00,
            // ),
            Text(
              nom!,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
