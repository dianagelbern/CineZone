package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.tarjetadto.CreateTarjetaDto;
import com.salesianostriana.cinezone.dto.tarjetadto.GetTarjetaDto;
import com.salesianostriana.cinezone.dto.tarjetadto.TarjetaDtoConverter;
import com.salesianostriana.cinezone.models.Tarjeta;
import com.salesianostriana.cinezone.services.TarjetaService;
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
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/tarjeta")
@Validated
@Transactional
public class TarjetaController {

    private final TarjetaService tarjetaService;
    private final TarjetaDtoConverter tarjetaDtoConverter;
    private final PaginationLinkUtils paginationLinkUtils;

    @Operation(summary = "Crear una nueva tarjeta")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se creó correctamente la tarjeta",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo crear la tarjeta",
                    content = @Content),
    })
    @PostMapping("/")
    public ResponseEntity<GetTarjetaDto> createTarjeta(@RequestBody CreateTarjetaDto tarjetaDto, @AuthenticationPrincipal UserEntity currentUser){
        Tarjeta newTarjeta = tarjetaService.createTarjeta(tarjetaDto, currentUser);
        GetTarjetaDto getTarjetaDto = tarjetaDtoConverter.convertTarjetaToGetTarjetaDto(newTarjeta);
        return ResponseEntity.status(HttpStatus.CREATED).body(getTarjetaDto);
    }

    @Operation(summary = "Muestra todas las tarjetas de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todas las tarjetas",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de tarjetas está vacía",
                    content = @Content),
    })
    @GetMapping("/")
    public ResponseEntity<Page<GetTarjetaDto>> findAllTarjetasByUser(@PageableDefault(size = 10, page = 0) Pageable pageable, HttpServletRequest request, @AuthenticationPrincipal UserEntity currentUser){
        Page<Tarjeta> t = tarjetaService.findAllTarjetasByUser(pageable, currentUser);

        Page<GetTarjetaDto> res = t.map(tarjetaDtoConverter::convertTarjetaToGetTarjetaDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }
}
