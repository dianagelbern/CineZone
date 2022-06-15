package com.salesianostriana.cinezone.dto.moviedto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetMovieDto {
    private Long id;

    private String genero, titulo, director, clasificacion, productora;

    private String sinopsis;

    private int duracion;

    private String imagen;


}
