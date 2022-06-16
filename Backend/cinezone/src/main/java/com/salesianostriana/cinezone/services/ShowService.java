package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.showdto.CreateShowDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.reservasexception.RelacionInvalidaException;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.repos.ShowRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ShowService extends BaseService<Show, Long, ShowRepository> {

    private final AsientosShowService asientosShowService;
    private final SalaService salaService;
    private final MovieService movieService;
    private final CineService cineService;

    /**
     * Crea un nuevo show asociando una pelicula, sala y cine.
     * Una vez creado genera los asientos del show asociados con la sala
     * @param newShow
     * @return Retorna el nuevo show creado o una exception en cuyo caso la sala no pertenezca al cine
     */
    public Show createShow(CreateShowDto newShow) {


        Movie movie = movieService.find(newShow.getIdMovie());
        Sala sala = salaService.find(newShow.getIdSala());
        Cine cine = cineService.find(newShow.getIdCine());

        //Si la sala no pertenece al cine, excepcion

        if (cine.getSalas().contains(sala)) {

            Show show = Show.builder()
                    .sala(sala) //optionalSala.get()
                    .movie(movie) //optionalMovie.get()
                    .cine(cine)
                    .fecha(newShow.getFecha())
                    .formato(newShow.getFormato())
                    .hora(newShow.getHora())
                    .idioma(newShow.getIdioma())
                    .build();

            repositorio.save(show);
            for (Asiento asiento : sala.getAsientos()) {

                asientosShowService.crearAsientoParaShow(asiento, show);

            }

            return show;
        } else throw new RelacionInvalidaException("La sala no pertenece a ese cine.");


    }

    /**
     * Encuentra un show por su id, este metodo lo emplearemos en otros servicios
     * @param id
     * @return trae el show si existe o una exception de entidad no encontrada
     */
    public Show find(Long id) {
        Optional<Show> optionalShow = findById(id);

        if (optionalShow.isPresent()) {
            return optionalShow.get();
        } else {
            throw new SingleEntityNotFoundException(Show.class);
        }

    }

    /**
     * Encuentra todos los shows asociados a una película en una fecha determianda
     * @param pageable
     * @param id
     * @param fecha
     * @return Trae los shows encotrados de forma paginable o una lista vacia
     */
    public Page<Show> finAllShowsByMovie(Pageable pageable, Long id, LocalDate fecha) {
        return repositorio.findAllShowsByMovieId(pageable, id, fecha);
    }

    /**
     * Encuentra todos los shows asociados a un cine en una fecha determinada
     * @param pageable
     * @param id
     * @param fecha
     * @return Trae los shows encotrados de forma paginable o una lista vacia
     */
    public Page<Show> findAllShowsByCine(Pageable pageable, Long id, LocalDate fecha){
        return repositorio.findsAllShowsByCineId(pageable, id, fecha);
    }

    /**
     * Encuentra todos los shows asociados a una sala en una fecha determinada
     * @param pageable
     * @param id
     * @param fecha
     * @return Trae los shows encotrados de forma paginable o una lista vacia
     */
    public Page<Show> findAllShowsBySala(Pageable pageable, Long id, LocalDate fecha){
        return repositorio.findAllShowsBySalaAndFecha(pageable, id, fecha);
    }
}
