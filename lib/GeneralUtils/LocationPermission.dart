import 'package:location_permissions/location_permissions.dart';

late PermissionStatus permissionStatus;

Future<bool> checkPermisisonForLocation() async {
  try {
    permissionStatus = await LocationPermissions().checkPermissionStatus();
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }

  }catch(e){
    RequstPermission();
    return false;
  }
}
Future<bool> RequstPermission() async {
  permissionStatus = await LocationPermissions().requestPermissions();
  if(permissionStatus == PermissionStatus.granted){
    return true;
  }else{
    return RequstPermission();
  }
}
Future<bool> checkServiceStatus() async {
  ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();
  if(serviceStatus == ServiceStatus.enabled){
    return true;
  }else{
    return false;
  }
}
