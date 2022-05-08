package com.salesianostriana.cinezone.dto.reservadto;

import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CreateReservaDto {

    private Long showId;

    private Long cineId;

    private Long asientoId;


}
