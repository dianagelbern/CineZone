package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.showdto.CreateShowDto;
import com.salesianostriana.cinezone.dto.showdto.GetShowDto;
import com.salesianostriana.cinezone.dto.showdto.ShowDtoConverter;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.services.ShowService;
import com.salesianostriana.cinezone.util.PaginationLinkUtils;
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

    @PostMapping()
    public ResponseEntity<GetShowDto> createShow(@RequestBody CreateShowDto newShow){

        Show show = showService.createShow(newShow);

        return ResponseEntity.status(HttpStatus.CREATED).body(showDtoConverter.convertToGetShowDto(show));
    }


    @GetMapping("/movie/{id_movie}/date/{fecha}")
    public ResponseEntity<Page<GetShowDto>> findAllShowsByMovieAndDate(@PageableDefault(size = 10, page = 0) Pageable pageable, HttpServletRequest request, @PathVariable Long id_movie, @PathVariable String fecha){

        LocalDate date = LocalDate.parse(fecha);
        Page<Show> s = showService.finAllShowsByMovie(pageable ,id_movie, date);
        Page<GetShowDto> res = s.map(showDtoConverter::convertToGetShowDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());

        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }

}
