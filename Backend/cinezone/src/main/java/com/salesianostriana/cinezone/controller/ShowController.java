package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.showdto.CreateShowDto;
import com.salesianostriana.cinezone.dto.showdto.GetShowDto;
import com.salesianostriana.cinezone.dto.showdto.ShowDtoConverter;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.services.ShowService;
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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/show")
public class ShowController {

    private final ShowService showService;
    private final ShowDtoConverter showDtoConverter;
    private final PaginationLinkUtils paginationLinkUtils;

    @Operation(summary = "Crear un nuevo show")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se creó correctamente el show",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Show.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo crear el show",
                    content = @Content),
    })
    @PostMapping()
    public ResponseEntity<GetShowDto> createShow(@RequestBody CreateShowDto newShow){

        Show show = showService.createShow(newShow);

        return ResponseEntity.status(HttpStatus.CREATED).body(showDtoConverter.convertToGetShowDto(show));
    }


    @Operation(summary = "Muestra todos los shows relacionados con una película en una fecha determinada")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todos los shows",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Show.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de shows está vacía",
                    content = @Content),
    })
    @GetMapping("/movie/{id_movie}/date/{fecha}")
    public ResponseEntity<Page<GetShowDto>> findAllShowsByMovieAndDate(@PageableDefault(size = 10, page = 0) Pageable pageable, HttpServletRequest request, @PathVariable Long id_movie, @PathVariable String fecha){

        LocalDate date = LocalDate.parse(fecha);
        Page<Show> s = showService.finAllShowsByMovie(pageable ,id_movie, date);
        Page<GetShowDto> res = s.map(showDtoConverter::convertToGetShowDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }


    @Operation(summary = "Muestra todos los shows con un cine relacionado en una fecha determinada")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todos los shows",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Show.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de shows está vacía",
                    content = @Content),
    })
    @GetMapping("/cine/{cine_id}/date/{fecha}")
    public ResponseEntity<Page<GetShowDto>> findAllShowsByCineAndDate(@PageableDefault(size = 10, page = 0) Pageable pageable, HttpServletRequest request, @PathVariable Long cine_id, @PathVariable String fecha){
        LocalDate date = LocalDate.parse(fecha);
        Page<Show> s = showService.findAllShowsByCine(pageable, cine_id, date);
        Page<GetShowDto> res = s.map(showDtoConverter::convertToGetShowDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }


    @Operation(summary = "Muestra todos los shows con una sala relacionado en una fecha determinada")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todos los shows",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Show.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de shows está vacía",
                    content = @Content),
    })
    @GetMapping("/sala/{sala_id}/date/{fecha}")
    public ResponseEntity<Page<GetShowDto>> findAllShowsBySalaAndDate(@PageableDefault(size = 10, page = 0) Pageable pageable, HttpServletRequest request, @PathVariable Long sala_id, @PathVariable String fecha){
        LocalDate date = LocalDate.parse(fecha);
        Page<Show> s = showService.findAllShowsByCine(pageable, sala_id, date);
        Page<GetShowDto> res = s.map(showDtoConverter::convertToGetShowDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }
}
