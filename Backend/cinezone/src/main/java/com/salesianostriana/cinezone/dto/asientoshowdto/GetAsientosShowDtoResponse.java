package com.salesianostriana.cinezone.dto.asientoshowdto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
//He creado esta clase ya que al convertirlo en paginable me daba un error con la consulta
public class GetAsientosShowDtoResponse {

    private List<GetAsientosShowDto> result;
}
