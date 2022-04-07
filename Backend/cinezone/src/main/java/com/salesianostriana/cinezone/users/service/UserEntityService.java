package com.salesianostriana.cinezone.users.service;


import com.salesianostriana.cinezone.services.base.BaseService;
import com.salesianostriana.cinezone.users.dto.CreateUserDto;
import com.salesianostriana.cinezone.users.model.UserEntity;
import com.salesianostriana.cinezone.users.model.UserRole;
import com.salesianostriana.cinezone.users.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;
@Service("userDetailsService")
@RequiredArgsConstructor
public class UserEntityService extends BaseService <UserEntity, UUID, UserEntityRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;

    public Optional<UserEntity> findByUsername(String userName){
        return this.repositorio.findFirstByEmail(userName);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return (UserDetails) this.repositorio.findFirstByEmail(email)
                .orElseThrow(()-> new UsernameNotFoundException(email + " no se encontró"));
    }

    public UserEntity save(CreateUserDto newUSer, UserRole role){
        UserEntity user = UserEntity.builder()
                .password(passwordEncoder.encode(newUSer.getPassword()))
                .nombre(newUSer.getNombre())
                .avatar(newUSer.getAvatar())
                .email(newUSer.getEmail())
                .fechaNacimiento(newUSer.getFechaNacimiento())
                .telefono(newUSer.getTelefono())
                .role(role)
                .build();
        return save(user);
    }


    public Page <UserEntity> findAllUsuarios(Pageable pageable){
        return repositorio.findAllUsuarios(pageable);
    }
}
