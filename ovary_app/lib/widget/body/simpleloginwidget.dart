import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/vm/database_handler.dart';

class SimpleLoginWidget extends StatefulWidget {
  const SimpleLoginWidget({super.key});

  @override
  _SimpleLoginWidgetState createState() => _SimpleLoginWidgetState();
}

class _SimpleLoginWidgetState extends State<SimpleLoginWidget> {
  List<String> _password = List.filled(6, '');
  int _currentIndex = 0;
  String _passwordString = '';
  final box = GetStorage();

  void _handleNumberInput(String number) {
    if (_currentIndex < 6) {
      setState(() {
        _password[_currentIndex] = number;
        _currentIndex++;
      });
    }
  }

  void _handleBackspace() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _password[_currentIndex] = '';
      });
    }
  }

  void _handleSubmit() async {
  _passwordString = _password.join().toString(); // 리스트를 문자열로 변환
  print('입력한 비밀번호: $_passwordString'); // 콘솔에 출력

  final databaseHandler = DatabaseHandler();
String? storedPassword = await databaseHandler.getUserPassword(box.read('email'));
  if (storedPassword == _passwordString) {
    Get.back();
  } else {
    print("비밀번호 다름");
  }
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _password[index],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 숫자 버튼 행
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('1');
                },
                child: const Text('1'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('2');
                },
                child: const Text('2'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('3');
                },
                child: const Text('3'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('4');
                },
                child: const Text('4'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('5');
                },
                child: const Text('5'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('6');
                },
                child: const Text('6'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('7');
                },
                child: const Text('7'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('8');
                },
                child: const Text('8'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('9');
                },
                child: const Text('9'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _handleBackspace,
                child: const Icon(Icons.backspace),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _handleNumberInput('0');
                },
                child: const Text('0'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _currentIndex == 6 ? _handleSubmit : null,
                child: const Text('입력 완료'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}