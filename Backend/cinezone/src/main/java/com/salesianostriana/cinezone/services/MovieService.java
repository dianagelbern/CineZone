package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.moviedto.CreateMovieDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.repos.MovieRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import com.salesianostriana.cinezone.services.base.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.nio.file.Files;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MovieService extends BaseService<Movie, Long, MovieRepository>{

    private final StorageService storageService;


    /**
     * Crea una nueva pelicula
     * @param movieDtoConverter
     * @param file
     * @return retorna la película creada
     * @throws Exception
     */
    public Movie createMovie(CreateMovieDto movieDtoConverter, MultipartFile file) throws Exception {

        String url = storageService.store(file);


        Movie movie = Movie.builder()
                .clasificacion(movieDtoConverter.getClasificacion())
                .director(movieDtoConverter.getDirector())
                .duracion(movieDtoConverter.getDuracion())
                .genero(movieDtoConverter.getGenero())
                .imagen(url)
                .productora(movieDtoConverter.getProductora())
                .sinopsis(movieDtoConverter.getSinopsis())
                .titulo(movieDtoConverter.getTitulo())
                .build();
        return save(movie);
    }

    /**
     * Encuentra todas las peliculas
     * @param pageable
     * @return Retorna las peliculas de forma paginada
     */
    public Page<Movie> findAllMovies(Pageable pageable){
        return repositorio.findAll(pageable);
    }

    /**
     * Encuentra una pelicula por su id
     * @param id
     * @param movie
     * @return Retorna la pelicula o una exception de entidad no encontrada
     */
    public Optional<Movie> findMovieById(Long id, Movie movie){
        if (movie.getId().equals(id)){
            Optional<Movie> m = findById(id);
            return m;
        }else{
            throw new EntityNotFoundException("La película no existe");
        }
    }

    /**
     * Edita una pelicula por medio de su id
     * @param movieDto
     * @param id
     * @return Retorna la nueva pelicula o una exception de entidad no encontrada
     */
    public Movie edit(CreateMovieDto movieDto, Long id){
        Optional<Movie> m = repositorio.findById(id);
        if (m.isPresent()){

            Movie nueva = m.get();
            nueva.setClasificacion(movieDto.getClasificacion());
            nueva.setDirector(movieDto.getDirector());
            nueva.setDuracion(movieDto.getDuracion());
            nueva.setGenero(movieDto.getGenero());
            nueva.setProductora(movieDto.getProductora());
            nueva.setSinopsis(movieDto.getSinopsis());
            nueva.setTitulo(movieDto.getTitulo());

            return repositorio.save(nueva);
        }else{
            throw new SingleEntityNotFoundException(Movie.class, id);
        }
    }

    /**
     * Metodo que emplearemos en otros serivios para buscar una pelicula por su id
     * @param id
     * @return Retorna la pelicula o una exception de entidad no encontrada
     */
    public Movie find(Long id){
        Optional<Movie> optionalMovie = repositorio.findById(id);

        if (optionalMovie.isEmpty()) {
            throw new SingleEntityNotFoundException(Movie.class);
        } else {
            return optionalMovie.get();
        }
    }



    /*Este método no lo utilizaré en el controller porque me parece poco conveniente eliminar algo de lo que dependen
    casi todas las entidades*/
    public Optional<?> deleteMovieById(Long id, Movie m){
        Optional<Movie> movie = findById(id);
        if (movie.isPresent()){
            return deleteById(id);
        }else {
            throw new EntityNotFoundException("No se encontró ninguna película con ese id");
        }
    }
}
