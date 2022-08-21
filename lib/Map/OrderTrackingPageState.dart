import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPageState extends StatefulWidget {
  const OrderTrackingPageState({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPageState> createState() => _OrderTrackingPageStateState();
}


class _OrderTrackingPageStateState extends State<OrderTrackingPageState> {

  var default_color=Color(0xff1e319d);

  final Completer<GoogleMapController> _mapComplete=Completer();


  final String apiKey="AIzaSyCFiS3J95syNrmbl4JjQpWr8po9vXLzJvw";
  //24.979096518741585, 67.06318117183045
  //24.91736990299332, 67.040078319934
    LatLng sourceLocation =LatLng(24.979096518741585, 67.06318117183045);
    LatLng destination =LatLng(24.91736990299332, 67.040078319934);

  List<LatLng> polylineCordinate=[];

  LocationData? currentLocation;

  BitmapDescriptor sourceIcon=BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon=BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon=BitmapDescriptor.defaultMarker;

  void setCustomMarker(){
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,"assets/icons/rider.png")
        .then((icon) {
          currentIcon=icon;

    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,"assets/icons/dropmarker.png")
        .then((icon) {
      destinationIcon=icon;

    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,"assets/icons/userlocation.svg")
        .then((icon) {
      sourceIcon=icon;

    });
  }
  void getPolyLine() async{

    PolylinePoints polylinePoints=PolylinePoints();

    PolylineResult result=await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng pointLatLng) { 
        polylineCordinate.add(LatLng(pointLatLng.latitude,pointLatLng.longitude));
      });
    }

    setState((){});

  }
  void getCurrentLocation() async{
    Location location=Location();
    location.getLocation().then((location) {
      currentLocation=location;
      setState((){});

    });
    GoogleMapController googleMapController=await _mapComplete.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation=newLoc;
      
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target:  LatLng(newLoc.latitude!,newLoc.longitude!),
          zoom: 16
          ))
      );

      setState((){});
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    setCustomMarker();
    getCurrentLocation();
    getPolyLine();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Track Parcel"),
        centerTitle: true,
        backgroundColor: default_color,
      ),
      body:
      currentLocation==null?Center(child: CupertinoActivityIndicator()):

      GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
            zoom: 15),
        markers: {
          Marker(
              markerId: MarkerId("csource"),
              position:  LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
            icon: currentIcon
          ),
          Marker(
            markerId: MarkerId("source"),
            position: sourceLocation
          ),
          Marker(
              markerId: MarkerId("destination"),
              position: destination
          ),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCordinate,
            color: Colors.blue,
            width: 6

          )
        },
        onMapCreated: (mapConroller){
           _mapComplete.complete(mapConroller);
        },
      ),

    );
  }
}
