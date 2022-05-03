package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.moviedto.CreateMovieDto;
import com.salesianostriana.cinezone.dto.moviedto.GetMovieDto;
import com.salesianostriana.cinezone.dto.moviedto.MovieDtoConverter;
import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.services.MovieService;
import com.salesianostriana.cinezone.users.dto.GetUserDto;
import com.salesianostriana.cinezone.users.model.UserEntity;
import com.salesianostriana.cinezone.util.PaginationLinkUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/movie")
@Validated
@Transactional
public class MovieController {

    private final MovieService movieService;
    private final MovieDtoConverter movieDtoConverter;
    private final PaginationLinkUtils paginationLinkUtils;


    @Operation(summary = "Crear una nueva película")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se creó correctamente la película",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo crear la película",
                    content = @Content),
    })
    @PostMapping("/")
    public ResponseEntity<GetMovieDto> createMovie(@Validated @RequestPart("movie") CreateMovieDto movieDto, @RequestPart("image")MultipartFile file) throws Exception{
        Movie movie = movieService.createMovie(movieDto, file);
        return ResponseEntity.status(HttpStatus.CREATED).body(movieDtoConverter.convertMovieToGetMovieDto(movie));
    }


    @Operation(summary = "Muestra todas las películas")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todas las películas",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de películas está vacía",
                    content = @Content),
    })
    @GetMapping("/")
    public ResponseEntity<Page<GetMovieDto>> findAllMovies(@PageableDefault(size = 10, page = 0)Pageable pageable, HttpServletRequest request){
        Page<Movie> m = movieService.findAllMovies(pageable);

        Page<GetMovieDto> res = m.map(movieDtoConverter::convertMovieToGetMovieDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }

    @Operation(summary = "Muestra una película por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se mostró correctamente la película",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No existe la película",
                    content = @Content),
    })
    @GetMapping("/{id}")
    public ResponseEntity<GetMovieDto> findById(@PathVariable Long id, Movie m){
        Optional<Movie> movie = movieService.findMovieById(id, m);
        return ResponseEntity.ok().body(movieDtoConverter.convertMovieToGetMovieDto(movie.get()));
    }


    @Operation(summary = "Editar una película por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se editó correctamente la película",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No existe la película",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public ResponseEntity<GetMovieDto> edit(@RequestBody CreateMovieDto movieDto, @PathVariable Long id){
        Movie nuevaM = movieService.edit(movieDto, id);
        GetMovieDto nuevaMDto = movieDtoConverter.convertMovieToGetMovieDto(nuevaM);
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevaMDto);
    }
}
