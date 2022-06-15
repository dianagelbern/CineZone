package com.salesianostriana.cinezone.dto.moviedto;

import lombok.*;

import javax.persistence.Lob;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateMovieDto {
    private Long id;

    private String genero, titulo, director, clasificacion, productora;

    private String sinopsis;

    private int duracion;

    private String imagen;

}
