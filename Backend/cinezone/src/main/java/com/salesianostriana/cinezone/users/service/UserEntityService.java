package com.salesianostriana.cinezone.users.service;


import com.salesianostriana.cinezone.error.exception.ExistingUserException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.services.GoogleCloudStorageService;
import com.salesianostriana.cinezone.services.base.BaseService;
import com.salesianostriana.cinezone.services.base.StorageService;
import com.salesianostriana.cinezone.users.dto.CreateUserDto;
import com.salesianostriana.cinezone.users.dto.EditUserDto;
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
    private final GoogleCloudStorageService storageServiceGoogle;
    private final StorageService storageService;

    public Optional<UserEntity> findByUsername(String userName){
        return this.repositorio.findFirstByEmail(userName);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return (UserDetails) this.repositorio.findFirstByEmail(email)
                .orElseThrow(()-> new UsernameNotFoundException(email + " no se encontró"));
    }

    /**
     * Metodo que crea un usuario nuevo, sirve tanto para administrador o usuario
     * @param newUSer
     * @param role
     * @return El nuevo usuario guardado o una exception porque un usuario con ese email ya existe
     * @throws Exception
     */
    public UserEntity save(CreateUserDto newUSer, UserRole role) throws Exception {


        if(repositorio.findFirstByEmail(newUSer.getEmail()).isEmpty()){

            UserEntity user = UserEntity.builder()
                    .password(passwordEncoder.encode(newUSer.getPassword()))
                    .nombre(newUSer.getNombre())
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

    /**
     * Metodo que edita al usuario propietario
     * @param userDto
     * @param usuario
     * @return el nuevo valor del usuario
     */
    public UserEntity edit(EditUserDto userDto, UserEntity usuario){
        Optional<UserEntity> u = repositorio.findById(usuario.getId());
            UserEntity newU = u.get();
            newU.setNombre(userDto.getNombre());
            newU.setEmail(userDto.getEmail());
            newU.setFechaNacimiento(userDto.getFechaNacimiento());
            newU.setTelefono(userDto.getTelefono());

            return repositorio.save(newU);

    }

    /**
     * Metodo para buscar a un usuario por su id, nos servira para metodos de otros servicios
     * @param id
     * @return al usuario si lo encuentra, de lo contrario una exception de entidad no encontrada
     */
    public UserEntity find(UUID id){
        Optional<UserEntity> optionalUser = repositorio.findById(id);

        if(optionalUser.isPresent()){
            return optionalUser.get();
        }else throw new SingleEntityNotFoundException(UserEntity.class);
    }

    /**
     * Metodo que trae todos los usuarios
     * @param pageable
     * @return lista a todos los usuarios de forma paginable
     */
    public Page <UserEntity> findAllUsuarios(Pageable pageable){
            return repositorio.findAllUsuarios(pageable);
    }

    /**
     * Metodo para buscar a un usuario por su id
     * @param id
     * @param user
     * @return El usuario encontrado o en caso de que no exista entidad no encontrada
     */
    public Optional<UserEntity> findUserById(UUID id, UserEntity user){
        if(user.getId().equals(id)){
            Optional<UserEntity> usuario = findById(id);
            return usuario;
        }else{
            throw new EntityNotFoundException("El usuario no existe");
        }
    }

    /*
    public Optional<?> deleteUserById(UUID id, UserEntity user) {
        Optional<UserEntity> usuario = findById(id);
        if(usuario.isPresent()){
            return deleteById(id);
        }else{
            throw new EntityNotFoundException("No se encontró ningún usuario con ese id");
        }

    }
     */


}
