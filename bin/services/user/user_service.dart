import 'package:password_dart/password_dart.dart';

import '../../models/models.dart';
import '../../repositories/repostories.dart';
import '../generic_service.dart';

class UserService implements GenericService<User> {
  final UserRepository _userRepository;
  UserService(this._userRepository);
  @override
  Future<bool> delete(int id) async => await _userRepository.delete(id);

  @override
  Future<List<User>> findAll() async => await _userRepository.findAll();

  @override
  Future<User?> findOne(int id) async => await _userRepository.findOne(id);

  @override
  Future<bool> save(User value) async {
    if (value.id != null) {
      return await _userRepository.update(value);
    } else {
      final hash = Password.hash(value.password!, PBKDF2());
      value.password = hash;
      return await _userRepository.create(value);
    }
  }

  Future<User?> findByEmail(String email) async =>
      await _userRepository.findByEmail(email);
}
