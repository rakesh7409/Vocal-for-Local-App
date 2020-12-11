import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'login.dart';
import 'mainbody.dart';
import 'search.dart';
import 'submit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Tab/Category.dart';
import 'Tab/favourites.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'OpenSans'),
      initialRoute: '/',
      routes: {
        // When navigating to the "homeScreen" route, build the HomeScreen widget.
        '/': (context) => MyStatefulWidget(),
        '/logout': (context) => Loginform(),
        //: When navigating to the "secondScreen" route, build the SecondScreen widget.
        //'Login': (context) => Loginform(),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  bool isPlaying = false, isPlayinghome = false, isSearching = false;
  Animation animation;
  String stringValue;
  Position position;
  List<Placemark> place = [];
  AnimationController controller, homecontroller;
  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stringValue = prefs.getString('username');
    print(stringValue);
    return stringValue;
  }

  int currentTab = 0;
  String _counter, _value = "";

  final List<Widget> screens = [
    Listscroll(),
    Categories(),
    Favourites(),
    Searchitem(
      searchitem: "Hello",
    ),
  ];
  final searchController = TextEditingController();
  Widget currentScreen = Listscroll();
  final PageStorageBucket bucket = PageStorageBucket();
  Icon actionIcon = new Icon(Icons.search);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    this.getStringValuesSF();
    super.initState();
    controller = AnimationController(
        animationBehavior: AnimationBehavior.normal,
        duration: const Duration(milliseconds: 100),
        vsync: this);
    homecontroller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: currentTab != 4
          ? AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  semanticLabel: 'Show menu',
                ),
                color: Color.fromARGB(255, 2, 130, 121),
                onPressed: () {
                  _onpressed();
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              backgroundColor: Colors.white,
              title: Text(
                'Vocal For Local',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'OpenSans',
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search, size: 30, color: Colors.grey),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    setState(() {
                      currentTab = 4;
                      currentScreen = Listscroll();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                    semanticLabel: 'Show menu',
                  ),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                    setState(() {
                      home();
                      currentScreen = Listscroll();
                      currentTab = 0;
                    });
                  },
                  color: Colors.white,
                ),
              ],
            )
          : AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 1;
                    currentScreen = Listscroll();
                  });
                },
              ),
              backgroundColor: Colors.white,
              title: Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: TextField(
                  enabled: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          currentScreen = Searchitem(
                            searchitem: searchController.text.trim(),
                          );
                          currentTab = 1;
                        });
                      },
                    ),
                    hintText: 'Start Typing....',
                  ),
                  controller: searchController,
                ),
              ),
            ),
      drawer: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 252,
          height: 470,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(
                                '$stringValue',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 130, 121),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 145, 77),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/logout', (Route<dynamic> route) => false);
                  },
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(150, 2, 130, 121),
                  child: Card(
                    elevation: 10,
                    shape: CircleBorder(),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      "Contact us",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    "+91 XXXXXXXXX",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    "vocal@email.com",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 255, 145, 77),
        maxRadius: 40,
        child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 255, 145, 77),
            elevation: 5,
            onPressed: () async {
              _counter = await FlutterBarcodeScanner.scanBarcode(
                  "#004297", 'Cancel', true, ScanMode.BARCODE);
              setState(() {
                _value = _counter;
              });
              var _bar = _value.substring(0, 3);
              print(_bar);
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Card(
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: _bar == "890"
                            ? <Widget>[
                                Image(
                                  image: AssetImage("images/splash.jpeg"),
                                ),
                                Text(
                                  'This is an Indian Product',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RaisedButton(
                                  child: const Text('Explore More'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ]
                            : <Widget>[
                                Image(
                                  image: AssetImage("images/wrong3.jpg"),
                                ),
                                Text('This is not an Indian Product'),
                                RaisedButton(
                                  child: const Text('Explore More'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Image(
              image: AssetImage("images/QR.png"),
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 20,
        child: Container(
          color: Colors.grey[100],
          height: 60,
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = Categories();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Image(
                          image: AssetImage("images/category.png"),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  currentTab == 1 ? Colors.black : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(
                      () {
                        currentScreen = Favourites();
                        currentTab = 2;
                      },
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Icon(
                          currentTab == 2
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: currentTab == 2 ? Colors.black : Colors.grey,
                          size: 30,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Text(
                          "Favorites",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  currentTab == 2 ? Colors.black : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        color: Colors.blueGrey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageStorage(bucket: bucket, child: currentScreen),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  _onpressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? controller.forward() : controller.reverse();
    });
  }

  home() {
    setState(() {
      isPlayinghome = !isPlayinghome;
      isPlayinghome ? homecontroller.forward() : homecontroller.reverse();
    });
  }
}

/*
 void getPlace() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    double latitude = position.latitude;
    double longitude = position.longitude;
    List<Placemark> newPlace =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "$name, $subLocality, $locality";

    print(address);

    setState(() {
      _address = address; // update _address
    });
  }
  */
