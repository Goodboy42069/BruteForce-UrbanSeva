import 'dart:convert';
import 'package:http/http.dart' as http;
import 'community_page.dart';
import 'announcements.dart';
import 'map_page.dart';
import 'select_problem.dart';
import 'signin_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'chatbot_screen.dart';

class Dashboard extends StatefulWidget {
  Color clr = Colors.grey;
  Color clr2 = Colors.grey;
  String user;
  Dashboard({super.key, required this.user});
  @override
  DashboardState createState() => DashboardState();
}

Future<Position> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location service is OFF');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permission is denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permission is permanently denied');
  }

  return await Geolocator.getCurrentPosition();
}

class DashboardState extends State<Dashboard> {
  Position? currentLocation;
  String loc = "Can't Find your location";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((position) {
      setState(() {
        currentLocation = position;
        reverseGeocode();
      });
      _livelocation();
    }).catchError((error) {
      print(error); // Handle location errors here
    });
  }

  void _livelocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {
        currentLocation = position;
      });
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location service is OFF';
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw 'Location permission is denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permission is permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  List<List<bool>> completedTasks = [
    [true, true, true, true, false],
    [true, true, false, false, false],
    [true, true, true, false, false]
  ];
  final List<Color> taskColors = [
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 251, 243, 176),
    const Color.fromARGB(255, 251, 189, 220),
  ];

  List<String> issue = [
    'Open Pothole',
    'Water Lodging',
    'Blocked Drains',
  ];

  List<String> sub = [
    'A Block, Street 14, Janakpuri West',
    'Maharaja Roaj, Tilak Nagar',
    '3 Block, Street 10, Tagore Garden',
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  user: widget.user,
                )),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Communities(user: widget.user)),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatBotScreen(
                  user: widget.user,
                )),
      );
    }
  }

  void reverseGeocode() async {
    var latitude = currentLocation?.latitude;
    var longitude = currentLocation?.longitude;
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.containsKey('display_name')) {
          loc = data['display_name'];
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21222D),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Announcements(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              //FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          //color: Colors.grey.shade100,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF21222D),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 12.0, 20.0),
                child: Image.asset(
                  'images/female.png',
                  height: 60,
                  width: 60,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    loc,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 9,
          color: const Color.fromARGB(255, 255, 255, 255),
          margin: const EdgeInsets.all(14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace the Icon with an Image widget
                Image.asset(
                  'images/map.png', // Provide the path to your image
                  width: 70, // Adjust the width as needed
                  height: 90, // Adjust the height as needed
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Issues Near You",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  // Pass the coordinates to MapScreen
                                  initialLatitude: currentLocation?.latitude,
                                  initialLongitude: currentLocation?.longitude,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "See various issues in your locality",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Issues",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: issue.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: taskColors[index],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            issue[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            sub[index],
                            style: const TextStyle(
                              color: Color.fromARGB(255, 3, 31, 54),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          tileColor: taskColors[index],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: completedTasks[index]
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final taskIndex = entry.key;
                                final completed = entry.value;
                                return Column(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: completed
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    if (taskIndex < completedTasks.length - 1)
                                      Container(
                                        width: 3,
                                        height: 29,
                                        color: completed
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                  ],
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Issue Registered",
                                    style: TextStyle(fontSize: 14)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Forwarded to authorities",
                                    style: TextStyle(fontSize: 14)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Action Initiated",
                                    style: TextStyle(fontSize: 14)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Action in Progress",
                                    style: TextStyle(fontSize: 14)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Resolved",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ])),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Chat Bot',
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 64.0),
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SelectComplaintTypePage()),
            );
          },
          backgroundColor: const Color(0xFF21222D),
          child: const Icon(
            Icons.add,
            size: 50.0,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
