import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fasta/shipping/domain/entity/coordinate.dart';
import 'package:fasta/typedef.dart/typedefs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

extension GeoString on String {
  /// get current [Coordinate] from Start Address
  Future<Either<ErrorMessage, Coordinate>> currentCoordinateFromAddress(
      {Position? currentPosition, String? currentAddress}) async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(this);

      // Use the retrieved Coordinate of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = this == currentAddress
          ? currentPosition?.latitude ?? startPlacemark[0].latitude
          : startPlacemark[0].latitude;

      double startLongitude = this == currentAddress
          ? currentPosition?.longitude ?? startPlacemark[0].longitude
          : startPlacemark[0].longitude;
      String addressUsed =
          this == currentAddress ? currentAddress ?? this : this;
      return Right(Coordinate(
          latitude: startLatitude,
          longitude: startLongitude,
          parentAddress: addressUsed));
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Get  [Coordinate] from Destination Address
  Future<Either<ErrorMessage, Coordinate>>
      destinationCoordinateFromAddress() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> destinationPlacemark = await locationFromAddress(this);
      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;
      return Right(Coordinate(
          latitude: destinationLatitude,
          longitude: destinationLongitude,
          parentAddress: this));
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Get  [Coordinate] from Destination Address
  Future<Coordinate> getCoordinateFromAddress() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> destinationPlacemark = await locationFromAddress(this);
      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;
      return Coordinate(
          latitude: destinationLatitude,
          longitude: destinationLongitude,
          parentAddress: this);
    } catch (e) {
      rethrow;
    }
  }

  String get toKm{
    if (length <3) return this +'km';
    return (replaceRange(2, null, ' Km'));
  } 
}

extension CurrencyX on String {
  String get toAmount {
    final format = NumberFormat("#,##0.00", "en_US");
    log(this);  
    return 'NGN ' + format.format(double.parse(this));
  }

  bool get isNegative{ 
    if (contains('-')) return true;
    return false;
  } 
  String get amountRange {
    try {
      final amount = double.parse(this);
    final lowerRange = (amount -(amount * 0.2)).toString().toAmount;
    final higherRange = (amount + (amount * 0.2)).toString().toAmount;
    return lowerRange +' - ' + higherRange;
    } catch (e) {
      return toAmount;
    }
    
  }
}


extension DateTimeX on String {
  String get toDateTime {
    final dateTime = DateTime.parse(this).toLocal();
    if (isEmpty|| length<19) return this;
    return dateTime.toString().replaceRange(19, null, '');
  }
}

extension TrimX on String {
  String get toShortText {
    if (isEmpty|| length<24) return this;
    return replaceRange(24, null, ' ...');
  }

  String  toShortTextAdaptive(int length){
  if (isEmpty|| this.length<length) return this;
    return replaceRange(length, null, ' ...');
  }
}
