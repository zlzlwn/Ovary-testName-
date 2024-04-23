import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:ovary_app/view/period_calendar.dart';

class PeriodInput extends StatefulWidget {
  const PeriodInput({super.key});

  @override
  State<PeriodInput> createState() => _PeriodInputState();
}

class _PeriodInputState extends State<PeriodInput> {
  // Properties
  late DateTime? chosenDate = DateTime.now(); // Chosen date initialized to the current date
  late int chosenPeriodLength = 7; // Default period length initialized to 7 days
  late int chosenCycleLength = 28;

  // Get reference to GetStorage box
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // Format the chosen date to display as a human-readable string
    String formattedDate = chosenDate != null
        ? DateFormat('yyyy-MM-dd').format(chosenDate!)
        : '선택된 날짜 없음';

    return Scaffold(
      appBar: AppBar(
        title: const Text('생리주기 입력하기'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'images/menstrual-cycle.png',
              width: 150,
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    '생리 시작일:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // CupertinoDatePicker widget
            SizedBox(
              width: 300,
              height: 150,
              child: CupertinoDatePicker(
                initialDateTime: chosenDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    chosenDate = newDate; // Update the chosen date
                  });
                },
                minimumYear: 1900,
                maximumYear: DateTime.now().year,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '선택된 날짜: $formattedDate',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.grey,
              indent: 30,
              endIndent: 30,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    '생리 기간:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Row for the counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff8b7ff5).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (chosenPeriodLength > 1) {
                          chosenPeriodLength--;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$chosenPeriodLength 일',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff8b7ff5).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (chosenPeriodLength < 31) {
                          chosenPeriodLength++;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    '생리 주기:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Row for the counter of the cycle length
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff8b7ff5).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (chosenCycleLength > 1) {
                          chosenCycleLength--;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$chosenCycleLength 일',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                // Increment button with circular pink background
                Container(
                  decoration: BoxDecoration(
                    color:const Color(0xff8b7ff5).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (chosenCycleLength < 100) {
                          chosenCycleLength++;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                insertPeriodInfo();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 50),
                backgroundColor:Color(0xff8b7ff5),
              ),
              child: Text(
                '저장하기',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FUNCTIONS

  insertPeriodInfo() async {
    // Format the chosen date
    String formattedDate = DateFormat('yyyy-MM-dd').format(chosenDate!);

    // Retrieve the email from GetStorage
    String? email = box.read<String>('email');

    // Validate the existence of the email
    if (email == null) {
        print('Email not found in the GetStorage box');
        return;
    }

    try {
        // Query Firestore to find the document with the specified email
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        // Check if a document is found
        if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot document = querySnapshot.docs.first;
            String documentId = document.id;

            // Retrieve the existing data from the document
            Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

            // Get the 'period' map from data or initialize it as an empty map
            Map<String, dynamic>? periodMap = data?['period'] as Map<String, dynamic>? ?? {};

            // Create the new array for the period info
            List<dynamic> newPeriodInfo = [
                formattedDate,
                chosenPeriodLength,
                chosenCycleLength,
            ];

            // Create a timestamp as the key for the period array
            DateTime dateTime = DateTime.now();

            // Add the new array using the timestamp as the key in the 'period' map
            periodMap[dateTime.toString()] = newPeriodInfo;

            // Update the document with the modified 'period' map
            await FirebaseFirestore.instance
                .collection('user')
                .doc(documentId)
                .update({'period': periodMap});

            // Show a confirmation alert dialog to the user
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                        title: const Text("정보가 저장되었습니다!"),
                        actions: [
                            CupertinoDialogAction(
                                child: const Text("확인"),
                                onPressed: () {
                                    // Dismiss the dialog
                                    Navigator.of(context).pop();
                                    // Navigate to the Home screen
                                    Get.to(const PeriodCalender());
                                },
                            ),
                        ],
                    );
                },
            );
        } else {
            print('No document found with the specified email.');
        }
    } catch (error) {
        // Handle any errors that occur during the update
        print('Failed to update data: $error');

        // Optionally, show an error alert to the user
        showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
                return CupertinoAlertDialog(
                    title: const Text("데이터 업데이트 실패"),
                    content: Text("오류가 발생했습니다: $error"),
                    actions: [
                        CupertinoDialogAction(
                            child: const Text("확인"),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                );
            },
        );
    }
}

}