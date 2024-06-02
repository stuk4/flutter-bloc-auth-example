import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_repository_state.dart';

class ProductsRepositoryCubit extends Cubit<ProductsRepositoryState> {
  ProductsRepositoryCubit() : super(const ProductsRepositoryState());
}
