package com.salesianostriana.cinezone.dto.reservadto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetReservaDto {

    public Long id;
    public String sala, butaca, movie, formato, cine, email, fecha, fechaShow;



}
