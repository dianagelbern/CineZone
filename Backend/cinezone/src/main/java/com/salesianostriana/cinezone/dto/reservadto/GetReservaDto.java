package com.salesianostriana.cinezone.dto.reservadto;

import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetReservaDto {

    public UUID id;
    public String sala, butaca, movie, formato, cine, email, fecha, horaShow, fechaShow;


}
