package com.salesianostriana.cinezone.dto.saladto;


import com.salesianostriana.cinezone.models.Sala;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SalaDtoConverter {

    public GetSalaDto convertSalaToGetSalaDto(Sala s){
        return GetSalaDto.builder()
                .id(s.getId())
                .nombre(s.getNombre())

                .build();
    }

    public GetSalaDto convertSalaToGetSalaDetailsDto(Sala s){
        return GetSalaDto.builder()
                .id(s.getId())
                .nombre(s.getNombre())

                .build();
    }

    public Sala createSalaStoToSala(CreateSalaDto salaDto){
        return Sala.builder()
                .id(salaDto.getId())
                .nombre(salaDto.getNombre())
                .build();
    }
}
