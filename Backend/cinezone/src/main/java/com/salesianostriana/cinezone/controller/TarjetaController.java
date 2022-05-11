package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.tarjetadto.CreateTarjetaDto;
import com.salesianostriana.cinezone.dto.tarjetadto.GetTarjetaDto;
import com.salesianostriana.cinezone.dto.tarjetadto.TarjetaDtoConverter;
import com.salesianostriana.cinezone.models.Tarjeta;
import com.salesianostriana.cinezone.services.TarjetaService;
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
@RequestMapping("/tarjeta")
@Validated
@Transactional
public class TarjetaController {

    private final TarjetaService tarjetaService;
    private final TarjetaDtoConverter tarjetaDtoConverter;


    @PostMapping("/")
    public ResponseEntity<GetTarjetaDto> createTarjeta(@RequestBody CreateTarjetaDto tarjetaDto, @AuthenticationPrincipal UserEntity currentUser){
        Tarjeta newTarjeta = tarjetaService.createTarjeta(tarjetaDto, currentUser);
        GetTarjetaDto getTarjetaDto = tarjetaDtoConverter.convertTarjetaToGetTarjetaDto(newTarjeta);
        return ResponseEntity.status(HttpStatus.CREATED).body(getTarjetaDto);
    }
}
