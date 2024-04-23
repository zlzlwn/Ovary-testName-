import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _hasCallSupport = false;
  Future<void>? _launched;
  Location location = Location();
  final Map<String, Marker> _markers = {};
  List<Map<String, dynamic>> places = [
    {
      'name': '나를위한산부인과의원',
      'tel': '02-539-5004',
      'latitude': 37.4955366,
      'longitude': 127.0293521,
    },
    {
      'name': '다움산부인과',
      'tel': '02-555-5799',
      'latitude': 37.4978931,
      'longitude': 127.0286404,
    },
    {
      'name': '애플산부인과의원 강남점',
      'tel': '02-530-8500',
      'latitude': 37.4979626,
      'longitude': 127.0264302,
    },
    {
      'name': '쉬즈웰산부인과',
      'tel': '02-564-2211',
      'latitude': 37.4999834,
      'longitude': 127.0259797,
    },
    {
      'name': '유로진여성의원',
      'tel': '02-555-7633',
      'latitude': 37.4993781,
      'longitude': 127.0310839,
    },
    {
      'name': '강남리즈산부인과',
      'tel': '02-558-5538',
      'latitude': 37.5008952,
      'longitude': 127.0266227,
    },
  ];
// 3d37.4944858
// 4d127.030066
  double latitude = 0;
  double longitude = 0;
  GoogleMapController? _controller;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.4944858, 127.030066), // 더조은 강남아카데미 주소.
    zoom: 15,
  );




  @override
  void initState() {
    getCurrentLocation();
    checkCanCall();
    super.initState();
  }

  // 현재 위치 가져오기.
  getCurrentLocation() async {
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
        // color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
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
                          // GestureDetector(
                          //   onTap: () {
                          //     _makePhoneCall(tel);
                          //     setState(() {

                          //     });
                          //   },
                          //   // child: const Icon(
                          //   //   Icons.phone,
                          //   //   color: Colors.deepPurple,
                          //   // ),
                          // ),
                        ],
                      ),
                      // ElevatedButton(
                      //   onPressed: () => _makePhoneCall(tel),
                      //   child: const Text('전화걸기'),
                      // ),
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
          myLocationEnabled: true,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(places.map((place) {
            return Marker(
              markerId: MarkerId(place['name']),
              position: LatLng(place['latitude'], place['longitude']),
              infoWindow: InfoWindow(title: place['name']),
              // infoWindow: InfoWindow(title: place['name'] +  "\n" + place['tel']),
              onTap: () {
                showHospitalInfo(place['name'], place['tel']);
              },
            );
          })),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
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