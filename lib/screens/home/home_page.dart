import 'package:flutter/material.dart';
import 'package:public_toilets/models/toilet.dart';
import 'package:public_toilets/repositories/toilet_repositorys.dart';
import 'package:public_toilets/screens/home/toilrt_list_item.dart'; // นำเข้าคลาส ToiletListItem

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _toiletNameController = TextEditingController();
  final _toiletPointController = TextEditingController(); // เพิ่ม controller สำหรับคะแนน
  final _toiletDistanceController = TextEditingController(); // เพิ่ม controller สำหรับระยะทาง

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Public Toilets')),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: ToiletRepository.toilets.length,
              itemBuilder: (ctx, i) {
                Toilet toilet = ToiletRepository.toilets[i];

                return ToiletListItem(
                  toilet: toilet,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _toiletNameController,
                  decoration: InputDecoration(
                    hintText: 'ชื่อห้องน้ำ',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.greenAccent,
                      ), //<-- SEE HERE
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _toiletPointController, // เพิ่ม controller สำหรับคะแนน
                        decoration: InputDecoration(
                          hintText: 'ให้คะแนน',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _toiletDistanceController, // เพิ่ม controller สำหรับระยะทาง
                        decoration: InputDecoration(
                          hintText: 'ระยะทาง',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      var toiletName = _toiletNameController.text;
                      var toiletPoint = double.parse(_toiletPointController.text); // ดึงค่าคะแนนจาก TextField
                      var toiletDistance = double.parse(_toiletDistanceController.text); // ดึงค่าระยะทางจาก TextField

                      var toilet = Toilet(name: toiletName, point: toiletPoint, distance: toiletDistance); // กำหนดคะแนนและระยะทางให้กับอ็อบเจกต์ Toilet

                      setState(() {
                        ToiletRepository.toilets.add(toilet);
                      });

                      _toiletNameController.clear();
                      _toiletPointController.clear();
                      _toiletDistanceController.clear();
                    },
                    child: Text('ADD'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
