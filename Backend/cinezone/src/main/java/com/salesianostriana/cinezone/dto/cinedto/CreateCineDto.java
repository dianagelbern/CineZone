package com.salesianostriana.cinezone.dto.cinedto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateCineDto {

    private Long id;

    private String nombre;

    private String direccion;

    private String latLon;

    private String plaza;

    private int numSalas;
}
