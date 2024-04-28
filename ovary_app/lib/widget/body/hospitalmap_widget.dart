import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ovary_app/model/hospital.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../view/marker_detail_screen.dart';
// import 'package:flutter_google_places/flutter_google_places.dart' as loc;
// import 'package:google_api_headers/google_api_headers.dart' as header;
// import 'package:google_maps_webservice/places.dart' as places;

class HospitalMapWidget extends StatefulWidget {
  const HospitalMapWidget({super.key});

  @override
  State<HospitalMapWidget> createState() => _HospitalMapWidgetState();
}

class _HospitalMapWidgetState extends State<HospitalMapWidget> {
  late List data;

  final Map<String, Marker> _markers = {};
  Location location = Location();
  List<Map<String, dynamic>> places = []; 
  bool _hasCallSupport = false;
  Future<void>? _launched;

// 3d37.4944858
// 4d127.030066
  double latitude = 0;
  double longitude = 0;
  GoogleMapController? _controller;

  final CameraPosition _theJoeun = const CameraPosition(
    target: LatLng(37.4944858, 127.030066), // 더조은 강남아카데미 주소.
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    checkCanCall();
    
    data = [];
    getJsonData();
  }

  // mysql에 저장된 데이터를 가져옴.
  getJsonData() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/JSP/pcos/hospital_query_flutter.jsp'); // Rest API (json외에 다른것을 사용해도 됨)
    var response = await http.get(url);
    var dataConvertedJson = json.decode(utf8.decode(response
        .bodyBytes)); // response.bodyBytes는 Uint8Byte : utf가 8bit로 되어있어서 8bit만 가져옴.
    List result = dataConvertedJson['results'];
    data.addAll(result); // data에 가져온 데이터를 넣어줌.
      _markers.clear();
      // var hospital = "";
      for (final hospital in result) {
        setState(() {
        final marker = Marker(
          markerId: MarkerId(hospital['name']), // Map에서 'name' 필드에 접근합니다.
          position: LatLng(double.parse(hospital['lat']), double.parse(hospital['lng'])), // 'lat', 'lng' 필드에도 동일하게 접근합니다.
          infoWindow: InfoWindow(
            title: hospital['name'], // 'name' 필드에 접근합니다.
            snippet: hospital['phone'], // 'phone' 필드에 접근합니다.
          ),
          onTap: () {
            showHospitalInfo(hospital['name'], hospital['phone']);
          },

        );
        _markers[hospital['name']] = marker; 
        // places.addAll(result as Iterable<Map<String, dynamic>>);
        }); // async를 사용하기 때문에 어떤 것이 먼저 될지 몰라서 써줘용~~
      }
  }

  // 현재 위치 가져오기.
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData currentPosition = await location.getLocation();
    latitude = currentPosition.latitude!;
    longitude = currentPosition.longitude!;
    final marker = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(
        title: 'you can add any message here',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
        ),
      );
    });
  }

  // 전화연결권한.
  checkCanCall() {
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  // 전화연결.
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  // Functions  ---------
  showHospitalInfo(String name, String tel) {
    Get.bottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "images/hospital.png",
                      width: 80,
                    ),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5),
                      ),
                      Row(
                        children: [
                          Text(
                            tel,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: _hasCallSupport
                            ? () => setState(() {
                                  _launched = _makePhoneCall(tel);
                                })
                            : null,
                        child: _hasCallSupport
                            ? const Text('Make phone call')
                            : const Text('Calling not supported'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          // myLocationEnabled: true,
          myLocationButtonEnabled: false,
          initialCameraPosition: _theJoeun,
          markers: _markers.values.toSet(),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _getCurrentLocation,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 8, // 그림자 크기
            child: Icon(Icons.my_location),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글기
            ),
          ),
        ),
        Positioned(
          top: 10,
          child: CupertinoButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const MarkerDetailScreen()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 21,
              height: 44,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      '위치 검색',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 13.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
} // end