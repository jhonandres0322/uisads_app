import 'dart:developer';
import 'package:uisads_app/src/models/login_request.dart';
import 'package:uisads_app/src/models/login_response.dart';
import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/register_request.dart';
import 'package:uisads_app/src/models/register_response.dart';
import 'package:uisads_app/src/models/request_change_password.dart';
import 'package:uisads_app/src/models/response.dart';
import 'package:uisads_app/src/models/response_score_profile.dart';
import 'package:uisads_app/src/utils/http_handler.dart';

class AuthService with HttpHandler {
  
  Future<LoginResponse> loginUser( LoginRequest user) async {
    final resp = await getPost('/auth/login', user.toMap() );
    LoginResponse loginResponse = LoginResponse.fromMap( resp );
    return loginResponse;
  }

  Future<RegisterResponse> registerUser( RegisterRequest registerRequest ) async {
    final resp = await getPost('/auth/register', registerRequest.toMap() );
    RegisterResponse registerResponse = RegisterResponse.fromMap( resp );
    return registerResponse;
  }

  Future<Profile> getProfile( String idProfile ) async {
    final resp = await getGet('/profile/$idProfile');
    resp['profile']['email'] = resp['email'];
    Profile profile = Profile.fromMap( resp['profile'] );
    return profile;
  }

  Future<Response> editProfile( String idProfile, Profile profile ) async {
    final resp = await getPut('/profile/$idProfile', profile.toMap() );
    final Response response = Response.fromMap( resp );
    return response;
  }

  Future<ResponseScoreProfile> getScoreProfile( String idProfile ) async {
    final resp = await getPost('/profile/calculate', {
      "idProfile": idProfile 
    });
    ResponseScoreProfile _response = ResponseScoreProfile.fromMap( resp );
    return _response;
  }
  
  Future<Response> changePassword( RequestChangePassword request ) async {
    log('entrando al servicio para cambiar contraseña');
    final resp = await getPost('/auth/change-password', request.toMap());
    return Response.fromMap( resp );
  }
}
