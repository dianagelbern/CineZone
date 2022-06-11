package com.salesianostriana.cinezone.dto.asientoshowdto;

import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.repos.AsientoRepository;
import com.salesianostriana.cinezone.repos.SalaRepository;
import com.salesianostriana.cinezone.repos.ShowRepository;
import com.salesianostriana.cinezone.services.AsientoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AsientosShowDtoConverter {

    private final AsientoService asientoService;

    public GetAsientosShowDto convertToGetAsientosShowDto(AsientosShow asientosShow){

        Asiento asiento = asientoService.find(asientosShow.getAsiento().getId());

        return GetAsientosShowDto.builder()
                .showId(asientosShow.getShow().getId())
                .salaId(asiento.getSala().getId())
                .asientoId(asientosShow.getAsiento().getId())
                .esOcupado(asientosShow.isEsOcupado())
                .fila(asiento.getFila())
                .num(asiento.getNumero())
                //.reservaId(asientosShow.getReserva().getId().toString() == null ? "" : asientosShow.getReserva().getId().toString())
                .build();
    }

}
