package com.salesianostriana.cinezone.dto.cinedto;

import com.salesianostriana.cinezone.dto.showdto.GetShowDto;
import lombok.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GetShowByCineMovieDto {

    private Long idMovie;

    private Long idCine;

    private LocalDate fecha;

    @Builder.Default
    private List<GetShowDto> shows = new ArrayList<>();
}
