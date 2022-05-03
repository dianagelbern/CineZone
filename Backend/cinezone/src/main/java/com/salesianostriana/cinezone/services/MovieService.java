package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.moviedto.CreateMovieDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.repos.MovieRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MovieService extends BaseService<Movie, Long, MovieRepository>{


    public Movie createMovie(CreateMovieDto movieDtoConverter){
        Movie movie = Movie.builder()
                .clasificacion(movieDtoConverter.getClasificacion())
                .director(movieDtoConverter.getDirector())
                .duracion(movieDtoConverter.getDuracion())
                .genero(movieDtoConverter.getGenero())
                .imagen(movieDtoConverter.getImagen())
                .productora(movieDtoConverter.getProductora())
                .sinopsis(movieDtoConverter.getSinopsis())
                .titulo(movieDtoConverter.getTitulo())
                .trailer(movieDtoConverter.getTrailer())
                .build();
        return save(movie);
    }

    public Page<Movie> findAllMovies(Pageable pageable){
        if (repositorio.findAll(pageable).isEmpty()){
            throw new ListEntityNotFoundException(Movie.class);
        }else{
            return repositorio.findAll(pageable);
        }
    }

    public Optional<Movie> findMovieById(Long id, Movie movie){
        if (movie.getId().equals(id)){
            Optional<Movie> m = findById(id);
            return m;
        }else{
            throw new EntityNotFoundException("La película no existe");
        }
    }


    /*Este método no lo utilizaré en el controller porque me parece poco conveniente eliminar algo de lo que dependen
    casi todas las entidades*/
    public Optional<?> deleteMovieByID(Long id, Movie m){
        Optional<Movie> movie = findById(id);
        if (movie.isPresent()){
            return deleteById(id);
        }else {
            throw new EntityNotFoundException("No se encontró ninguna película con ese id");
        }
    }
}
