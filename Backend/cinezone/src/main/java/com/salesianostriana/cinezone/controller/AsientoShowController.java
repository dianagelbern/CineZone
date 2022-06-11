package com.salesianostriana.cinezone.controller;

import com.salesianostriana.cinezone.dto.asientoshowdto.AsientosShowDtoConverter;
import com.salesianostriana.cinezone.dto.asientoshowdto.GetAsientosShowDto;
import com.salesianostriana.cinezone.dto.asientoshowdto.GetAsientosShowDtoResponse;
import com.salesianostriana.cinezone.dto.showdto.GetShowDto;
import com.salesianostriana.cinezone.dto.showdto.ShowDtoConverter;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.services.AsientosShowService;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/asientoShow")
public class AsientoShowController {

    private final AsientosShowService asientosShowService;
    private final ShowDtoConverter showDtoConverter;
    private final AsientosShowDtoConverter asientosShowDtoConverter;

    private final PaginationLinkUtils paginationLinkUtils;

    @Operation(summary = "Muestra todos los asientos de una sala relacionados con un show")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todos los shows",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de shows está vacía",
                    content = @Content),
    })
    @GetMapping("/show/{id}")
    public GetAsientosShowDtoResponse findAllAsientosByShow(@PathVariable Long id){


        return GetAsientosShowDtoResponse.builder()
                .result(asientosShowService.findAllAsientosByShowId(id).stream().map(asientosShowDtoConverter::convertToGetAsientosShowDto).collect(Collectors.toList()))
                .build();
    }

}
