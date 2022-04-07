package com.salesianostriana.cinezone.security.dto;

import com.salesianostriana.cinezone.users.dto.UserDtoConverter;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class JwtUserResponse extends UserDtoConverter {

    private UUID id;
    private String nombre, email, telefono, password, avatar, fechaNacimiento, role, token;

}
