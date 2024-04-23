import 'package:flutter/material.dart';

class FindPassWordWidget extends StatefulWidget {
  const FindPassWordWidget({super.key});

  @override
  State<FindPassWordWidget> createState() => _FindPassWordWidgetState();
}

class _FindPassWordWidgetState extends State<FindPassWordWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 188, 186, 186),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      '이메일을 입력하여 주세요',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      // controller: idController,
                      decoration: const InputDecoration(
                          labelText: 'ex)oneday@oneday.com',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // emailCheck(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8b7ff5),
                          foregroundColor: Colors.white),
                      child: const Text(
                        '인증키 발송',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}