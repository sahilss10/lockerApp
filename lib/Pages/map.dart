import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/helper/LOCKERS_data.dart';
import 'package:locker_app/Widget/BottomSheet.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locker_app/helper/helper_lists.dart';

class MapView extends StatefulWidget {
  @override
  State createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController controller;
  Position currentPosition ;
  String lock;
  Struct locker;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor myIcon;
 
  void _getCurrentLocation() async {

    final position = await Geolocator.getCurrentPosition();
    print(position);
    currentPosition=position;


  }
  void _currentLocation() async {

    LocationData currentLocation;
    final GoogleMapController _controller =  controller;


    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 12.0,
      ),
    )
    );
  }



  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    bool va=false;
    final MarkerId markerId = MarkerId(markerIdVal);
    if(specify['available locker']==0)
          va=true;


      final Marker marker = Marker(

          markerId: markerId,

          icon: va ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed): BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),

          position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
          infoWindow: InfoWindow(title: specify['name'],
              snippet: specify['available locker'].toString()),
          onTap: () {
            print(specifyId);
            setState(() {
              lock = specify['name'].toString();
              for (int i = 0; i < recentList.length; i++) {
                if (recentList[i].title == lock)
                     locker = recentList[i];
              }

              _showBottomSheet();
            });
          }

      );
      setState(() {
        markers[markerId] = marker;
      });

  }


  getMarkerData() async {
    Firestore.instance.collection('Locker').getDocuments().then((myMockDoc) {
      if (myMockDoc.documents.isNotEmpty) {
        for (int i = 0; i < myMockDoc.documents.length; i++) {

          initMarker(myMockDoc.documents[i].data, myMockDoc.documents[i].documentID);
        }
      }
    });
  }

  @override
  void initState() {

    _getCurrentLocation();
    getMarkerData();

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    if(currentPosition==null)
      currentPosition=new Position(latitude: 19.85,longitude: 75.25);

    return Scaffold(                      
      extendBodyBehindAppBar: true,
       key: _drawerKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child:
          GestureDetector(

            onTap: (){
              _drawerKey.currentState.openDrawer();},
            child:
            Icon(
              Icons.menu,
              color: Colors.blue.withOpacity(0.9),
              size: 26,
            ),
          ),
        ),
          title: Center(
            child: Text(
              'Lockers',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quickstand'),
            ),
          ),



          actions: <Widget>[




        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black.withOpacity(0.6),
              size: 20,
            ),
          ),
        ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Padding (
              padding: const EdgeInsets.only(top: 20),
            child:
          GoogleMap(
              markers: Set<Marker>.of(markers.values),
              mapType: MapType.normal,
              myLocationEnabled: true,

              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition:
              CameraPosition(target:LatLng(currentPosition.latitude,currentPosition.longitude) , zoom: 12.0),
              onMapCreated: (GoogleMapController _controller) {
                setState(() {
                  controller= _controller;
                });

              },

          ),



           ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28, top: 100, right: 28, bottom: 10),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide.none,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  title: TextField(
                    enabled: true,

                    decoration: InputDecoration.collapsed(
                        hintText: 'Search for a locker nearby',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            letterSpacing: 0.2)),
                  ),
                  trailing: Icon(
                    Icons.search,
                    size: 27,
                    color: Colors.orange[400],
                  ),
                ),
              ),
            ),
          ),



          Visibility(visible: _visibility, child: DraggableSheet(locker)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text("ramesh@gmail.com"),
              accountName: new Text("Ramesh"),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
//                        backgroundImage: new NetworkImage(currentProfilePic),
                ),
                onTap: () => print("This is your current account."),
              ),

              decoration: new BoxDecoration(
                color: Colors.indigo[500],
                /*image: new DecorationImage(
                            image: new NetworkImage(
                                "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                            fit: BoxFit.fill)*/
              ),
            ),
            new ListTile(
                title: new Text("Profile"),
                trailing: new Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => MapView()));
                }),
            new ListTile(
                title: new Text("Wallet"),
                trailing: new Icon(Icons.account_balance_wallet),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => MapView()));
                }),
            new ListTile(
                title: new Text("Transactions"),
                trailing: new Icon(Icons.monetization_on),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>MapView()));
                }),
            new Divider(),
            new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _currentLocation,

        label: Text(''),
        isExtended: false,
        splashColor: Colors.transparent,
        icon: Icon(Icons.location_on),
      ),
    );
  }

  bool _visibility = false;
  _showBottomSheet() {
    setState(() {
      if(!_visibility)
           _visibility = _visibility ? false : true;
    });
  }
}
