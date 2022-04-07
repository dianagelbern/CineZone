package com.salesianostriana.cinezone.users.dto;

import com.salesianostriana.cinezone.validation.annotations.PasswordMatch;
import lombok.*;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@PasswordMatch(passwordField  = "password", verifyPasswordField  = "password2", message = "{fieldsvalue.not.match}" )
public class CreateUserDto {

    @NotBlank(message = "{userName.notBlank}")
    private String nombre;

    private String telefono, password, password2, avatar, fechaNacimiento;


    @Email
    private String email;
}
