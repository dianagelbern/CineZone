package com.salesianostriana.cinezone.dto.showdto;

import com.salesianostriana.cinezone.models.show.Formato;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetShowDto {

    private Long id;

    private String movieImagen;

    private String movieTitulo;

    private String salaNombre;

    private Formato formato;

    private LocalDate fecha;

    private LocalTime hora;

    private String nombreCine;

    private Long idCine;

    private Long idMovie;


}
