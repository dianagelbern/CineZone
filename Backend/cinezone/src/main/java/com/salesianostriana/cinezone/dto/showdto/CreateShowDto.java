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
public class CreateShowDto {

    private Long idMovie;

    private Long idCine;

    private Long idSala;

    private LocalDate fecha;

    private LocalTime hora;

    private Formato formato;

    private String idioma;

}
