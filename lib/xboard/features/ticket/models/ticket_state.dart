import 'package:flutter_xboard_sdk/flutter_xboard_sdk.dart';

class TicketState {
  final List<Ticket> tickets;
  final bool isLoading;
  final bool isLoadingDetail;
  final TicketDetail? currentTicketDetail;
  final String? errorMessage;

  const TicketState({
    this.tickets = const [],
    this.isLoading = false,
    this.isLoadingDetail = false,
    this.currentTicketDetail,
    this.errorMessage,
  });

  TicketState copyWith({
    List<Ticket>? tickets,
    bool? isLoading,
    bool? isLoadingDetail,
    TicketDetail? currentTicketDetail,
    String? errorMessage,
  }) {
    return TicketState(
      tickets: tickets ?? this.tickets,
      isLoading: isLoading ?? this.isLoading,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      currentTicketDetail: currentTicketDetail ?? this.currentTicketDetail,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

