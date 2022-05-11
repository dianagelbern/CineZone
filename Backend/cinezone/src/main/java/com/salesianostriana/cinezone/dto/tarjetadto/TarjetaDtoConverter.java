package com.salesianostriana.cinezone.dto.tarjetadto;


import com.salesianostriana.cinezone.models.Tarjeta;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class TarjetaDtoConverter {

    public  GetTarjetaDto convertTarjetaToGetTarjetaDto(Tarjeta t){
        return GetTarjetaDto.builder()
                .id(t.getId())
                .no_tarjeta(t.getNo_tarjeta())
                .fecha_cad(t.getFecha_cad())
                .titular(t.getTitular())
                .build();
    }

    public Tarjeta createTarjetaDtoToTarjeta(CreateTarjetaDto t){
        return Tarjeta.builder()
                .no_tarjeta(t.getNo_tarjeta())
                .fecha_cad(t.getFecha_cad())
                .titular(t.getTitular())
                .build();
    }
}
