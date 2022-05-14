package com.salesianostriana.cinezone.dto.tarjetadto;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class GetTarjetaDto {

    private Long id;

    private String no_tarjeta;

    private LocalDate fecha_cad;

    private String titular;
}
