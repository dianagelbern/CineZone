package com.salesianostriana.cinezone.dto.showdto;

import com.salesianostriana.cinezone.models.show.Formato;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CreateShowDto {

    private Long idMovie;

    private Long idCine;

    private Long idSala;

    private LocalDateTime fecha;

    private Formato formato;

    private String idioma;

}
