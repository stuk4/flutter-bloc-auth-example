import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

import 'package:teslo_shop/features/products/infrastructure/infrastructure.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  late final StreamSubscription _authBlocSubscription;
  final AuthBloc authBloc;
  final ProductsRepository _productRepository;

  ProductsCubit({
    required this.authBloc,
  })  : _productRepository = ProductsRepositoryImpl(
          ProductsDatasourceImpl(accessToken: authBloc.state.user?.token ?? ''),
        ),
        super(const ProductsState()) {
    print('ProductsCubit constructor');

    // Suscríbete a cambios en AuthBloc
    _authBlocSubscription = authBloc.stream.listen((authState) {
      final newToken = authState.user?.token ?? '';
      _productRepository.updateAccessToken(newToken);
    });
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (state.isLastPage || state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    final products = await _productRepository.getProductsByPage(
        limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      emit(state.copyWith(
        isLoading: false,
        isLastPage: true,
      ));

      return;
    }
    emit(state.copyWith(
      isLoading: false,
      isLastPage: false,
      offset: state.offset + 10,
      products: [...state.products, ...products],
    ));
  }

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }
}
