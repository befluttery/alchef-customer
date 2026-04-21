import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:alchef/core/utils/location_helper.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key, required this.onLocationSelect});

  final Function(Prediction prediction, String selectedAddress)
  onLocationSelect;

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final _placeController = TextEditingController();
  final _placeFocus = FocusNode();

  @override
  void initState() {
    _placeFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 36),
            GooglePlaceAutoCompleteTextField(
              focusNode: _placeFocus,
              containerVerticalPadding: 0,
              containerHorizontalPadding: 10,
              inputDecoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: false,
                hintText: 'Search places',
                prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              boxDecoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              textEditingController: _placeController,
              googleAPIKey: LocationHelper.mapAPIKEY,
              countries: const ["in"],
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (postalCodeResponse) {
                widget.onLocationSelect(
                  postalCodeResponse,
                  postalCodeResponse.description ?? '',
                );
              },
              itemClick: (Prediction prediction) {
                _placeController.text = prediction.description ?? '';
                _placeFocus.unfocus();
              },
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 7),
                      Expanded(child: Text(prediction.description ?? '')),
                    ],
                  ),
                );
              },
              seperatedBuilder: const Divider(),
              isCrossBtnShown: true,
              placeType: PlaceType.geocode,
            ),
          ],
        ),
      ),
    );
  }
}
