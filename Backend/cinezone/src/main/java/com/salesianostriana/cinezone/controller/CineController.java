package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.cinedto.CineDtoConverter;
import com.salesianostriana.cinezone.dto.cinedto.CreateCineDto;
import com.salesianostriana.cinezone.dto.cinedto.GetCineDto;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.services.CineService;
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
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/cine")
@Validated
@Transactional
public class CineController {

    private final CineService cineService;
    private final CineDtoConverter cineDtoConverter;
    private final PaginationLinkUtils paginationLinkUtils;

    @Operation(summary = "Crear un nuevo cine")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se creó correctamente el cine",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo crear el cine",
                    content = @Content),
    })
    @PostMapping("/")
    public ResponseEntity<GetCineDto> createCine(@Validated @RequestBody CreateCineDto cineDto){
        Cine cine = cineService.createCine(cineDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(cineDtoConverter.convertCineToGetCineDto(cine));
    }

    @Operation(summary = "Muestra todos los cines")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todos los cines",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de cines está vacía",
                    content = @Content),
    })
    @GetMapping("/")
    public ResponseEntity<Page<GetCineDto>> findAllCines(@PageableDefault(size = 10, page = 0)Pageable pageable, HttpServletRequest request){
        Page<Cine> c = cineService.findAllCines(pageable);
        Page<GetCineDto> res = c.map(cineDtoConverter::convertCineToGetCineDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }

    @Operation(summary = "Muestra un cine por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se mostró correctamente el cine",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No existe el cine",
                    content = @Content),
    })
    @GetMapping("/{id}")
    public ResponseEntity<GetCineDto> findById(@PathVariable Long id, Cine c){
        Optional<Cine> cine = cineService.findById(id, c);
        return ResponseEntity.ok().body(cineDtoConverter.convertCineToGetCineDto(cine.get()));

    }


    @Operation(summary = "Editar un cine por su id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se editó correctamente el cine",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No existe un cine con ese id",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public ResponseEntity<GetCineDto> edit(@RequestBody CreateCineDto cineDto, @PathVariable Long id){
        Cine nuevoC = cineService.edit(cineDto, id);

        GetCineDto nuevoCDto = cineDtoConverter.convertCineToGetCineDto(nuevoC);
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevoCDto);
    }
}
