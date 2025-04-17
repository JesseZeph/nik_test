// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/api_endpoints.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/core/services/network/api_services.dart';
import 'package:niklaar/core/utils/toast_helper.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService;

  AuthProvider({ApiService? apiService})
    : _apiService = apiService ?? getIt<ApiService>();

  var state = AuthState.initial;

  Future<bool> signUp({
    FormState? formState,
    String? referral,
    required String passwordConfirmation,
    required String password,
    required String email,
    required String phoneNumber,
    required String lastName,
    required String firstName,
    required String username,
  }) async {
    try {
      if (formState?.validate() ?? false) {
        state = AuthState.loading;
        notifyListeners();

        final response = await _apiService.postRequest(
          endpoint: ApiEndpoints.register,
          requestBody: {
            'first_name': firstName,
            'last_name': lastName,
            'phone_number': phoneNumber,
            'email': email,
            'username': username,
            'password': password,
            'password_confirmation': passwordConfirmation,
            'referral': referral,
          },
        );

        if (response.status) {
          ToastMessage.showSuccessToast(message: response.message);
          return true;
        } else {
          ToastMessage.showErrorToast(message: response.message);
          return false;
        }
      }
    } catch (e, s) {
      logMessage("authProvider:: register", e.toString(), stackTrace: s);
      return false;
    } finally {
      state = AuthState.loaded;
      notifyListeners();
    }
    return false;
  }
}

enum AuthState { initial, loading, loaded, error }
