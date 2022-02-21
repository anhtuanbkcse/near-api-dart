
import 'package:equatable/equatable.dart';

class Account extends Equatable{

  final String id;

  const Account({required this.id});

  @override
  List<Object?> get props => [id];

}