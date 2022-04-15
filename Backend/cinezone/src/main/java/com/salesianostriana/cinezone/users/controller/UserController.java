package com.salesianostriana.cinezone.users.controller;

import com.salesianostriana.cinezone.users.dto.CreateUserDto;
import com.salesianostriana.cinezone.users.dto.GetUserDto;
import com.salesianostriana.cinezone.users.dto.UserDtoConverter;
import com.salesianostriana.cinezone.users.model.UserEntity;
import com.salesianostriana.cinezone.users.model.UserRole;
import com.salesianostriana.cinezone.users.service.UserEntityService;
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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter userDtoConverter;
    private final PaginationLinkUtils paginationLinkUtils;

    @Operation(summary = "Registrar un nuevo usuario administrador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se registró correctamente el usuario administrador",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo registrar el usuario",
                    content = @Content),
    })
    @PostMapping("/auth/register/admin")
    public ResponseEntity<GetUserDto> nuevoUsuarioAdmin(@Valid @RequestPart("admin") CreateUserDto newUser, @RequestPart("image") MultipartFile image){

        UserEntity saved = userEntityService.save(newUser, UserRole.ADMIN, image);

            return ResponseEntity.status(HttpStatus.CREATED).body(userDtoConverter.convertUserToGetUserDto(saved));

    }

    @Operation(summary = "Registrar un nuevo usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se registró correctamente el usuario",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo registrar el usuario",
                    content = @Content),
    })
    @PostMapping("/auth/register/usuario")
    public ResponseEntity<GetUserDto> nuevoUsuario(@Valid @RequestPart("user") CreateUserDto newUser, @RequestPart("image") MultipartFile image){

        UserEntity saved = userEntityService.save(newUser, UserRole.USER, image);

        return ResponseEntity.status(HttpStatus.CREATED).body(userDtoConverter.convertUserToGetUserDto(saved));

    }


    @Operation(summary = "Lista todos los usuarios")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan correctamente todos los usuarios",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "La lista de usuarios está vacía",
                    content = @Content),
    })
    @GetMapping("/usuarios")
    public ResponseEntity<Page<GetUserDto>> findAllUsuarios(@PageableDefault(size = 10, page = 0) Pageable pageable, HttpServletRequest request){
        Page<UserEntity> u = userEntityService.findAllUsuarios(pageable);

            Page<GetUserDto> resultado = u.map(userDtoConverter::convertUserToGetUserDto);
            UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
            return ResponseEntity.ok().header("link", paginationLinkUtils.createLinkHeader(resultado, uriBuilder)).body(resultado);

    }

    @Operation(summary = "Se busca un usuario por su ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha encontrado el usuario con ese ID",
                    content = { @Content(mediaType = "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentra el usuario con ese ID",
                    content = @Content),
    })
    @GetMapping("/usuario/{id}")
    public ResponseEntity<GetUserDto> findUsuarioById(@PathVariable UUID id, @AuthenticationPrincipal UserEntity userEntity){
            Optional<UserEntity> user = userEntityService.findUserById(id, userEntity);
            return ResponseEntity.ok().body(userDtoConverter.convertUserToGetUserDto(user.get()));
    }

    @Operation(summary = "Borrar un usuario por su id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se eliminó correctamente de la lista",
                    content = { @Content(mediaType =  "application/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentra algún usuario con ese id",
                    content = @Content),
    })
    @DeleteMapping("/usuario/{id}")
    public ResponseEntity<?> deleteUsuario(@PathVariable UUID id, @AuthenticationPrincipal UserEntity userEntity){
            userEntityService.deleteUserById(id, userEntity);
            return ResponseEntity.noContent().build();

    }
}
