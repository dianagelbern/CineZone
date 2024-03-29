package com.salesianostriana.cinezone.dto.showdto;

import com.salesianostriana.cinezone.models.show.Show;
import org.springframework.stereotype.Component;

@Component
public class ShowDtoConverter {


    public GetShowDto convertToGetShowDto(Show show){

        return GetShowDto.builder()
                .id(show.getId())
                .fecha(show.getFecha())
                .hora(show.getHora())
                .formato(show.getFormato())
                .movieImagen(show.getMovie().getImagen())
                .movieTitulo(show.getMovie().getTitulo())
                .salaNombre(show.getSala().getNombre())
                .nombreCine(show.getCine().getNombre())
                .idCine(show.getCine().getId())
                .idMovie(show.getMovie().getId())
                .build();


    }



}
