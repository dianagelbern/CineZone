package com.salesianostriana.cinezone.users.dto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GetUserDto {
    private UUID id;
    private String nombre, email, telefono, password, fechaNacimiento;

}
