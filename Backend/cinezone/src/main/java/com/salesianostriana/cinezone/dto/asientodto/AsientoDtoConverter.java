package com.salesianostriana.cinezone.dto.asientodto;


import com.salesianostriana.cinezone.models.Asiento;
import lombok.*;
import org.springframework.stereotype.Component;

@Component
public class AsientoDtoConverter {

    public GetAsientoDto convertAsientoToGetAsientoDto(Asiento a){
        return GetAsientoDto.builder()
                .id(a.getId())
                .esOcupado(a.isEsOcupado())
                .fila(a.getFila())
                .numero(a.getNumero())
                .build();
    }

    public Asiento createAsientoDtoToAsiento(CreateAsientoDto  a){
        return Asiento.builder()
                .id(a.getId())
                .esOcupado(a.isEsOcupado())
                .fila(a.getFila())
                .numero(a.getNumero())
                .build();
    }




}
