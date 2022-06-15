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

    public UserEntity save(CreateUserDto newUSer, UserRole role) throws Exception {


        if(repositorio.findFirstByEmail(newUSer.getEmail()).isEmpty()){
            //String url = storageService.uploadFile(image);

            /*
            String filename = storageService.store(file);
            BufferedImage original = ImageIO.read(file.getInputStream());
            BufferedImage reescalada = storageService.resizeImage(original, 128, 128);

            ImageIO.write(reescalada, "jpg", Files.newOutputStream(storageService.load(filename)));

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();
             */

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

    public UserEntity edit(EditUserDto userDto, UserEntity usuario){
        Optional<UserEntity> u = repositorio.findById(usuario.getId());
            UserEntity newU = u.get();
            newU.setNombre(userDto.getNombre());
            newU.setEmail(userDto.getEmail());
            newU.setFechaNacimiento(userDto.getFechaNacimiento());
            newU.setTelefono(userDto.getTelefono());

            return repositorio.save(newU);

    }

    public UserEntity find(UUID id){
        Optional<UserEntity> optionalUser = repositorio.findById(id);

        if(optionalUser.isPresent()){
            return optionalUser.get();
        }else throw new SingleEntityNotFoundException(UserEntity.class);
    }

    public Page <UserEntity> findAllUsuarios(Pageable pageable){
            return repositorio.findAllUsuarios(pageable);
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
