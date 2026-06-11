// Controller - gestion de l'authentification

import '../database/database_helper.dart';
import '../models/user.dart';

class AuthController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Inscription
  Future<String?> register(
      String username, String email, String password) async {
    // Validation
    if (username.trim().isEmpty) return 'Le nom d\'utilisateur est requis';
    if (username.trim().length < 3) {
      return 'Le nom doit contenir au moins 3 caractères';
    }
    if (email.trim().isEmpty) return 'L\'email est requis';
    if (!_isValidEmail(email)) return 'Email invalide';
    if (password.isEmpty) return 'Le mot de passe est requis';
    if (password.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }

    // Vérifier si l'email existe déjà
    final exists = await _dbHelper.emailExists(email.trim());
    if (exists) return 'Cet email est déjà utilisé';

    // Créer l'utilisateur
    final user = User(
      username: username.trim(),
      email: email.trim().toLowerCase(),
      password: password, // Dans un vrai projet : hasher le mot de passe
    );

    try {
      await _dbHelper.insertUser(user);
      return null; // null = succès
    } catch (e) {
      return 'Erreur lors de l\'inscription';
    }
  }

  // Connexion
  Future<User?> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) return null;
    final user = await _dbHelper.getUserByEmail(email.trim().toLowerCase());
    if (user == null) return null;
    if (user.password != password) return null;
    return user;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(email);
  }
}