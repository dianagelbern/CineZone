package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.reservadto.CreateReservaDto;
import com.salesianostriana.cinezone.dto.reservadto.GetReservaDto;
import com.salesianostriana.cinezone.dto.reservadto.ReservaDtoConverter;
import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.services.ReservaService;
import com.salesianostriana.cinezone.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.transaction.Transactional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/reserva")
public class ReservaController {


    private final ReservaService reservaService;
    private final ReservaDtoConverter reservaDtoConverter;

    @PostMapping
    public ResponseEntity<GetReservaDto> reservarAsiento(@RequestBody CreateReservaDto reservaDto, @AuthenticationPrincipal UserEntity currentUser){

        Reserva newReserva = reservaService.createReserva(reservaDto, currentUser);
        GetReservaDto getReservaDto = reservaDtoConverter.convertToGetReservaDto(newReserva);
        return ResponseEntity.status(HttpStatus.CREATED).body(getReservaDto);

    }

}
