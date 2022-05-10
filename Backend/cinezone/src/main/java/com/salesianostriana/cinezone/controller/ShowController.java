package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.showdto.CreateShowDto;
import com.salesianostriana.cinezone.dto.showdto.GetShowDto;
import com.salesianostriana.cinezone.dto.showdto.ShowDtoConverter;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.services.ShowService;
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
@RequestMapping("/show")
public class ShowController {

    private final ShowService showService;
    private final ShowDtoConverter showDtoConverter;

    @PostMapping()
    public ResponseEntity<GetShowDto> createShow(@RequestBody CreateShowDto newShow){

        Show show = showService.createShow(newShow);

        return ResponseEntity.status(HttpStatus.CREATED).body(showDtoConverter.convertToGetShowDto(show));
    }




}
