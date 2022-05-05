package com.salesianostriana.cinezone.dto.asientodto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateAsientoDto {

    private Long id;

    private int fila;
    private int numero;
    private boolean esOcupado;
}
