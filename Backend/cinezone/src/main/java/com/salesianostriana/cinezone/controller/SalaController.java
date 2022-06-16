package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.saladto.GetSalaDto;
import com.salesianostriana.cinezone.dto.saladto.SalaDtoConverter;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.services.SalaService;
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
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/sala")
@Validated
@Transactional
public class SalaController {

    private final SalaService salaService;
    private final SalaDtoConverter salaDtoConverter;
    private final PaginationLinkUtils paginationLinkUtils;


    @Operation(summary = "Muestra todas las salas relacionadas con un cine")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todas las salas",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Sala.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de salas está vacía",
                    content = @Content),
    })
    @GetMapping("/{id}/cineSala")
    public ResponseEntity<Page<GetSalaDto>> findAllSalasByCineId(@PageableDefault(size = 11, page = 0)Pageable pageable, HttpServletRequest request, @PathVariable Long id){
        Page<Sala> s = salaService.findAllSalasByCine(pageable, id);
        Page<GetSalaDto> res = s.map(salaDtoConverter::convertSalaToGetSalaDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }


    @Operation(summary = "Muestra todas las salas relacionadas con un cine")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todas las salas",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Sala.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de salas está vacía",
                    content = @Content),
    })
    @GetMapping("/{id}/cineSalaDetail")
    public ResponseEntity<Page<GetSalaDto>> findAllSalasByCineIdDetails(@PageableDefault(size = 11, page = 0)Pageable pageable, HttpServletRequest request, @PathVariable Long id){
        Page<Sala> s = salaService.findAllSalasByCineDetails(pageable, id);
        Page<GetSalaDto> res = s.map(salaDtoConverter::convertSalaToGetSalaDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }

    @Operation(summary = "Elimina una sala por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se eliminó correctamente la sala",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Sala.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No existe la sala",
                    content = @Content),
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteById(@PathVariable Long id, Sala sala){
        salaService.deleteById(id, sala);
        return ResponseEntity.noContent().build();
    }
}
