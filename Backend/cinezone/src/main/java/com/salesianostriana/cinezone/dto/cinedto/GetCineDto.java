package com.salesianostriana.cinezone.dto.cinedto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetCineDto {
    private Long id;

    private String nombre;

    private String direccion;

    private String latLon;

    private String plaza;

}
