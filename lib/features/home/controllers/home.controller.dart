import 'package:boilerplate/features/home/models/transfer.model.dart';
import 'package:boilerplate/features/home/views/repositories/transfers.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
part 'home.controller.g.dart';

@LazySingleton()
class HomeViewController = _HomeViewControllerBase with _$HomeViewController;

abstract class _HomeViewControllerBase with Store {
  final TransfersRepository _transfersRepository;
  _HomeViewControllerBase(this._transfersRepository);

  // @observable
  // ObservableList<Transfer> latestTransfers = ObservableList();

  @observable
  ObservableFuture<ObservableList<Transfer>>? latestTransfers;

  @action
  void init() {
    _fetchLatestTransfersBase();
  }

  @action
  Future<void> _fetchLatestTransfersBase() async {
    try {
      final response = _transfersRepository.fetchLatestTransfers();

      latestTransfers = ObservableFuture(response);
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> deleteTransfer(int id) async {
    try {
      final response = await _transfersRepository.deleteTransfer(id);

      final list = latestTransfers!.value;

      list!.removeWhere((element) => element.id == response);

      latestTransfers = ObservableFuture.value(list);
    } catch (e) {
      rethrow;
    }
  }
}
