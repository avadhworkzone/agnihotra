import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sunrise_app/utils/color_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

const kGoogleApiKey = 'AIzaSyCotiIYalOfFMwIsvVPhwnFEGxPX-CtyYo';
final homeScaffoldKey = GlobalKey<ScaffoldState>();
class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  onSearch();
                },
                child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void>onSearch()async{

    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.overlay,
        language: 'en',
        strictbounds: false,
        onError:onError,
        types: [""],
      decoration: InputDecoration(
        hintText: "Search",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorUtils.white),
        ),
      ),
      components: [Component(Component.country, "in")],);
    displayPredction(p!,homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response){
 // homeScaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(response.errorMessage!),));
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPredction(Prediction p,ScaffoldState?currentState)async{

    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse details = await places.getDetailsByPlaceId(p.placeId!);

    final lat = details.result.geometry!.location.lat;
    final lng = details.result.geometry!.location.lng;
  }
}
