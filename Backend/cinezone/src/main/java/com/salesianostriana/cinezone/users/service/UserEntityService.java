package com.salesianostriana.cinezone.users.service;


import com.salesianostriana.cinezone.error.exception.ExistingUserException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.services.GoogleCloudStorageService;
import com.salesianostriana.cinezone.services.base.BaseService;
import com.salesianostriana.cinezone.users.dto.CreateUserDto;
import com.salesianostriana.cinezone.users.model.UserEntity;
import com.salesianostriana.cinezone.users.model.UserRole;
import com.salesianostriana.cinezone.users.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;
import java.util.UUID;
@Service("userDetailsService")
@RequiredArgsConstructor
public class UserEntityService extends BaseService <UserEntity, UUID, UserEntityRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final GoogleCloudStorageService storageService;

    public Optional<UserEntity> findByUsername(String userName){
        return this.repositorio.findFirstByEmail(userName);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return (UserDetails) this.repositorio.findFirstByEmail(email)
                .orElseThrow(()-> new UsernameNotFoundException(email + " no se encontró"));
    }

    public UserEntity save(CreateUserDto newUSer, UserRole role, MultipartFile image){


        if(repositorio.findFirstByEmail(newUSer.getEmail()).isEmpty()){
            String url = storageService.uploadFile(image);

            UserEntity user = UserEntity.builder()
                    .password(passwordEncoder.encode(newUSer.getPassword()))
                    .nombre(newUSer.getNombre())
                    .avatar(url)
                    .email(newUSer.getEmail())
                    .fechaNacimiento(newUSer.getFechaNacimiento())
                    .telefono(newUSer.getTelefono())
                    .role(role)
                    .build();

            return save(user);
        }else{
            throw new ExistingUserException();
        }


    }


    public Page <UserEntity> findAllUsuarios(Pageable pageable){

        if(repositorio.findAllUsuarios(pageable).isEmpty()){
            throw new ListEntityNotFoundException(UserEntity.class);
        }else{
            return repositorio.findAllUsuarios(pageable);
        }
    }


    public Optional<UserEntity> findUserById(UUID id, UserEntity user){
        if(user.getId().equals(id)){
            Optional<UserEntity> usuario = findById(id);
            return usuario;
        }else{
            throw new EntityNotFoundException("El usuario no existe");
        }
    }


    public Optional<?> deleteUserById(UUID id, UserEntity user) {
        Optional<UserEntity> usuario = findById(id);
        if(usuario.isPresent()){
            return deleteById(id);
        }else{
            throw new EntityNotFoundException("No se encontró ningún usuario con ese id");
        }

    }


}
