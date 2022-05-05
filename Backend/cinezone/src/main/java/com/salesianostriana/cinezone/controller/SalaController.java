package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.saladto.GetSalaDto;
import com.salesianostriana.cinezone.dto.saladto.SalaDtoConverter;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.services.SalaService;
import com.salesianostriana.cinezone.util.PaginationLinkUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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

    @GetMapping("/{id}/cineSala")
    public ResponseEntity<Page<GetSalaDto>> findAllSalasByCineId(@PageableDefault(size = 11, page = 0)Pageable pageable, HttpServletRequest request, @PathVariable Long id){
        Page<Sala> s = salaService.findAllSalasByCine(pageable, id);
        Page<GetSalaDto> res = s.map(salaDtoConverter::convertSalaToGetSalaDto);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
        return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(res, uriComponentsBuilder)).body(res);
    }
}
