package com.salesianostriana.cinezone.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.transaction.Transactional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/tarjeta")
@Validated
@Transactional
public class TarjetaController {
}
