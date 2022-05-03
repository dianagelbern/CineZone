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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.transaction.Transactional;

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


}
