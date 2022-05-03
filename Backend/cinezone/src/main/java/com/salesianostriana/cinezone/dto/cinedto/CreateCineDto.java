package com.salesianostriana.cinezone.dto.cinedto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateCineDto {

    private Long id;

    private String direccion;

    private String latLon;

    private String plaza;
}
