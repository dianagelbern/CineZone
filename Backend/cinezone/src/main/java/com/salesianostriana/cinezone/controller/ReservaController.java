package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.reservadto.CreateReservaDto;
import com.salesianostriana.cinezone.dto.reservadto.GetReservaDto;
import com.salesianostriana.cinezone.dto.reservadto.ReservaDtoConverter;
import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.services.ReservaService;
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
@RequestMapping("/reserva")
public class ReservaController {


    private final ReservaService reservaService;
    private final ReservaDtoConverter reservaDtoConverter;
    private final PaginationLinkUtils paginationLinkUtils;

    @Operation(summary = "Crear una nueva reserva")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se creó correctamente la reserva",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Reserva.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo crear la reserva",
                    content = @Content),
    })
    @PostMapping
    public ResponseEntity<GetReservaDto> reservarAsiento(@RequestBody CreateReservaDto reservaDto, @AuthenticationPrincipal UserEntity currentUser){

        Reserva newReserva = reservaService.createReserva(reservaDto, currentUser.getId());
        GetReservaDto getReservaDto = reservaDtoConverter.convertToGetReservaDto(newReserva);
        return ResponseEntity.status(HttpStatus.CREATED).body(getReservaDto);

    }

    @Operation(summary = "Muestra todas las reservas de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todas las reservas",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = Reserva.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de reservas está vacía",
                    content = @Content),
    })
    @GetMapping("/")
    public ResponseEntity<Page<GetReservaDto>> findAllReservasByUser(@PageableDefault(size = 10, page = 0) Pageable pageable, HttpServletRequest request, @AuthenticationPrincipal UserEntity currentUser){
        Page<Reserva> r = reservaService.findAllReservasByUser(pageable, currentUser);
        Page<GetReservaDto> res = r.map(reservaDtoConverter::convertToGetReservaDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }
}
