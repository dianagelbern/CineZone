package com.salesianostriana.cinezone.users.dto;

import com.salesianostriana.cinezone.users.model.UserEntity;
import org.springframework.stereotype.Component;

@Component
public class UserDtoConverter {
    public GetUserDto convertUserToGetUserDto(UserEntity u){
        return GetUserDto.builder()
                .id(u.getId())
                .nombre(u.getNombre())
                .email(u.getEmail())
                .fechaNacimiento(u.getFechaNacimiento())
                .password(u.getPassword())
                .telefono(u.getTelefono()).build();
    }
}
