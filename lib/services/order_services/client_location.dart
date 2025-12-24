import 'package:dartz/dartz.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientLocation {

  Future<Either<String, void>> openClientGoogleMaps(double latitude, double longitude) async {
    final googleMapsUri = Uri.parse('google.navigation:q=$latitude,$longitude');
    final webUri = Uri.parse('https://www.google.com/maps?q=$latitude,$longitude');

    try {

      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri);
        return Right(null);
      } else if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri);
        return Right(null);
      } else {
        return Left('حدث خطأ في التحميل');
      }
    } catch (error) {
      return Left('Error: $error'); // Catch any other error
    }
  }
}
