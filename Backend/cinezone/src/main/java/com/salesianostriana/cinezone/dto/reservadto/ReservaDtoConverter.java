package com.salesianostriana.cinezone.dto.reservadto;

import com.salesianostriana.cinezone.dto.cinedto.GetCineDto;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Reserva;
import org.springframework.stereotype.Component;

@Component
public class ReservaDtoConverter {


    public GetReservaDto convertToGetReservaDto(Reserva reserva){
        Asiento asiento = reserva.getAsientoReservado().getAsiento();

        int num = asiento.getNumero();
        int fila = asiento.getFila();
        //TODO: Realizar consulta que solucione el problema de lazily initialize con todos estos datos
        return GetReservaDto.builder()
                .id(reserva.getId())
                .butaca(String.format("Butaca %d , Fila %d", num, fila))
                .cine(reserva.getCine().getNombre())
                .email(reserva.getUser().getEmail())
                .formato(reserva.getAsientoReservado().getShow().getFormato().name())
                .movie(reserva.getAsientoReservado().getShow().getMovie().getTitulo())
                .sala(reserva.getAsientoReservado().getAsiento().getSala().getNombre())
                .fecha(reserva.getFecha().toString())
                .fechaShow(reserva.getAsientoReservado().getShow().getFecha().toString())
                .horaShow(reserva.getAsientoReservado().getShow().getHora().toString())
                .build();
    }

}
