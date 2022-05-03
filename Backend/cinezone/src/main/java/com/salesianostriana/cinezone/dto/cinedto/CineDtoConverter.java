package com.salesianostriana.cinezone.dto.cinedto;

import com.salesianostriana.cinezone.models.Cine;
import lombok.*;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class CineDtoConverter {

    public GetCineDto convertCineToGetCineDto(Cine c){
        return GetCineDto.builder()
                .id(c.getId())
                .direccion(c.getDireccion())
                .latLon(c.getLatLon())
                .plaza(c.getPlaza())
                .build();
    }

    public Cine createCineDtoToCine(CreateCineDto c){
        return Cine.builder()
                .id(c.getId())
                .direccion(c.getDireccion())
                .latLon(c.getLatLon())
                .plaza(c.getPlaza()).build();
    }
}
