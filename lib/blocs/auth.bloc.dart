import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/datamodel.dart';

class AuthBloc extends Object {
  signInWithGoogle() {
    return false;
  }

  logInWithEmail(LoginDataModel model) async {
    final username = model.email.trim();
    final password = model.password.trim();

    final user = ParseUser(username, password, null);
    var response = await user.login();
    return response;
  }
  
  logInWithGoogle(){

  }

  signUpWithEmail(LoginDataModel model) async {
    final username = model.email.trim();
    final email = model.email.trim();
    final password = model.email.trim();

    final user = ParseUser(username, password, email);
    var response = await user.signUp();
    return response;
  }

  resetPassword() async {
    var username = await getUser();
    final ParseUser user = ParseUser(null, null, username?.get("username"));
    final ParseResponse parseResponse = await user.requestPasswordReset();
    return parseResponse;
  }

  forgotPassword(String uname) async {
    final ParseUser user = ParseUser(null, null, uname);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    return parseResponse;
  }

  Future<ParseUser?> getUser() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  isSignedIn() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse = await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);
    if (parseResponse?.success == null || !parseResponse!.success) {
        return false;
      } else {
          return true;
        }
  }

  Future<List<ParseObject>> getData(String classId, String docId) async {
    // userID
    var username = await authBloc.getUser();
    var uid = (username?.get("objectId") ==  null) ? "-" : username?.get("objectId");

    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo('uid', uid);
      parseQuery.setLimit(10);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<List<ParseObject>> getMessages(String classId, String docId) async {
    // userID
    var username = await authBloc.getUser();
    var uid = (username?.get("objectId") ==  null) ? "-" : username?.get("objectId");

    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo('uid', uid);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<List<ParseObject>> getBids(String classId, String docId) async {
    // userID
    var username = await authBloc.getUser();
    var uid = (username?.get("objectId") ==  null) ? "-" : username?.get("objectId");
    // docId = (docId == "-") ? "driver" : "uid";

    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo(docId, uid);
      parseQuery.setLimit(10);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<List<ParseObject>> getBidsForRide(String classId, String docId) async {
    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo("rideId", docId);
      parseQuery.setLimit(10);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<List<ParseObject>> getBiddableRides(String classId) async {
    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo('status', "new");
      parseQuery.setLimit(10);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<List<ParseObject>> getRideDoc(String classId, String docId) async {
    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo('objectId', docId);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }
  Future<List<ParseObject>> getBidDoc(String classId, String docId) async {
    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo('objectId', docId);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<List<ParseObject>> getDoc(String classId, String docId) async {
    // userID
    var username = await authBloc.getUser();
    var uid = (username?.get("objectId") ==  null) ? "-" : username?.get("objectId");
    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject(classId));
      parseQuery.whereEqualTo('uid', uid);
      parseQuery.whereEqualTo('objectId', docId);
      parseQuery.orderByDescending('createdAt');
    
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<void> delDoc(String classId, String docId) async {
    var todo = ParseObject(classId)..objectId = docId;
    await todo.delete();
  }

  Future<List<ParseObject>> getSettings(UserDataModel model) async {
    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject("Settings"));
      parseQuery.whereEqualTo('uid', model.uid);
      parseQuery.orderByDescending('createdAt');
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }

  Future<List<ParseObject>> getUserType() async {
    var username = await authBloc.getUser();
    var uid = (username?.get("objectId") ==  null) ? "-" : username?.get("objectId");

    QueryBuilder<ParseObject> parseQuery = 
      QueryBuilder(ParseObject("Settings"));
      parseQuery.whereEqualTo('uid', uid);
      parseQuery.orderByDescending('createdAt');
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
        } else {
          return [];
      }
  }


  Future<bool> setData(String classId, model) async {
    // ParseObject data;

    var dataStr = "";
    model.toJson().forEach((key, value) {
      if(key != 'objectId') {
        dataStr = dataStr + "..set('$key', $value)";
      }
    });
    print(model.toJson()["objectId"]);
    print(dataStr);
    return true;
  }

  Future<bool> setRide(String classId, model) async {
    ParseObject data;
    if (model.objectId == "-") {
            data = ParseObject(classId)
              // ..objectId = model.uid
              ..set('uid', model.uid)
              ..set('dttm', model.dttm)
              ..set('from', model.from)
              ..set('to', model.to)
              ..set('message', model.message)
              ..set('loadType', model.loadType)
              ..set('status', model.status)
              ..set('fileURL', model.fileURL);
    } else {
            data = ParseObject(classId)
              ..objectId = model.objectId
              ..set('uid', model.uid)
              ..set('dttm', model.dttm)
              ..set('from', model.from)
              ..set('to', model.to)
              ..set('message', model.message)
              ..set('loadType', model.loadType)
              ..set('status', model.status)
              ..set('fileURL', model.fileURL);
    }
    final ParseResponse apiResponse = await data.save();
    if (apiResponse.success && apiResponse.results != null) {
        return true;
        } else {
        return false;
      }
  }

  Future<bool> setBid(String classId, model) async {
    ParseObject data;
    if (model.objectId == "-") {
            data = ParseObject(classId)
              // ..objectId = model.uid
              ..set('rideId', model.rideId)
              ..set('rideDttm', model.rideDttm)
              ..set('uid', model.uid)
              ..set('driver', model.driver)
              ..set('from', model.from)
              ..set('to', model.to)
              ..set('status', model.status)
              ..set('fileURL', model.fileURL)
              ..set('bid', model.bid)
              ..set('message', model.message);
    } else {
            data = ParseObject(classId)
              ..objectId = model.objectId
              ..set('rideId', model.rideId)
              ..set('rideDttm', model.rideDttm)
              ..set('uid', model.uid)
              ..set('driver', model.driver)
              ..set('from', model.from)
              ..set('to', model.to)
              ..set('status', model.status)
              ..set('fileURL', model.fileURL)
              ..set('bid', model.bid)
              ..set('message', model.message);
    }
    final ParseResponse apiResponse = await data.save();
    if (apiResponse.success && apiResponse.results != null) {
        return true;
        } else {
        return false;
      }
  }

  Future<bool> setSettings(UserDataModel model) async {
    // TODO: Combine all Insert and Update method to Upsert
    // Refactor: all individual class updates to one dynamic function
    // aka pass class ID and model as params and use one generic function to upsert
    // see setData example mention earlier
    // this is why it's important to have Data model and From/TOJson factory methods to
    // serialze and deserialize json data feeds
    ParseObject data;
    if (model.objectId == "-") {
            data = ParseObject('Settings')
              // ..objectId = model.uid
              ..set('uid', model.uid)
              ..set('userName', model.userName)
              ..set('userType', model.userType)
              ..set('name', model.name)
              ..set('email', model.email)
              ..set('phone', model.phone)
              ..set('address', model.address);
    } else {
            data = ParseObject('Settings')
              ..objectId = model.objectId
              ..set('uid', model.uid)
              ..set('userName', model.userName)
              ..set('userType', model.userType)
              ..set('name', model.name)
              ..set('email', model.email)
              ..set('phone', model.phone)
              ..set('address', model.address);
    }
    final ParseResponse apiResponse = await data.save();
    if (apiResponse.success && apiResponse.results != null) {
        return true;
        } else {
        return false;
      }
  }

  Future<bool> setMessage(InboxModel model) async {
    ParseObject data;
    data = ParseObject('Messages')
            ..set('dttm', model.dttm)
            ..set('uid', model.uid)
            ..set('to', model.to)
            ..set('message', model.message)
            ..set('readReceipt', model.readReceipt)
            ..set('fileURL', model.fileURL);
    final ParseResponse apiResponse = await data.save();
    if (apiResponse.success && apiResponse.results != null) {
        return true;
        } else {
        return false;
      }
  }

  logout() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse = await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);
    if (parseResponse?.count == null || parseResponse!.count < 1) {
      //Invalid session. Logout
        return true;
      } else {
          await currentUser.logout();
          return true;
        }
  }
}

final authBloc = AuthBloc();