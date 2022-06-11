package com.salesianostriana.cinezone.users.dto;

import lombok.*;

import javax.validation.constraints.Email;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EditUserDto {
    private String nombre;

    private String telefono, fechaNacimiento;

    private String email;
}
