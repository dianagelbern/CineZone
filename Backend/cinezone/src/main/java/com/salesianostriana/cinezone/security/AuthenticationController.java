package com.salesianostriana.cinezone.security;

import com.salesianostriana.cinezone.security.dto.JwtUserResponse;
import com.salesianostriana.cinezone.security.dto.LoginDto;
import com.salesianostriana.cinezone.security.jwt.JwtProvider;
import com.salesianostriana.cinezone.users.model.UserEntity;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
//@CrossOrigin(origins = "http://localhost:4200/")
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;

    @Operation(summary = "Logear un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se logeó correctamente",
                    content = { @Content(mediaType =  "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo realizar el login con éxito",
                    content = @Content),
    })
    @PostMapping("/auth/login")
    public ResponseEntity<?> login(@RequestBody LoginDto loginDto){
        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginDto.getEmail(), loginDto.getPassword()
                        )
                );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtProvider.generateToken(authentication);
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(convertUserToJwtUserResponse(user, jwt));
    }

    @Operation(summary = "Identificar el usuario logeado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se identificó correctamente",
                    content = { @Content(mediaType =  "aplication/json",
                            schema = @Schema(implementation = UserEntity.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se pudo realizar la identificación",
                    content = @Content),
    })
    @GetMapping("/me")
    public ResponseEntity<?> quienSoyYo(@AuthenticationPrincipal UserEntity user){
        return ResponseEntity.ok(convertUserToJwtUserResponse(user, null));
    }

    private JwtUserResponse convertUserToJwtUserResponse(UserEntity user, String jwt){
        return JwtUserResponse.builder()
                .id(user.getId())
                .nombre(user.getNombre())
                .email(user.getEmail())
                .telefono(user.getTelefono())
                .fechaNacimiento(user.getFechaNacimiento())
                .role(user.getRole().name())
                .token(jwt)
                .build();
    }
}
