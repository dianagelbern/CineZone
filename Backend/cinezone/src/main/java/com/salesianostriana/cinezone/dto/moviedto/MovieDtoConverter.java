package com.salesianostriana.cinezone.dto.moviedto;

import com.salesianostriana.cinezone.models.Movie;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class MovieDtoConverter {

    public GetMovieDto convertMovieToGetMovieDto(Movie m){
        return GetMovieDto.builder()
                .id(m.getId())
                .director(m.getDirector())
                .clasificacion(m.getClasificacion())
                .duracion(m.getDuracion())
                .genero(m.getGenero())
                .imagen(m.getImagen())
                .productora(m.getProductora())
                .sinopsis(m.getSinopsis())
                .titulo(m.getTitulo())
                .trailer(m.getTrailer())
                .build();
    }

    public Movie createMovieDtoToMovie(CreateMovieDto m){
        return Movie.builder()
                .id(m.getId())
                .director(m.getDirector())
                .clasificacion(m.getClasificacion())
                .duracion(m.getDuracion())
                .genero(m.getGenero())
                .imagen(m.getImagen())
                .productora(m.getProductora())
                .sinopsis(m.getSinopsis())
                .titulo(m.getTitulo())
                .trailer(m.getTrailer())
                .build();
    }
}
