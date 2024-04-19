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
        backgroundColor: Colors.pink[100],
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
                    color: Colors.pink[100],
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
                    color: Colors.pink[100],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if(chosenPeriodLength < 31){
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
                    color: Colors.pink[100],
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
                    color: Colors.pink[100],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if(chosenCycleLength < 31){
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
                updatePeriodInfo();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 50),
                backgroundColor: Colors.pink[300]
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

//FUNCTIONS


// UPDATE 'PERIOD' USING THE HARD CODED EMAIL
updatePeriodInfo() async {
    // Get the formatted date
    String formattedDate = DateFormat('yyyy-MM-dd').format(chosenDate!);

    // Create a map to hold the period info
    Map<String, dynamic> periodInfo = {
        'period': [formattedDate, chosenPeriodLength, chosenCycleLength]
    };

    // // Hardcoded email for testing purposes
    // String email = 'chosun@naver.com';


  // Retrieve the email value from the box
      String? email = box.read<String>('email');

      if (email == null) {
          print('Email not found in the box');
          return;
      }


    try {
        // Query Firestore to find the document that matches the hardcoded email
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        // If a document is found, update the period array
        if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot document = querySnapshot.docs.first;
            String documentId = document.id;

            // Update the 'period' array in the document
            await FirebaseFirestore.instance
                .collection('user')
                .doc(documentId)
                .update({'period': periodInfo['period']});

            // Show a Cupertino alert popup at the bottom of the screen
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                        title: Text("정보가 저장되었습니다!"),
                        actions: [
                            CupertinoDialogAction(
                                child: Text("확인"),
                                onPressed: () {
                                    // Dismiss the dialog
                                    Navigator.of(context).pop();
                                    // Go back to the previous screen
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
    }
}
}
