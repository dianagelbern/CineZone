package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.showdto.CreateShowDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.repos.ShowRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import com.sun.xml.bind.v2.runtime.unmarshaller.XsiNilLoader;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ShowService extends BaseService<Show, Long, ShowRepository> {

    private final AsientosShowService asientosShowService;
    private final SalaService salaService;
    private final MovieService movieService;

    public Show createShow(CreateShowDto newShow){


        Movie movie = movieService.find(newShow.getIdMovie());
        Sala sala = salaService.find(newShow.getIdSala());

        Show show = Show.builder()
                .sala(sala) //optionalSala.get()
                .movie(movie) //optionalMovie.get()
                .fecha(newShow.getFecha())
                .formato(newShow.getFormato())
                .idioma(newShow.getIdioma())
                .build();

        repositorio.save(show);
        for (Asiento asiento : sala.getAsientos()){

            asientosShowService.crearAsientoParaShow(asiento, show);

        }

        return show;

    }

}
