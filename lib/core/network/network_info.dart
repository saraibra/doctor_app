import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
abstract class NetworkInfo{
  Future<bool> get isConnected;
}
class NetworkInfoImplement implements NetworkInfo{
  final InternetConnection  connectionChecker;

  NetworkInfoImplement(this.connectionChecker);
  @override
  Future<bool> get isConnected =>connectionChecker.hasInternetAccess;

}