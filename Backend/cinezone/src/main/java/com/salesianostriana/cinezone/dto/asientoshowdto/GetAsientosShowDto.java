package com.salesianostriana.cinezone.dto.asientoshowdto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GetAsientosShowDto {

    private Long asientoId;
    private Long showId;
    //private String reservaId;
    private boolean esOcupado;
    private int fila;
    private int num;
    private Long salaId;

}
