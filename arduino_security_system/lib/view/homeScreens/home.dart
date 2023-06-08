import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.35,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black
                    ),
                    child: const Text("Camera snapshot", style: TextStyle(color: Colors.white),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black
                      ),
                      child: const Text("Buzzer Status", style: TextStyle(color: Colors.white),),
                    ),
                  ),)

              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black
                      ),
                      child: const Text("Alarm ON", style: TextStyle(color: Colors.white),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.35,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black
                        ),
                        child: const Text("Alarm OFF", style: TextStyle(color: Colors.white),),
                      ),
                    ),)


                ],
              ),
            )

          ],
        )
      )
    );
  }
}
