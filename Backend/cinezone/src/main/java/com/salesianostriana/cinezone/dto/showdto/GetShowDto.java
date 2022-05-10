package com.salesianostriana.cinezone.dto.showdto;

import com.salesianostriana.cinezone.models.show.Formato;
import lombok.*;

import java.time.LocalDateTime;

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

    private LocalDateTime fecha;


}
